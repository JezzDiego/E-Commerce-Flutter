import 'package:araplantas_mobile/view/index.dart';
import 'package:araplantas_mobile/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IntermediateViewModel extends StatefulWidget {
  const IntermediateViewModel({Key? key}) : super(key: key);

  @override
  State<IntermediateViewModel> createState() => _IntermediateViewModelState();
}

class _IntermediateViewModelState extends State<IntermediateViewModel> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const Index();
          } else if (snapshot.hasError) {
            return const Center(child: Text("Algo deu errado"));
          } else {
            return const Login();
          }
        });
  }
}
