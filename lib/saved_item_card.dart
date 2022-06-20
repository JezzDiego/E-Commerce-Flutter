import 'package:flutter/material.dart';

import 'item.dart';

class SavedItemCard extends StatefulWidget {
  final Item item;

  const SavedItemCard({Key? key, required this.item}) : super(key: key);

  @override
  _SavedItemCardState createState() => _SavedItemCardState();
}

class _SavedItemCardState extends State<SavedItemCard> {
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
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.item.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.only(top: 42),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFFEE440),
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 17),
                          textStyle: const TextStyle(
                            fontSize: 17,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        child: const Text(
                          'Mover para o carrinho',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              color: const Color(0xFF808080),
              icon: const Icon(Icons.highlight_remove),
              onPressed: () {},
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
}
