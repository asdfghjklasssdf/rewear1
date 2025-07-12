import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AdminPanel extends StatelessWidget {
  Stream<DatabaseEvent> getPendingStream() {
    return FirebaseDatabase.instance.ref().child('pendingApprovals').onValue;
  }

  void _approveItem(String itemId) async {
    final ref = FirebaseDatabase.instance.ref();
    await ref.child('items/$itemId/status').set('available');
    await ref.child('pendingApprovals/$itemId').remove();
  }

  void _rejectItem(String itemId) async {
    final ref = FirebaseDatabase.instance.ref();
    await ref.child('items/$itemId').remove();
    await ref.child('pendingApprovals/$itemId').remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Panel")),
      body: StreamBuilder(
        stream: getPendingStream(),
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            final pending = Map<String, dynamic>.from(snapshot.data!.snapshot.value as dynamic);
            return ListView(
              children: pending.keys.map((itemId) {
                return ListTile(
                  title: Text("Pending Item ID: $itemId"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.check), onPressed: () => _approveItem(itemId)),
                      IconButton(icon: Icon(Icons.close), onPressed: () => _rejectItem(itemId)),
                    ],
                  ),
                );
              }).toList(),
            );
          } else {
            return Center(child: Text("No pending items."));
          }
        },
      ),
    );
  }
}
