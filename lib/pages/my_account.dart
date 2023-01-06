import 'package:araplantas_mobile/components/google_sign_in.dart';
import 'package:araplantas_mobile/models/user.dart' as UserModel;
import 'package:araplantas_mobile/pages/login.dart';
import 'package:araplantas_mobile/pages/my_info.dart';
import 'package:araplantas_mobile/pages/my_orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatefulWidget {
  final UserModel.User user;

  const MyAccount({Key? key, required this.user}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Minha Conta',
            style: GoogleFonts.inter(),
          ),
          centerTitle: false,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 30),
            Center(
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(user.photoURL ??
                              "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"),
                          fit: BoxFit.fill),
                    ))),
            Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Text(
                    user.displayName != null
                        ? user.displayName!.split(" ")[0]
                        : user.email!,
                    style: GoogleFonts.inter(
                        fontSize: 24, fontWeight: FontWeight.bold)),
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
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return const MyOrders();
                    })));
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const Icon(Icons.shopping_bag_outlined),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 20),
                              child: Text(
                                'Meus Pedidos',
                                style: GoogleFonts.inter(fontSize: 20),
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
                  children: [
                    const Icon(Icons.person_outline),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20),
                      child: Text(
                        'Minhas Informações',
                        style: GoogleFonts.inter(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomSheet: TextButton(
          style: TextButton.styleFrom(
              primary: Colors.black, backgroundColor: Colors.white),
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.logout().then((value) => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const Login())));
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.exit_to_app_outlined),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Text(
                    'Sair',
                    style: GoogleFonts.inter(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
