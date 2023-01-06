import 'package:araplantas_mobile/components/cart_item_card.dart';
import 'package:araplantas_mobile/data/item_api.dart';
import 'package:araplantas_mobile/data/user_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/user.dart' as UserModel;

class Carrinho extends StatefulWidget {
  final UserModel.User user;

  const Carrinho({Key? key, required this.user}) : super(key: key);

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  List<Item> items = [];
  double totalPrice = 0;
  double initialPrice = 0;
  @override
  void initState() {
    // implement initState
    super.initState();
  }

  @override
  // TODO: implement context
  BuildContext get context => super.context;
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  buildBody() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Carrinho',
            style: GoogleFonts.inter(),
          ),
          centerTitle: false,
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            const SizedBox(height: 25),
            Expanded(
              child: FutureBuilder<List<Item>>(
                  future: ItemApi(authToken: widget.user.authToken!)
                      .findUserItems(widget.user.id.toString()),
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Algo deu errado");
                    } else if (snapshot.hasData) {
                      items = snapshot.data != null ? snapshot.data! : [];
                      return items.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.heart_broken, size: 80),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Você ainda não adicionou itens ao carrinho",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : ListView(
                              shrinkWrap: true,
                              children: items.isNotEmpty
                                  ? items.map(buildCartItem).toList()
                                  : [],
                            );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey))),
              height: 155,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Total",
                          style: GoogleFonts.inter(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        Text("R\$ ${this.totalPrice.toStringAsFixed(2)}",
                            style: GoogleFonts.inter(
                                fontSize: 26, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 65,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFEE440)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Confirmar pedido",
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double setCartTotalPrice(double totalPrice) {
    setState(() {
      this.totalPrice = totalPrice;
    });
    return (totalPrice);
  }

  getCartTotalPrice() {
    /*FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        setState(() {
          totalPrice += element.data()['price'];
        });
      });
    });*/
    ItemApi(authToken: widget.user.authToken!)
        .findUserItems(widget.user.id.toString());
  }

  /*Stream<List<Item>> readCartItems() => FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('cart')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());*/

  Widget buildCartItem(Item cartItem) {
    return CartItem(
      item: cartItem,
      user: widget.user,
      notifyParent: setCartTotalPrice,
      totalPrice: initialPrice,
    );
  }
}
