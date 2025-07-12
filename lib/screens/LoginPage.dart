import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'signup_page.dart';
import 'landing_page.dart';
import 'admin_panel.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String error = '';

  void login() async {
    final ref = FirebaseDatabase.instance.ref().child("users");
    final snapshot = await ref.get();

    bool found = false;

    if (snapshot.exists) {
      final users = Map<String, dynamic>.from(snapshot.value as dynamic);
      for (var entry in users.entries) {
        final user = Map<String, dynamic>.from(entry.value);
        if (user['email'] == emailController.text.trim() &&
            user['password'] == passController.text.trim()) {
          found = true;

          if (user['isAdmin'] == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => AdminPanel()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LandingPage()),
            );
          }
          break;
        }
      }
    }

    if (!found) {
      setState(() => error = 'Invalid email or password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ReWear Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: Text('Login')),
            if (error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(error, style: TextStyle(color: Colors.red)),
              ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
              },
              child: Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
