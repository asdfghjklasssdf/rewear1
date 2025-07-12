import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'item_detail_page.dart';

class DashboardPage extends StatelessWidget {
  Stream<DatabaseEvent> getItemsStream() {
    return FirebaseDatabase.instance.ref().child('items').onValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Browse Items")),
      body: StreamBuilder<DatabaseEvent>(
        stream: getItemsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong."));
          }

          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return Center(child: Text("No items available."));
          }

          final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          final items = Map<String, dynamic>.from(data);

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final entry = items.entries.elementAt(index);
              final itemId = entry.key;
              final item = Map<String, dynamic>.from(entry.value);

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(
                    item['title'] ?? 'Untitled',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Status: ${item['status'] ?? 'Unknown'}"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ItemDetailPage(itemId: itemId, item: item),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
