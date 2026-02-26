import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Us")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [

          Icon(Icons.business, size: 60, color: Colors.green),
          SizedBox(height: 10),

          Center(
            child: Text(
              "Space Finder",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 20),

          Text(
            "Founded in 2023, Space Finder helps users find reliable public spaces for study, work and events.",
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 30),

          Text(
            "Contact Information",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 10),

          Text("Email: hello@spacefinder.com"),
          Text("Website: www.spacefinder.com"),
        ],
      ),
    );
  }
}