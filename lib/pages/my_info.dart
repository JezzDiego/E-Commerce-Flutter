import 'package:araplantas_mobile/data/user_api.dart';
import 'package:araplantas_mobile/models/adress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:araplantas_mobile/models/user.dart" as UserModel;

class MyInfo extends StatefulWidget {
  final UserModel.User user;
  const MyInfo({Key? key, required this.user}) : super(key: key);

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  final nameCodeContrller = TextEditingController();
  final zipCodeContrller = TextEditingController();
  final streetController = TextEditingController();
  final districtContrller = TextEditingController();
  final houseNumberContrller = TextEditingController();

  bool editAddress = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    nameCodeContrller.text = widget.user.name!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Minhas Informações",
            style: GoogleFonts.inter(),
          ),
          centerTitle: false,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: FutureBuilder<UserModel.User>(
          future: UserApi(authToken: widget.user.authToken!)
              .findById(widget.user.id.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Erro ao carregar as informações",
                  style: GoogleFonts.inter(),
                ),
              );
            } else if (snapshot.hasData) {
              final user = snapshot.data;
              user!.authToken = widget.user.authToken!;
              return ListView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: SizedBox(
                          width: 800,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pessoais",
                                style: GoogleFonts.inter(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 40),
                              editAddress
                                  ? buildTextFieldInfo("Nome",
                                      TextInputType.text, nameCodeContrller)
                                  : buildInfo(
                                      "Nome Completo",
                                      user.name != null
                                          ? "${widget.user.name}"
                                          : "Não cadastrado, recarregue a página para ver as mudanças"),
                              const SizedBox(height: 40),
                              buildInfo("Email", widget.user.email!),
                              const SizedBox(height: 40),
                              Text(
                                "Endereço",
                                style: GoogleFonts.inter(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (editAddress == true) ...[
                                const SizedBox(height: 40),
                                buildTextFieldInfo("CEP", TextInputType.number,
                                    zipCodeContrller),
                                const SizedBox(height: 40),
                                buildTextFieldInfo("Rua", TextInputType.text,
                                    streetController),
                                const SizedBox(height: 40),
                                buildTextFieldInfo("Bairro", TextInputType.text,
                                    districtContrller),
                                const SizedBox(height: 40),
                                buildTextFieldInfo("Número da Casa",
                                    TextInputType.number, houseNumberContrller),
                                const SizedBox(height: 40),
                              ],
                              if (editAddress == false) ...[
                                buildAdress(user.adress),
                              ],
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (loading == false &&
                                      editAddress == true) ...[
                                    SizedBox(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  const Color(0xFFFEE440)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          )),
                                        ),
                                        onPressed: () {
                                          updateUser(
                                              nameCodeContrller.text,
                                              zipCodeContrller.text,
                                              streetController.text,
                                              districtContrller.text,
                                              houseNumberContrller.text);
                                          initState();
                                        },
                                        child: Text(
                                          "Salvar dados",
                                          style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                  if (editAddress == false) ...[
                                    SizedBox(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  const Color(0xFFFEE440)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          )),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            editAddress = true;
                                          });
                                        },
                                        child: Text(
                                          "Editar dados",
                                          style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future updateUser(String name, String zipCode, String street, String district,
      String houseNumber) async {
    setState(() {
      loading = true;
    });
    final response = await UserApi(authToken: widget.user.authToken!)
        .update(widget.user.id.toString(), {
      "name": name,
      "addresses": [
        {
          "zipCode": zipCode,
          "street": street,
          "district": district,
          "houseNumber": houseNumber
        }
      ]
    });
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Sucesso!"),
          content: const Text("Dados atualizados com sucesso"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Erro ao atualizar dados!"),
          content: Text(response.body),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    }
    setState(() {
      loading = false;
    });
  }

  Widget buildAdress(Adress? endereco) {
    if (endereco == null) {
      return Column(children: [
        const SizedBox(height: 40),
        buildInfo("CEP", "Não Cadastrado!"),
        const SizedBox(height: 40),
        buildInfo("Rua", "Não Cadastrado!"),
        const SizedBox(height: 40),
        buildInfo("Bairro", "Não Cadastrado!"),
        const SizedBox(height: 40),
        buildInfo("Número da casa", "Não Cadastrado!"),
        const SizedBox(height: 40),
      ]);
    }
    return Column(
      children: [
        const SizedBox(height: 40),
        buildInfo("CEP", endereco.zipCode),
        const SizedBox(height: 40),
        buildInfo("Rua", endereco.street),
        const SizedBox(height: 40),
        buildInfo("Bairro", endereco.district),
        const SizedBox(height: 40),
        buildInfo("Número da casa", endereco.houseNumber),
        const SizedBox(height: 40),
      ],
    );
  }

  buildTextFieldInfo(String campo, TextInputType textInputType,
      TextEditingController controller) {
    return Container(
      width: 900,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffF5F5F5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              campo,
              style: GoogleFonts.inter(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            TextField(
              controller: controller,
              keyboardType: textInputType,
              style: GoogleFonts.inter(
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

buildInfo(String campo, String info) {
  return Container(
    width: 900,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xffF5F5F5),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            campo,
            style: GoogleFonts.inter(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          Text(
            info,
            style: GoogleFonts.inter(
              fontSize: 22,
            ),
          ),
        ],
      ),
    ),
  );
}
