import 'package:araplantas_mobile/models/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetails extends StatefulWidget {
  final Item item;
  final String itemId;
  const ProductDetails({Key? key, required this.item, required this.itemId})
      : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final user = FirebaseAuth.instance.currentUser!;
  Icon currentIcon = const Icon(Icons.favorite_border);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                icon: currentIcon, onPressed: () => {saveItem(widget.itemId)})
          ],
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => {Navigator.of(context).pop()}),
        ),
        body: Container(
          margin: const EdgeInsets.only(bottom: 165),
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 40),
                  Image(image: NetworkImage(widget.item.imgUrl)),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(widget.item.name,
                        style: GoogleFonts.inter(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  Row(
                    children: [
                      const SizedBox(height: 90),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.item.description,
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                      ))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          height: 165,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 250, 250, 250)),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 38, right: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "R\$${widget.item.price}",
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                Center(
                  child: GestureDetector(
                      onTap: () {},
                      child: Container(
                          width: 343,
                          height: 65,
                          decoration: const BoxDecoration(
                              color: Color(0xFFFEE440),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Adicionar ao carrinho",
                                  style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 6),
                                const Icon(Icons.shopping_bag_outlined)
                              ],
                            ),
                          ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future saveItem(String itemId) async {
    setState(() {
      currentIcon = const Icon(
        Icons.favorite,
        color: Colors.red,
      );
    });
    try {
      final docItem = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('savedItems');

      final item = Item(
          id: itemId,
          name: widget.item.name,
          price: widget.item.price,
          imgUrl: widget.item.imgUrl,
          description: widget.item.description);
      await docItem.add(item.toJson());
    } on FirebaseException catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(e.toString()),
          content: const Text("Dados atualizados com sucesso"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(e.toString()),
          content: const Text("Erro ao Salvar"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    }
  }
}
