import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/item.dart';
import '../components/saved_item_card.dart';

class SavedItems extends StatefulWidget {
  const SavedItems({Key? key}) : super(key: key);

  @override
  _SavedItemsState createState() => _SavedItemsState();
}

class _SavedItemsState extends State<SavedItems> {
  List<Item> items = [];

  void buildItemsList() {
    Item item1 = Item(
        id: "05",
        name: 'Notebook gamer',
        price: 2599.99,
        imgUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC1E4CuI6KFBej4X72_HsctzydSCqxBMGH8I7lqa6lRvSshC1NCtNau6tFcR3-Ka0dB9I&usqp=CAU',
        description:
            'Notebook de ultima geração equipado com um processador bom e uma boa placa de vídeo, CONFIA');
    Item item2 = Item(
        id: "06",
        name: 'Cacto',
        price: 4.99,
        imgUrl:
            'https://i.pinimg.com/originals/d5/fc/38/d5fc38248b3dc4f3c614bbecfc3605c9.jpg',
        description: 'É... Apenas um cacto mesmo');

    items.add(item1);
    items.add(item2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Itens Salvos',
            style: GoogleFonts.inter(),
          ),
          centerTitle: false,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: buildBody(),
      ),
    );
  }

  buildBody() {
    buildItemsList();
    return Scaffold(
      body: ListView(
          children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 16, 10, 30),
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
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return SavedItemCard(item: items[index]);
            },
          )
        ],
      ),
    );
  }

  Text buildText({
    required String text,
    double fontSize = 14,
    bool isBold = false,
    Color color = Colors.black,
  }) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: color,
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.w700 : null,
      ),
    );
  }
}
