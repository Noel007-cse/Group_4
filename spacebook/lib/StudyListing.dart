import 'package:flutter/material.dart';

class StudyHallsScreen extends StatefulWidget {
  const StudyHallsScreen({super.key});

  @override
  State<StudyHallsScreen> createState() => _StudyHallsScreenState();
}

class _StudyHallsScreenState extends State<StudyHallsScreen> {

  final List<Map<String, String>> studyHalls = [
    {
      "name": "Quiet Study Hub",
      "location": "Downtown",
      "price": "₹200 / hour",
    },
    {
      "name": "Focus Zone Library",
      "location": "City Center",
      "price": "₹150 / hour",
    },
    {
      "name": "Scholars Space",
      "location": "Near University",
      "price": "₹180 / hour",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Halls"),
        centerTitle: true,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: studyHalls.length,
        itemBuilder: (context, index) {
          final hall = studyHalls[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                hall["name"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${hall["location"]} • ${hall["price"]}",
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Booked ${hall["name"]}!"),
                    ),
                  );
                },
                child: const Text("Book"),
              ),
            ),
          );
        },
      ),
    );
  }
}