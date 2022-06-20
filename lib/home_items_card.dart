

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'item.dart';

class HomeItemCard extends StatefulWidget{
  final Item item;

  const HomeItemCard({Key? key, required this.item}): super(key:key);

  @override
  _HomeItemCardState createState() => _HomeItemCardState();

}

class _HomeItemCardState extends State<HomeItemCard>{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 180,
                    width: 180,
                    child: Image.network(
                      widget.item.imgUrl,
                      width: 120,
                      height: 130,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'R\$${widget.item.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      '${widget.item.name}',
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  )
                ],
              ),
    );
  }

}