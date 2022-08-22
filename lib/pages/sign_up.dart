import 'package:araplantas_mobile/components/initial_screen.dart';
import 'package:araplantas_mobile/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  bool loading = false;

  _logIn() async {
    setState(() {
      loading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const InitialScreen();
        },
      ));
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Erro"),
                titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
                content: Text(verifyContent(e.code)),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 235, 105),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 50),
            Center(
              heightFactor: 3,
              child: Text(
                "Sign Up",
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
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
                        "Nome",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                        child: buildTextFormField(
                            false, nameController, TextInputType.name),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                        child: buildTextFormField(
                            false, emailController, TextInputType.emailAddress),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Celular",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                        child: buildTextFormField(
                            false, numberController, TextInputType.phone),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Senha",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                        child: buildTextFormField(true, passwordController,
                            TextInputType.visiblePassword),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Confirmar Senha",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                        child: buildTextFormField(true, passwordController,
                            TextInputType.visiblePassword),
                      ),
                      const SizedBox(height: 40),
                      if (!loading)
                        Center(
                          child: SizedBox(
                            width: 240,
                            height: 50,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text("Cadastrar",
                                  style: TextStyle(fontSize: 24)),
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 235, 105),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                          ),
                        ),
                      if (loading)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Já tem uma contra? "),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return const Login();
                                  },
                                ));
                              },
                              child: const Text("Login"))
                        ],
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

buildTextFormField(bool obscureText, TextEditingController controller,
    TextInputType keyboardType) {
  return TextFormField(
    obscureText: obscureText,
    keyboardType: keyboardType,
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Campo obrigatório";
      } else if (value.length < 3) {
        return "O campo deve ter mais de 3 caracteres";
      }
      return null;
    },
  );
}
