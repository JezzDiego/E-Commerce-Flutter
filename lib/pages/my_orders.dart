import 'package:araplantas_mobile/components/order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/item_api.dart';
import '../models/item.dart';
import '../models/user.dart';

class MyOrders extends StatefulWidget {
  final User user;
  const MyOrders({Key? key, required this.user}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<Item> items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pedidos", style: GoogleFonts.inter()),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
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
          FutureBuilder(
            future: ItemApi(authToken: widget.user.authToken!)
                .findUserPurshasedItems(widget.user.id.toString()),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Algo deu errado");
              } else if (snapshot.hasData) {
                items = snapshot.data as List<Item>;
                return items == null || items.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.heart_broken, size: 80),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Você ainda não comprou nenhum item",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      )
                    : ListView(
                        shrinkWrap: true,
                        children: items.map(buildOrders).toList(),
                      );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget buildOrders(Item item) => Order(
        item: item,
        user: widget.user,
      );
}
