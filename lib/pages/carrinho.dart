import 'package:araplantas_mobile/components/cart_item_card.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';
import 'package:google_fonts/google_fonts.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({Key? key}) : super(key: key);

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  Item item1 = Item(
      id: "03",
      name: 'Smartphone',
      price: 1320.99,
      imgUrl: 'https://imgs.casasbahia.com.br/55048200/1g.jpg?imwidth=300',
      description: 'É... Apenas um cacto mesmo');

  Item item2 = Item(
      id: "04",
      name: 'Mochila Muito Top',
      price: 259.99,
      imgUrl: 'https://imgs.casasbahia.com.br/55011914/1xg.jpg?imwidth=300',
      description: 'Simplesmente a melhor mochila do app');

  @override
  Widget build(BuildContext context) {
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
            buildBody(),
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
                        Text("R\$1.580,98",
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

  buildBody() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CartItem(item: item1),
            CartItem(item: item2),
          ],
        ),
      ),
    );
  }
}
