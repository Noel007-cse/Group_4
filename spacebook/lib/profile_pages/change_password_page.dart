import 'package:flutter/material.dart';
import 'package:spacebook/services/api_service.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool obscureCurrent = true;
  bool obscureNew = true;
  bool obscureConfirm = true;
  bool _isLoading = false;

  bool hasMinLength = false;
  bool hasUppercase = false;
  bool hasSpecialChar = false;
  bool passwordsMatch = false;

  void validatePassword(String value) {
    setState(() {
      hasMinLength = value.length >= 8;
      hasUppercase = value.contains(RegExp(r'[A-Z]'));
      hasSpecialChar = value.contains(RegExp(r'[!@#\$&*~]'));
      passwordsMatch = value == confirmPasswordController.text &&
          confirmPasswordController.text.isNotEmpty;
    });
  }

  void validateConfirm(String value) {
    setState(() {
      passwordsMatch =
          value == newPasswordController.text && value.isNotEmpty;
    });
  }

  Future<void> _handleUpdatePassword() async {
    setState(() => _isLoading = true);
    try {
      final result = await ApiService.changePassword(
        currentPasswordController.text.trim(),
        newPasswordController.text.trim(),
      );
      if (result['message'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password updated successfully!'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['error'] ?? 'Failed to update password')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connection error. Is backend running?')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
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
          "Change Password",
          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Current Password"),
            _buildPasswordField(
              controller: currentPasswordController,
              obscure: obscureCurrent,
              toggle: () => setState(() => obscureCurrent = !obscureCurrent),
              hint: "Enter current password",
            ),
            const SizedBox(height: 20),
            _buildLabel("New Password"),
            _buildPasswordField(
              controller: newPasswordController,
              obscure: obscureNew,
              toggle: () => setState(() => obscureNew = !obscureNew),
              hint: "Enter new password",
              onChanged: validatePassword,
            ),
            const SizedBox(height: 20),
            _buildLabel("Confirm New Password"),
            _buildPasswordField(
              controller: confirmPasswordController,
              obscure: obscureConfirm,
              toggle: () => setState(() => obscureConfirm = !obscureConfirm),
              hint: "Confirm new password",
              onChanged: validateConfirm,
            ),
            const SizedBox(height: 25),
            _buildRequirementsCard(),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: (hasMinLength && hasUppercase && hasSpecialChar && passwordsMatch && !_isLoading)
                    ? _handleUpdatePassword
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Update Password",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.grey)),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback toggle,
    required String hint,
    Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: toggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildRequirementsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F7EF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Password Requirements",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          _buildRequirement("At least 8 characters long", hasMinLength),
          _buildRequirement("Include at least one uppercase letter", hasUppercase),
          _buildRequirement("One special character (e.g. @, #, \$)", hasSpecialChar),
          _buildRequirement("Passwords must match", passwordsMatch),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text, bool satisfied) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            satisfied ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 18,
            color: satisfied ? Theme.of(context).colorScheme.primary : Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: satisfied ? Theme.of(context).colorScheme.primary : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}