import 'package:araplantas_mobile/data/item_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import '../models/item.dart';
import '../models/user.dart' as UserModel;

class CartItem extends StatefulWidget {
  final Item item;
  final UserModel.User user;
  final Function(double totalPrice) notifyParent;
  final double totalPrice;
  late int quantity = 1;
  CartItem(
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
            SizedBox(
              child: !isLoading
                  ? IconButton(
                      color: const Color(0xFF808080),
                      icon: const Icon(Icons.highlight_remove),
                      onPressed: () {
                        removeToCart(context, widget.item.id);
                      },
                    )
                  : const Center(child: CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );
  }

  Future removeToCart(context, String itemId) async {
    setState(() {
      isLoading = true;
    });

    Response response = await ItemApi(authToken: widget.user.authToken!)
        .deleteUserItem(widget.user.id.toString(), itemId);

    switch (response.statusCode) {
      case 200:
        setState(() {
          isLoading = false;
          widget.notifyParent(widget.totalPrice - widget.item.price * 0);
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Item removido do carrinho'),
          duration: Duration(seconds: 2),
        ));
        break;
      case 404:
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Erro"),
            content: Text(response.body),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: const Text("OK"))
            ],
          ),
        );
        break;
    }
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
            widget.item.imgUrl != null && widget.item.imgUrl != ""
                ? widget.item.imgUrl
                : "https://static.thenounproject.com/png/3734341-200.png",
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
      widget.quantity = counter;
      textColor = Colors.black;
    });
    widget.notifyParent(widget.totalPrice + widget.item.price * counter);
  }

  decrementCounter() {
    if (counter > 1) {
      setState(() {
        counter--;
        widget.quantity = counter;
      });
    }

    if (counter == 1) {
      setState(() {
        widget.quantity = counter;
        textColor = Colors.grey;
      });
    }
    widget.notifyParent(widget.totalPrice + widget.item.price * counter);
  }
}
