import 'package:araplantas_mobile/components/cart_item_card.dart';
import 'package:flutter/material.dart';
import '../components/item.dart';
import '../components/saved_item_card.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({Key? key}) : super(key: key);

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  Item item1 = Item(
      name: 'Mochila Muito Top',
      price: 259.99,
      imgUrl: 'https://imgs.casasbahia.com.br/55011914/1xg.jpg?imwidth=300',
      description: 'Simplesmente a melhor mochila do app');
  Item item2 = Item(
      name: 'Smartphone',
      price: 1320.99,
      imgUrl: 'https://imgs.casasbahia.com.br/55048200/1g.jpg?imwidth=300',
      description: 'É... Apenas um cacto mesmo');

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
        body: buildBody(),
      ),
    );
  }

  buildBody() {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 16, 10, 30),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFE0E0E0),
          ),
          child: const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "pesquisar",
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        CartItem(item: item1),
        CartItem(item: item2),
      ],
    );
  }
}
