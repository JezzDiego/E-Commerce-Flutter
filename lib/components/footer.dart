import 'package:araplantas_mobile/models/user.dart';
import 'package:araplantas_mobile/pages/my_account.dart';
import 'package:flutter/material.dart';
import '../pages/carrinho.dart';
import '../pages/home.dart';
import '../pages/saved_items.dart';

class Footer extends StatefulWidget {
  final User user;
  const Footer({Key? key, required this.user}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState(user);
}

class _FooterState extends State<Footer> {
  late User _user;
  _FooterState(User _user) {
    _user = _user;
  }

  int _actualIndex = 0;
  late final List<Widget> _screens = [
    MyHomePage(user: _user),
    Carrinho(user: _user),
    SavedItems(user: _user),
    MyAccount(user: _user),
  ];

  @override
  void initState() {
    _user = widget.user;
  }

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
            icon: Icon(Icons.favorite_border, color: Colors.black),
            label: 'Itens Salvos',
            tooltip: 'Itens Salvos',
            activeIcon: Icon(Icons.favorite, color: Colors.black),
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
