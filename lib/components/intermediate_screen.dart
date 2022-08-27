import 'package:araplantas_mobile/components/initial_screen.dart';
import 'package:araplantas_mobile/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IntermediateScreen extends StatefulWidget {
  const IntermediateScreen({Key? key}) : super(key: key);

  @override
  State<IntermediateScreen> createState() => _IntermediateScreenState();
}

class _IntermediateScreenState extends State<IntermediateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return const InitialScreen();
            } else if (snapshot.hasError) {
              return const Center(child: Text("Algo deu errado"));
            } else {
              return const Login();
            }
          }),
    );
  }
}
