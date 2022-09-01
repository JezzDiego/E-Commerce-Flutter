import 'package:araplantas_mobile/components/adress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({Key? key}) : super(key: key);

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  final user = FirebaseAuth.instance.currentUser!;
  final zipCodeContrller = TextEditingController();
  final streetController = TextEditingController();
  final districtContrller = TextEditingController();
  final houseNumberContrller = TextEditingController();

  bool editAddress = false;
  bool loading = false;

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
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      buildInfo(
                          "Nome Completo",
                          user.displayName != null
                              ? "${user.displayName}"
                              : "Não cadastrado"),
                      const SizedBox(height: 40),
                      buildInfo("Email", user.email!),
                      const SizedBox(height: 40),
                      buildInfo(
                          "Celular",
                          user.phoneNumber == null
                              ? "Não cadastrado"
                              : "${user.phoneNumber}"),
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
                        buildTextFieldInfo(
                            "CEP", TextInputType.number, zipCodeContrller),
                        const SizedBox(height: 40),
                        buildTextFieldInfo(
                            "Rua", TextInputType.text, streetController),
                        const SizedBox(height: 40),
                        buildTextFieldInfo(
                            "Bairro", TextInputType.text, districtContrller),
                        const SizedBox(height: 40),
                        buildTextFieldInfo("Número da Casa",
                            TextInputType.number, houseNumberContrller),
                        const SizedBox(height: 40),
                      ],
                      if (editAddress == false) ...[
                        FutureBuilder<Adress?>(
                            future: readAdress(),
                            builder: ((context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text("Algo deu errado");
                              } else if (snapshot.hasData) {
                                final adress = snapshot.data;
                                return adress == null
                                    ? buildInfo("Rua", "Não cadastrado")
                                    : buildAdress(adress);
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            })),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (loading == false && editAddress == true) ...[
                            SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFFFEE440)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                                ),
                                onPressed: () {
                                  createAdress(
                                      zipCodeContrller.text,
                                      streetController.text,
                                      districtContrller.text,
                                      houseNumberContrller.text);
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
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFFFEE440)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
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
      ),
    );
  }

  Future<Adress?> readAdress() async {
    final docAdress =
        FirebaseFirestore.instance.collection('adresses').doc(user.uid);

    final snapshot = await docAdress.get();

    if (snapshot.exists) {
      return Adress.fromJson(snapshot.data()!);
    } else {
      return Adress(
          id: 'erro',
          zipCode: 'Não cadastrado',
          street: 'Não cadastrado',
          district: 'Não cadastrado',
          houseNumber: 'Não cadastrado');
    }
  }

  Widget buildAdress(Adress endereco) {
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

  Future createAdress(String zipCode, String street, String district,
      String houseNumber) async {
    setState(() {
      loading = true;
      editAddress = false;
    });
    try {
      final docAdress =
          FirebaseFirestore.instance.collection('adresses').doc(user.uid);

      final adress = Adress(
          id: docAdress.id,
          zipCode: zipCode,
          street: street,
          district: district,
          houseNumber: houseNumber);
      await docAdress.set(adress.toJson());
    } on FirebaseException catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(e.toString()),
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
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(e.toString()),
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
    } finally {
      setState(() {
        loading = false;
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Sucesso"),
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
