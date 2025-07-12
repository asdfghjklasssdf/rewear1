import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _database = FirebaseDatabase.instance.ref();
  final _itemController = TextEditingController();
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    _listenToItems();
  }

  void _listenToItems() {
    _database.child('items').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        setState(() {
          _items = data.values.map((item) => item.toString()).toList();
        });
      }
    });
  }

  void _addItem() async {
    final text = _itemController.text.trim();
    if (text.isNotEmpty) {
      final newItem = _database.child('items').push();
      await newItem.set(text);
      _itemController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ReWear Items')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _itemController,
              decoration: InputDecoration(
                labelText: 'Enter item name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addItem,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _items.isEmpty
                  ? Center(child: Text('No items found'))
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_items[index]),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
