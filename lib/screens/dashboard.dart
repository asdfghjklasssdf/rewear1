import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'new_item_page.dart';

class Dashboard extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final itemsRef = FirebaseFirestore.instance
        .collection('items')
        .where('uploadedBy', isEqualTo: user?.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: itemsRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) => ListTile(
              title: Text(docs[i]['title']),
              subtitle: Text(docs[i]['category']),
              leading: Image.network(docs[i]['imageUrl'], width: 50, height: 50, fit: BoxFit.cover),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => NewItemPage())),
      ),
    );
  }
}
