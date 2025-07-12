import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ItemDetailPage extends StatelessWidget {
  final String itemId;
  final Map item;

  ItemDetailPage({required this.itemId, required this.item});

  Future<void> _requestSwap() async {
    final ref = FirebaseDatabase.instance.ref();
    await ref.child('swaps').push().set({
      'requestedItemId': itemId,
      'requestedBy': 'user_2', // static
      'offeredItemId': 'item_3', // for now mock
      'status': 'pending',
    });
    await ref.child('items/$itemId/status').set('requested');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item['title'])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description: ${item['description']}"),
            Text("Category: ${item['category']}"),
            Text("Condition: ${item['condition']}"),
            Text("Size: ${item['size']}"),
            Text("Tags: ${item['tags'].join(', ')}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestSwap,
              child: Text("Request Swap"),
            ),
          ],
        ),
      ),
    );
  }
}
