import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'item.dart';
import 'saved_item_card.dart';

class SavedItems extends StatefulWidget {
  const SavedItems({Key? key}) : super(key: key);

  @override
  _SavedItemsState createState() => _SavedItemsState();
}

class _SavedItemsState extends State<SavedItems> {
  Item item1 = Item(
    name: 'Notebook gamer',
    price: 2599,
    imgUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC1E4CuI6KFBej4X72_HsctzydSCqxBMGH8I7lqa6lRvSshC1NCtNau6tFcR3-Ka0dB9I&usqp=CAU',
  );
  Item item2 = Item(
    name: 'Cacto',
    price: 3.00,
    imgUrl:
        'https://i.pinimg.com/originals/d5/fc/38/d5fc38248b3dc4f3c614bbecfc3605c9.jpg',
  );
  
  var alalItems =[];

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
        Padding(
          padding: const EdgeInsets.all(15),
          child: buildText(text: "itens salvos",fontSize: 40,isBold: true),
        ),
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
        SavedItemCard(item: item1),
        SavedItemCard(item: item2),
      ],
    );
  }
  
  Text buildText({
    required String text,
    double fontSize = 14,
    bool isBold = false,
    Color color = Colors.black,
  }){
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
