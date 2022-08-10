import 'package:flutter/material.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({Key? key}) : super(key: key);

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Carrinho'),
            centerTitle: false,
            backgroundColor: Colors.blue,
          ),
          body: ListView(
            children: const [
              Center(
                  child: Text('Itens do carrinho aqui')
              ),
            ],
          ),
        ),
    );
  }
}
