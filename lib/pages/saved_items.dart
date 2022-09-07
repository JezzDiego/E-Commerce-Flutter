import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final user = FirebaseAuth.instance.currentUser!;

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
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: StreamBuilder<List<Item>>(
          stream: readSavedItems(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Algo deu errado");
            } else if (snapshot.hasData) {
              final items = snapshot.data;
              return items == null
                  ? const Center(
                      child: Text(
                          "Ao salvar algum item você poderá acessá-lo aqui"))
                  : ListView(
                      shrinkWrap: true,
                      children: items.map(buildSavedItems).toList(),
                    );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })),
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

  Stream<List<Item>> readSavedItems() => FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('savedItems')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());

  Widget buildSavedItems(Item savedItem) => SavedItemCard(item: savedItem);
}
