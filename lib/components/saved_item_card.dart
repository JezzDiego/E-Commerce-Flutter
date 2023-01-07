import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/item.dart';

class SavedItemCard extends StatefulWidget {
  final Item item;

  const SavedItemCard({Key? key, required this.item}) : super(key: key);

  @override
  _SavedItemCardState createState() => _SavedItemCardState();
}

class _SavedItemCardState extends State<SavedItemCard> {
  final user = FirebaseAuth.instance.currentUser!;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: const EdgeInsets.only(bottom: 22),
        shadowColor: const Color.fromARGB(0, 70, 20, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                buildImage(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'R\$${widget.item.price}',
                          style: GoogleFonts.inter(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.item.name,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 180,
                      child: !isLoading
                          ? ElevatedButton(
                              onPressed: () {
                                addToCart(context, widget.item.id);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xFFFEE440),
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                textStyle: GoogleFonts.inter(
                                  fontSize: 17,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                              child: Text(
                                'Mover para o carrinho',
                                style: GoogleFonts.inter(color: Colors.black),
                              ),
                            )
                          : const Center(child: CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ],
            ),
            IconButton(
              color: const Color(0xFF808080),
              icon: const Icon(Icons.highlight_remove),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .collection('savedItems')
                    .doc(widget.item.id)
                    .delete();
              },
            ),
          ],
        ),
      ),
    );
  }

  buildImage() {
    return Stack(
      children: [
        ClipRRect(
            child: Container(
          margin: const EdgeInsets.only(left: 9, right: 9),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.network(
            widget.item.imgUrl != null || widget.item.imgUrl != ""
                ? widget.item.imgUrl
                : "https://static.thenounproject.com/png/3734341-200.png",
            width: 120,
            height: 130,
          ),
        )),
      ],
    );
  }

  Future addToCart(context, String itemId) async {
    setState(() {
      isLoading = true;
    });
    try {
      final docItem = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .doc(itemId);

      final item = Item(
          id: itemId,
          name: widget.item.name,
          price: widget.item.price,
          imgUrl: widget.item.imgUrl != null || widget.item.imgUrl != ""
              ? widget.item.imgUrl
              : "https://static.thenounproject.com/png/3734341-200.png",
          description: widget.item.description);
      await docItem.set(item.toJson());
    } on FirebaseException catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Erro"),
          content: Text(e.toString()),
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
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Item adicionado ao carrinho'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}
