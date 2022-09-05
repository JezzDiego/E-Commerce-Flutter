import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/home_items_card.dart';
import '../components/item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<MyHomePage> {
  Item item1 = Item(
      name: 'Teclado',
      price: 629.89,
      imgUrl:
          'https://http2.mlstatic.com/D_NQ_NP_755864-MLB31865914502_082019-O.jpg',
      description:
          'Um teclado muito bonito com várias coisas comuns em um teclado');
  Item item2 = Item(
      name: 'Notebook',
      price: 2599.99,
      imgUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC1E4CuI6KFBej4X72_HsctzydSCqxBMGH8I7lqa6lRvSshC1NCtNau6tFcR3-Ka0dB9I&usqp=CAU',
      description:
          'Notebook de ultima geração equipado com um processador bom e uma boa placa de vídeo, CONFIA');

  List<String> test = [
    "teste",
    "teste",
    "teste",
    "teste",
    "teste",
    "teste",
    "teste",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Produtos',
            style: GoogleFonts.inter(),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: buildBody(),
      ),
    );
  }

  buildBody() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 16, 10, 15),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFE0E0E0),
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Pesquisar",
                border: InputBorder.none,
                hintStyle: GoogleFonts.inter(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 14,
          child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 8.0 / 10.0),
              itemBuilder: (BuildContext context, index) {
                return HomeItemCard(item: item2);
              }),
        )
      ],
    );
  }
}
