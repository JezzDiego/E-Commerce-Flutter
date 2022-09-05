import 'package:araplantas_mobile/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  bool loading = false;

  Future _signUp() async {
    setState(() {
      loading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      await FirebaseFirestore.instance.collection('users').add({
        'email': emailController.text,
        'displayName': nameController.text,
        'phoneNumber': numberController.text,
      });

      await showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text("Cadastrado com sucesso"),
                content: const Text(
                    "Sua conta foi criada, agora você pode entrar com suas credenciais"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return const Login();
                          },
                        ));
                      },
                      child: const Text('OK'))
                ],
              )));

      //Navigator.of(context).pop();
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
      backgroundColor: const Color(0xff5ecde0),
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
              height: MediaQuery.of(context).size.height * 0.82,
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
                      const SizedBox(height: 30),
                      const Text(
                        "Nome",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 45,
                        child: buildTextFormField(
                            false, nameController, TextInputType.name),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 45,
                        child: buildTextFormField(
                            false, emailController, TextInputType.emailAddress),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Celular",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 45,
                        child: buildTextFormField(
                            false, numberController, TextInputType.phone),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Senha",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Campo obrigatório";
                            } else if (value.length < 3) {
                              return "O campo deve ter mais de 3 caracteres";
                            } else if (confirmPasswordController.text !=
                                passwordController.text) {
                              return "As senha devem ser iguais";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Confirmar Senha",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Campo obrigatório";
                            } else if (value.length < 3) {
                              return "O campo deve ter mais de 3 caracteres";
                            } else if (confirmPasswordController.text !=
                                passwordController.text) {
                              return "As senha devem ser iguais";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (!loading)
                        Center(
                          child: SizedBox(
                            width: 240,
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  _signUp();
                                }
                              },
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
                          const Text("Já tem uma conta? "),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return const Login();
                                  },
                                ));
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(color: Color(0xff5ecde0)),
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

  String verifyContent(String e) {
    String message = "Ocorreu um erro desconhecido, tente novamente mais tarde";
    switch (e) {
      case 'email-already-in-use':
        message = "Este email já está cadastrado";
        break;

      case 'invalid-email':
        message = "O email que você digitou é inválido";
        break;

      case 'operation-not-allowed':
        message = "Essa operação não é inválida";
        break;

      case 'weak-password':
        message = "A senha que você digitou é muito fraca";
        break;

      default:
        message = "Ocorreu um erro desconhecido, tente novamente mais tarde";
        break;
    }

    return message;
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
