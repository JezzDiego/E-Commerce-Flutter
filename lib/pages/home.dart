import 'package:animated_card/animated_card.dart';
import 'package:araplantas_mobile/data/item_api.dart';
import 'package:araplantas_mobile/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/home_items_card.dart';
import '../models/item.dart';

class MyHomePage extends StatefulWidget {
  final User user;
  const MyHomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<MyHomePage> {
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
          flex: 12,
          child: FutureBuilder<List<Item>>(
            future: ItemApi().findAll(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return const Text("algo deu errado");
              } else if (snapshot.hasData) {
                final items = snapshot.data!;

                return AnimatedCard(
                  direction: AnimatedCardDirection.bottom,
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 8.0 / 10.0),
                    children: items.map(buildItem).toList(),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildItem(Item item) =>
      HomeItemCard(item: item, itemId: item.id, user: widget.user);

  Stream<List<Item>> readItems() => FirebaseFirestore.instance
      .collection('items')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());
}
