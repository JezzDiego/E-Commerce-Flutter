import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 235, 105),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 65),
            Center(
              heightFactor: 3.5,
              child: Text(
                "Login",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.722,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Senha",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 70),
                      buildButton(),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildHorizontalLine(),
                          Text("Ou continue com",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              )),
                          buildHorizontalLine(),
                        ],
                      ),
                      Center(
                        child: IconButton(
                            onPressed: () {},
                            icon: const Image(
                              image: AssetImage("images/google.png"),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

buildHorizontalLine() {
  return const Icon(
    Icons.horizontal_rule,
    color: Color.fromARGB(255, 255, 235, 105),
    size: 80,
  );
}

buildButton() {
  return Center(
    child: Container(
      width: 240,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: const Color.fromARGB(255, 255, 235, 105)),
      child: TextButton(
        onPressed: () {},
        child: const Text("Login", style: TextStyle(fontSize: 24)),
        style: TextButton.styleFrom(
            primary: Colors.black,
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.all(16)),
      ),
    ),
  );
}
