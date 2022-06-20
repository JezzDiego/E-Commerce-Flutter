import 'package:araplantas_mobile/item.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'inicial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Produtos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Item item1 = Item(name: "produto 1", price: 10, imgUrl: "https://w7.pngwing.com/pngs/308/106/png-transparent-iphone-computer-icons-cell-phone-gadget-electronics-telephone-call.png");
  Item item2 = Item(name: "produto 2", price: 15, imgUrl: "https://w7.pngwing.com/pngs/308/106/png-transparent-iphone-computer-icons-cell-phone-gadget-electronics-telephone-call.png");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
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
            padding: EdgeInsets.all(10),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 180,
                    width: 180,
                    child: Image.network(
                      item1.imgUrl,
                      width: 120,
                      height: 130,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'R\$${item1.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      '${item1.name}',
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children : [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 180,
                    width: 180,
                    child: Image.network(
                      item2.imgUrl,
                      width: 120,
                      height: 130,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'R\$${item2.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${item2.name}',
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
      ),
    );
  }
}

