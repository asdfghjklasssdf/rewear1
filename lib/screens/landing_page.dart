import 'package:flutter/material.dart';
import 'add_item_page.dart';
import 'dashboard_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ReWear')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header image / banner
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  "👕 ReWear 👚",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 20),

              // Introduction & benefits
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      "🌱 Welcome to ReWear!",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Exchange your unused clothes, reduce waste, and earn points! ReWear is a community-driven platform that makes fashion circular.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),

                    // Features section
                    Text(
                      "🚀 Features:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Text("✔️ Swap directly or via point system"),
                    Text("✔️ Upload and list your clothes easily"),
                    Text("✔️ Track ongoing and completed swaps"),
                    Text("✔️ Admin moderation for safety"),
                    SizedBox(height: 20),

                    // Buttons
                    ElevatedButton.icon(
                      icon: Icon(Icons.swap_horiz),
                      label: Text("Start Swapping"),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => DashboardPage()));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14)),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton.icon(
                      icon: Icon(Icons.explore),
                      label: Text("Browse Items"),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => DashboardPage()));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14)),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton.icon(
                      icon: Icon(Icons.add_circle_outline),
                      label: Text("List an Item"),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => AddItemPage()));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
