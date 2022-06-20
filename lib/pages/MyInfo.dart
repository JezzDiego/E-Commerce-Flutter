import 'package:flutter/material.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({Key? key}) : super(key: key);

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: const Text("Minhas Informações"),
                centerTitle: false,
                backgroundColor: Colors.blue,
              ),
              body: Padding(
                padding: EdgeInsets.all(30),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            width: 800,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Nome",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text("Luana",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text("Celular",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text("9 9123-456",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text("Email",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text("luana@email.com",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            ),
    );
  }
}
