import 'dart:ui';

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
        SizedBox(height: 50),
        Padding(
          padding: EdgeInsets.all(15),
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
