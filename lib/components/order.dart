import 'package:araplantas_mobile/data/item_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import '../models/item.dart';
import '../models/user.dart' as UserModel;

class Order extends StatefulWidget {
  final Item item;
  final UserModel.User user;
  Order({Key? key, required this.item, required this.user}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "R\$ ${widget.item.price}",
                  style: GoogleFonts.inter(fontSize: 20),
                ),
                Column(
                  children: [
                    Text(
                      "${widget.item.name}",
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 90, 89, 89)),
                    ),
                  ],
                )
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Comprado",
                        style: GoogleFonts.inter(
                            fontSize: 16, color: Colors.greenAccent[700]),
                      ),
                      Text(
                        "ITEM_ID : #${widget.item.id.padLeft(5, "0")}",
                        style:
                            GoogleFonts.inter(color: Colors.grey, fontSize: 16),
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    Container(
                      width: 115,
                      height: 115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey.shade300),
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://static.thenounproject.com/png/3734341-200.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15)
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
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
}
