import 'package:araplantas_mobile/pages/my_info.dart';
import 'package:araplantas_mobile/pages/my_orders.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Minha Conta'),
          centerTitle: false,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSebLzQHeNYV0TVtz49fMdUANYfv1tcX9off2lbzaUFhqGAk-6zjQr6xhdyEnAY343KW2Y&usqp=CAU")
                      ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      Text('Luana Silva',
                      style: TextStyle(fontSize: 25)
                      ),
                      Text('9 9123-4567'),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context) {
                      return const MyOrders();
                    })));
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: const [
                            Icon(Icons.shopping_bag),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 20),
                              child: Text('Meus Pedidos',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                      return const MyInfo();
                    })));
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: const [
                    Icon(Icons.person),
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 20),
                      child: Text('Minhas Informações',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}