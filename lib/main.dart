import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rewear/screens/LoginPage.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(RewearApp());
}

class RewearApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReWear',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
