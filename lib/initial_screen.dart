import 'package:flutter/material.dart';
import 'footer.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Text('Página Inicial'),
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
