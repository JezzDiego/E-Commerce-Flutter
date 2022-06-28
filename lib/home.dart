import 'package:flutter/material.dart';
import 'home_items_card.dart';
import 'item.dart';


class MyHomePage extends StatefulWidget{
  const MyHomePage({Key? key}) : super(key: key);


  @override
  _HomePage createState()=> _HomePage();

}

class _HomePage extends State<MyHomePage> {
  Item item1 = Item(
    name: 'Teclado',
    price: 629.80,
    imgUrl:
        'https://http2.mlstatic.com/D_NQ_NP_755864-MLB31865914502_082019-O.jpg',
  );
  Item item2 = Item(
    name: 'Notebook',
    price: 2599.90,
    imgUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC1E4CuI6KFBej4X72_HsctzydSCqxBMGH8I7lqa6lRvSshC1NCtNau6tFcR3-Ka0dB9I&usqp=CAU',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  buildBody() {
    return ListView(
      children: [
        const SizedBox(height: 50),
        const Text("Produtos",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        Container(
            margin: const EdgeInsets.fromLTRB(10, 16, 10, 15),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFE0E0E0),
            ),
            child: const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Pesquisar",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HomeItemCard(item: item1),
              HomeItemCard(item: item2),
            ],
          ),
        ),
      ],
    );
  }
}