import 'package:araplantas_mobile/data/item_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/item.dart';
import '../models/user.dart' as UserModel;
import '../components/saved_item_card.dart';

class SavedItems extends StatefulWidget {
  final UserModel.User user;

  const SavedItems({Key? key, required this.user}) : super(key: key);

  @override
  _SavedItemsState createState() => _SavedItemsState();
}

class _SavedItemsState extends State<SavedItems> {
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
      child: FutureBuilder<List<Item>>(
          future: ItemApi(authToken: widget.user.authToken!)
              .findUserSavedItems(widget.user.id.toString()),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Algo deu errado");
            } else if (snapshot.hasData) {
              final items = snapshot.data!;
              return items == null || items.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.heart_broken, size: 80),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Você ainda não salvou nenhum item",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    )
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

  Widget buildSavedItems(Item savedItem) => SavedItemCard(
        item: savedItem,
        user: widget.user,
        onRemove: () => setState(() {}),
      );
}
