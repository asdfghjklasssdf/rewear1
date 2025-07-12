import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String error = '';

  void signup() async {
    if (emailController.text.isEmpty || passController.text.isEmpty) {
      setState(() => error = "Please fill all fields");
      return;
    }

    final ref = FirebaseDatabase.instance.ref().child("users").push();

    await ref.set({
      'email': emailController.text.trim(),
      'password': passController.text.trim(),
      'isAdmin': false,
    });

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ReWear Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Create Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: signup, child: Text('Sign Up')),
            if (error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(error, style: TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}
