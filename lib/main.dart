import 'package:araplantas_mobile/home_items_card.dart';
import 'package:araplantas_mobile/item.dart';
import 'package:araplantas_mobile/saved_items.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'inicial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyAccount(),
    );
  }
}


