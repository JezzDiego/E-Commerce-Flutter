import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/item.dart';
import '../models/user.dart' as UserModel;

class CartItem extends StatefulWidget {
  final Item item;
  final UserModel.User user;
  final Function(double totalPrice) notifyParent;
  final double totalPrice;
  const CartItem(
      {Key? key,
      required this.item,
      required this.user,
      required this.notifyParent,
      required this.totalPrice})
      : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int counter = 1;
  Color textColor = Colors.grey;
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
                    const SizedBox(height: 42),
                    Container(
                      width: 125,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: Color(0XFFF5F5F5),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {
                                decrementCounter();
                              },
                              icon: Icon(Icons.remove, color: textColor)),
                          Text(
                            "$counter",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          IconButton(
                              onPressed: () {
                                incrementCounter();
                              },
                              icon: const Icon(Icons.add))
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              color: const Color(0xFF808080),
              icon: const Icon(Icons.highlight_remove),
              onPressed: () {
                /*FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .collection('cart')
                    .doc(widget.item.id)
                    .delete();*/
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
            widget.item.imgUrl,
            width: 120,
            height: 130,
          ),
        )),
      ],
    );
  }

  incrementCounter() {
    setState(() {
      counter++;
      textColor = Colors.black;
    });
    widget.notifyParent(widget.totalPrice + widget.item.price * counter);
  }

  decrementCounter() {
    if (counter > 1) {
      setState(() {
        counter--;
      });
    }

    if (counter == 1) {
      setState(() {
        textColor = Colors.grey;
      });
    }
    widget.notifyParent(widget.totalPrice + widget.item.price * counter);
  }
}
