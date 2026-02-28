import 'package:flutter/material.dart';

const Color _green = Color(0xFF3F6B00);

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final TextEditingController nameController =
      TextEditingController(text: "Sourav");

  final TextEditingController emailController =
      TextEditingController(text: "sourav@gmail.com");

  final TextEditingController passwordController =
      TextEditingController(text: "password123");

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Personal Information",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage:
                        NetworkImage(
                          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500",
                        ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: _green,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            _buildLabel("Full Name"),
            const SizedBox(height: 6),
            _buildTextField(nameController),

            const SizedBox(height: 20),

            _buildLabel("Email Address"),
            const SizedBox(height: 6),
            _buildTextField(emailController),

            const SizedBox(height: 20),

            _buildLabel("Password"),
            const SizedBox(height: 6),
            TextField(
              controller: passwordController,
              obscureText: true,
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: const Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}