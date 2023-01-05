import 'package:araplantas_mobile/components/google_sign_in.dart';
import 'package:araplantas_mobile/data/user_api.dart';
import 'package:araplantas_mobile/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'models/user.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    appId: dotenv.env['FIREBASE_APP_ID']!,
    apiKey: dotenv.env['FIREBASE_API_KEY']!,
    messagingSenderId: dotenv.env['FIREBASE_SENDER_ID']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
  ));
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const Login(),
      );
}
