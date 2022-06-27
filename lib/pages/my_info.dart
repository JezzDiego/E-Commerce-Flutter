import 'package:flutter/material.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({Key? key}) : super(key: key);

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: const Text("Minhas Informações"),
                centerTitle: false,
                backgroundColor: Colors.blue,
              ),
              body: Padding(
                padding: const EdgeInsets.all(30),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                            width: 800,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Pessoais",
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                buildInfo("Nome Completo", "Luana Silva"),
                                const SizedBox(height: 40),
                                buildInfo("Email", "luana.silva@email.com"),
                                const SizedBox(height: 40),
                                buildInfo("Celular", "9 9123-4567"),
                                const SizedBox(height: 40),
                                const Text("Endereço",
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                                const SizedBox(height: 40),
                                buildInfo("CEP", "57123456"),
                                const SizedBox(height: 40),
                                buildInfo("Celular", "9 9123-4567"),
                                const SizedBox(height: 40),
                                buildInfo("Rua", "Rua das Flores"),
                                const SizedBox(height: 40),
                                buildInfo("Bairro", "Lorem Ipsum"),
                                const SizedBox(height: 40),
                                buildInfo("Número da Casa", "123"),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
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
        children:  [
          Text(campo,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          Text(info,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),

    ),

  );

}


