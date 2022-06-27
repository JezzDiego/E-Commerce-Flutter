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
    name: 'Item 1',
    price: 1.99,
    imgUrl:
        'https://w7.pngwing.com/pngs/308/106/png-transparent-iphone-computer-icons-cell-phone-gadget-electronics-telephone-call.png',
  );
  Item item2 = Item(
    name: 'Item 2',
    price: 5.00,
    imgUrl:
        'https://w7.pngwing.com/pngs/308/106/png-transparent-iphone-computer-icons-cell-phone-gadget-electronics-telephone-call.png',
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