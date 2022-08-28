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
