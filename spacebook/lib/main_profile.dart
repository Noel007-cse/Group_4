import 'package:flutter/material.dart';
import 'personal_info.dart';
import 'about_us.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // Profile Header
          Column(
            children: const [
              CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              SizedBox(height: 10),
              Text(
                "Sourav",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("sourav@gmail.com"),
            ],
          ),

          const SizedBox(height: 25),

          const Text("ACCOUNT SETTINGS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

          const SizedBox(height: 10),

          buildTile(
            context,
            title: "Personal Information",
            icon: Icons.person,
            page: const PersonalInfoPage(),
          ),

          buildTile(
            context,
            title: "Payment Methods",
            icon: Icons.payment,
          ),

          buildTile(
            context,
            title: "Security",
            icon: Icons.security,
          ),

          const SizedBox(height: 20),

          const Text("SUPPORT",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

          const SizedBox(height: 10),

          buildTile(
            context,
            title: "About Us",
            icon: Icons.info,
            page: const AboutUsPage(),
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size(double.infinity, 45),
            ),
            child: const Text("Logout"),
          )
        ],
      ),
    );
  }

  static Widget buildTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    Widget? page,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          if (page != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => page),
            );
          }
        },
      ),
    );
  }
}