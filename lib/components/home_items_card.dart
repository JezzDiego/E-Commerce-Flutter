import 'package:flutter/material.dart';
import '../models/user.dart';
import '../pages/product_details.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/item.dart';

class HomeItemCard extends StatefulWidget {
  final Item item;
  final User user;
  final String itemId;
  const HomeItemCard(
      {Key? key, required this.item, required this.itemId, required this.user})
      : super(key: key);

  @override
  _HomeItemCardState createState() => _HomeItemCardState();
}

class _HomeItemCardState extends State<HomeItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return ProductDetails(
              item: widget.item,
              itemId: widget.itemId,
              user: widget.user,
            );
          })));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[100]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 180,
                width: 180,
                child: Image.network(
                  widget.item.imgUrl,
                  width: 120,
                  height: 130,
                ),
              ),
              Text(
                widget.item.name,
                style: GoogleFonts.inter(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'R\$${widget.item.price}',
                style: GoogleFonts.inter(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
