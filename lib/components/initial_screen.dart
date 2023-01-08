import 'package:araplantas_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'footer.dart';

class InitialScreen extends StatefulWidget {
  final User user;
  const InitialScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Página Inicial'),
      ),
      bottomNavigationBar: Footer(user: widget.user),
    );
  }
}
