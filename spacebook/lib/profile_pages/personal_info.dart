import 'package:flutter/material.dart';
import 'package:spacebook/services/api_service.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  final TextEditingController passwordController = TextEditingController(text: "••••••••••");

  bool obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: ApiService.currentUser?['name'] ?? '');
    emailController = TextEditingController(
        text: ApiService.currentUser?['email'] ?? '');
  }

  Future<void> _handleSave() async {
  setState(() => _isLoading = true);

  try {
    final res = await ApiService.updateProfile(
      nameController.text.trim(),
    );

    if (res['user'] != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update profile'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }

  setState(() => _isLoading = false);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).textTheme.bodyMedium?.color),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Personal Information",
          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    child: Text(
                      (ApiService.currentUser?['name'] ?? 'U')
                          .substring(0, 1)
                          .toUpperCase(),
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.edit, size: 16, color: Colors.white),
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
                fillColor: Theme.of(context).colorScheme.primaryContainer,
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
                onPressed: _isLoading ? null : _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Save Changes",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
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
        style: const TextStyle(fontSize: 13, color: Colors.grey),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}