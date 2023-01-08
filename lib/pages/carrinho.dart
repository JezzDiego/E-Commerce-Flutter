import 'package:araplantas_mobile/components/cart_item_card.dart';
import 'package:araplantas_mobile/data/item_api.dart';
import 'package:araplantas_mobile/data/user_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user.dart' as UserModel;
import 'fisical_address.dart';

class Carrinho extends StatefulWidget {
  final UserModel.User user;

  const Carrinho({Key? key, required this.user}) : super(key: key);

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  List<Item> items = [];
  List<CartItem> cartItems = [];
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
                      .findUserCartItems(widget.user.id.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Algo deu errado");
                    } else if (snapshot.hasData) {
                      items = snapshot.data != null ? snapshot.data! : [];
                      cartItems = items.map(buildCartItem).toList();
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
                              children: items.isNotEmpty ? cartItems : [],
                            );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
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
                      onPressed: confirmOrder,
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

  Future confirmOrder() async {
    final itens = cartItems
        .map((e) => {"item_id": e.item.id, "quantity": e.quantity})
        .toList();
    final response = await ItemApi(authToken: widget.user.authToken!)
        .confirmOrder(widget.user.id.toString(), itens);
    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                  title: const Text("Pedido confirmado!"),
                  content: const Text(
                      "Seu pedido foi confirmado! Você já pode ir busca-lo"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FisicalAddress())),
                        child: const Text("Ver nosso endereço físico."),
                        style: TextButton.styleFrom(
                          primary: Colors.blue,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        )),
                  ])));
    } else {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                  title: const Text("Algo deu errado!"),
                  content: const Text(
                      "Não foi possível confirmar seu pedido. Tente novamente mais tarde"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Ok"),
                        style: TextButton.styleFrom(
                          primary: Colors.blue,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        )),
                  ])));
    }
    setState(() {});
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
        .findUserCartItems(widget.user.id.toString());
  }

  /*Stream<List<Item>> readCartItems() => FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('cart')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());*/

  CartItem buildCartItem(Item cartItem) {
    return CartItem(
      item: cartItem,
      user: widget.user,
      notifyParent: setCartTotalPrice,
      totalPrice: initialPrice,
    );
  }
}
