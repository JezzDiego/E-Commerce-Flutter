import 'dart:async';

import 'package:araplantas_mobile/data/item_api.dart';
import 'package:araplantas_mobile/models/item.dart';
import 'package:araplantas_mobile/models/user.dart' as UserModel;
import 'package:araplantas_mobile/pages/carrinho.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class ProductDetails extends StatefulWidget {
  final Item item;
  final UserModel.User user;
  const ProductDetails({Key? key, required this.item, required this.user})
      : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Icon currentIcon = const Icon(Icons.favorite_border);
  bool isLoading = false;
  bool _enabled = true;
  Color _buttonColor = Color(0xFFFEE440);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Item>(
      future: ItemApi(authToken: widget.user.authToken!)
          .getCartUserItem(widget.item.id, widget.user.id.toString()),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          if (snapshot.error.toString() == "Can't get item.") {
            _enabled = true;
            _buttonColor = Color(0xFFFEE440);
            return buildBody(context);
          }
          return const Text("Algo deu errado");
        } else if (snapshot.hasData) {
          _enabled = false;
          _buttonColor = Colors.grey;
          return buildBody(context);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  Future saveItem() async {
    Response response = await ItemApi(authToken: widget.user.authToken!)
        .saveUserItem(widget.user.id.toString(), widget.item.id);
    if (response.statusCode == 200) {
      setState(() {
        currentIcon = const Icon(Icons.favorite, color: Colors.red);
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Erro"),
          content: Text(response.body.toString()),
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

  Future deleteSavedItem() async {
    Response response = await ItemApi(authToken: widget.user.authToken!)
        .deleteUserSavedItem(widget.user.id.toString(), widget.item.id);
    if (response.statusCode == 200) {
      setState(() {
        currentIcon = const Icon(Icons.favorite_border);
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Erro"),
          content: Text(response.body.toString()),
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

  buildBody(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          actions: [
            FutureBuilder(
              future: ItemApi(authToken: widget.user.authToken!)
                  .getSavedUserItem(widget.item.id, widget.user.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () => {deleteSavedItem()});
                } else {
                  return IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                      ),
                      onPressed: () => {saveItem()});
                }
              },
            )
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
                  Image(
                      image: NetworkImage(widget.item.imgUrl != null ||
                              widget.item.imgUrl != ""
                          ? widget.item.imgUrl
                          : "https://static.thenounproject.com/png/3734341-200.png")),
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
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () {
                            _enabled
                                ? addToCart(context, widget.item.id)
                                : null;
                            setState(() {
                              _enabled = false;
                            });
                          },
                          child: Container(
                              width: 343,
                              height: 65,
                              decoration: BoxDecoration(
                                  color: _buttonColor,
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

  Future addToCart(context, String itemId) async {
    setState(() {
      isLoading = true;
    });
    final item = Item(
        id: itemId,
        name: widget.item.name,
        price: widget.item.price,
        imgUrl: widget.item.imgUrl,
        description: widget.item.description);
    final response = await ItemApi(authToken: widget.user.authToken!)
        .addItemtoCart(widget.user.id.toString(), item.id);
    if (response.statusCode != 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Error"),
          content: Text(response.body.toString()),
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
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Item adicionado ao carrinho'),
      duration: Duration(seconds: 2),
    ));
  }
}
