import 'package:araplantas_mobile/components/initial_screen.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                        keyboardType: TextInputType.emailAddress,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Campo obrigatório";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 50),
                      buildButton(context, _formKey, emailController,
                          passwordController),
                      const SizedBox(height: 20),
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

buildButton(
    BuildContext context,
    GlobalKey<FormState> _formKey,
    TextEditingController emailController,
    TextEditingController passwordController) {
  return Center(
    child: SizedBox(
      width: 240,
      height: 50,
      child: TextButton(
        onPressed: () {
          onPressed(context, _formKey, emailController, passwordController);
        },
        child: const Text("Login", style: TextStyle(fontSize: 24)),
        style: TextButton.styleFrom(
          primary: Colors.black,
          backgroundColor: const Color.fromARGB(255, 255, 235, 105),
          padding: const EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
      ),
    ),
  );
}

onPressed(
    BuildContext context,
    GlobalKey<FormState> _formKey,
    TextEditingController emailController,
    TextEditingController passwordController) {
  if (_formKey.currentState!.validate()) {
    String getUser = emailController.text;
    String getPassword = passwordController.text;

    String user = "teste@gmail.com";
    String password = "123456";

    if (user == getUser && password == getPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const InitialScreen();
          },
        ),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Erro"),
                titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
                content: const Text("Usuário ou senha incorretos"),
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
    }
  } else {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Erro"),
              titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
              content: const Text(
                  "Houve um erro ao tentar se conectarverifique se todos os campos foram preenchidos"),
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
  }
}
