import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

class NewItemPage extends StatefulWidget {
  @override
  _NewItemPageState createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '', category = '';
  File? image;

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  Future<void> uploadItem() async {
    if (!_formKey.currentState!.validate() || image == null) return;

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final imageId = Uuid().v4();
    final ref = FirebaseStorage.instance.ref().child('items/$imageId.jpg');
    await ref.putFile(image!);
    final imageUrl = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('items').add({
      'title': title,
      'category': category,
      'imageUrl': imageUrl,
      'uploadedBy': uid,
      'timestamp': FieldValue.serverTimestamp(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              onChanged: (v) => title = v,
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Category'),
              onChanged: (v) => category = v,
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            SizedBox(height: 10),
            image != null ? Image.file(image!, height: 100) : Text('No image selected'),
            TextButton.icon(
              icon: Icon(Icons.image),
              label: Text('Pick Image'),
              onPressed: pickImage,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: uploadItem, child: Text('Upload Item')),
          ]),
        ),
      ),
    );
  }
}
