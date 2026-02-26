import 'package:flutter/material.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personal Information")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              decoration: const InputDecoration(
                labelText: "Email Address",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 45),
              ),
              child: const Text("Save Changes"),
            )
          ],
        ),
      ),
    );
  }
}