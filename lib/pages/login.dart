import 'dart:convert';

import 'package:araplantas_mobile/components/initial_screen.dart';
import 'package:araplantas_mobile/data/auth_api.dart';
import 'package:araplantas_mobile/main.dart';
import 'package:araplantas_mobile/models/user.dart' as UserModel;
import 'package:araplantas_mobile/pages/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool loading = false;

  _logIn() async {
    setState(() {
      loading = true;
    });

    try {
      // await FirebaseAuth.instance.signInWithEmailAndPassword(
      //     email: emailController.text, password: passwordController.text);
      var response =
          await AuthAPI().login(emailController.text, passwordController.text);
      if (response.statusCode != 200) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Erro"),
                  titleTextStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                  content: Text(verifyStatusCode(response.statusCode)),
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
      } else {
        String authToken = jsonDecode(response.body)["token"]["token"];
        UserModel.User user =
            UserModel.User.fromJson(jsonDecode(response.body)["user"]);
        user.authToken = authToken;
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return InitialScreen(
              user: user,
            );
          },
        ));
      }
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5ecde0),
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
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.9,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Campo obrigatório";
                          }
                          return null;
                        },
                        controller: emailController,
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
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Campo obrigatório";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 50),
                      if (!loading)
                        Center(
                          child: SizedBox(
                            width: 240,
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                _logIn();
                              },
                              child: const Text("Login",
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
                          const Text("Não tem uma conta? "),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return const SignUp();
                                  },
                                ));
                              },
                              child: const Text(
                                "Cadastre-se",
                                style: TextStyle(
                                  color: Color(0xff5ecde0),
                                ),
                              ))
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

buildHorizontalLine() {
  return const Icon(
    Icons.horizontal_rule,
    color: Color.fromARGB(255, 255, 235, 105),
    size: 80,
  );
}

String verifyContent(String e) {
  String message = "Algo deu errado ao tentar fazer login";
  switch (e) {
    case "invalid-email":
      message = "O email digitado é inválido";
      break;

    case "user-disabled":
      message = "Usuário desabilitado";
      break;

    case "user-not-found":
      message = "Não há usuário cadastrado com o email informardo";
      break;

    case "wrong-password":
      message = "Senha incorreta, verifique tente novamente";
      break;
    default:
      break;
  }
  return message;
}

String verifyStatusCode(int s) {
  String message = "Algo deu errado ao tentar fazer login";
  switch (s) {
    case 401:
      message = "Email ou senha incorretos";
      break;

    case 500:
      message = "Erro interno do servidor";
      break;

    default:
      break;
  }
  return message;
}

String verifyGoogleContent(String e) {
  String message = "Algo deu errado ao tentar fazer login";
  switch (e) {
    case "account-exists-with-different-credential":
      message = "Essa conta existe, porém com credenciais diferentes";
      break;

    case "invalid-credentiald":
      message = "Credenciais inválidas";
      break;

    case "operation-not-allowed":
      message = "A conta com as credenciais informadas não está ativa";
      break;

    case "user-disabled":
      message = "Usuário desativado";
      break;

    case "user-not-found":
      message = "Não existe usuário para o email informado";
      break;

    case "wrong-password":
      message = "Senha incorreta";
      break;

    case "invalid-verification-code":
      message = "Código de verificação inválido";
      break;

    case "invalid-verification-id":
      message = "ID de verificação inválido";
      break;
    default:
      break;
  }

  return message;
}
