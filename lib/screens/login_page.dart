import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'admin_panel.dart';
import 'landing_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _error = false;

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final ref = FirebaseDatabase.instance.ref().child('users');
    final snapshot = await ref.get();

    bool found = false;

    if (snapshot.exists) {
      final users = Map<String, dynamic>.from(snapshot.value as dynamic);
      for (var entry in users.entries) {
        final user = Map<String, dynamic>.from(entry.value);
        if (user['email'] == email && user['password'] == password) {
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
      setState(() => _error = true);
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
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text("Login"),
            ),
            if (_error) Text("Invalid credentials", style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
