import 'package:araplantas_mobile/pages/my_account.dart';
import 'package:flutter/material.dart';
import '../pages/carrinho.dart';
import '../pages/home.dart';
import '../pages/saved_items.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _actualIndex = 0;
  final List<Widget> _screens = [
    const MyHomePage(),
    const Carrinho(),
    const SavedItems(),
    const MyAccount(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _actualIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_actualIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _actualIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.black),
            label: 'Home',
            tooltip: 'Página Inicial',
            activeIcon: Icon(Icons.home, color: Colors.black),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
            label: 'Carrinho',
            tooltip: 'Carrinho',
            activeIcon: Icon(Icons.shopping_cart, color: Colors.black),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border, color: Colors.black),
            label: 'Itens Salvos',
            tooltip: 'Itens salvos',
            activeIcon: Icon(Icons.star, color: Colors.black),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, color: Colors.black),
            label: 'Perfil',
            tooltip: 'Meu Perfil',
            activeIcon: Icon(Icons.account_circle, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
