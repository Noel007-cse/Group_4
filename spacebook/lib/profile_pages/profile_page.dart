import 'package:flutter/material.dart';
import 'package:spacebook/profile_pages/about_us_page.dart';
import 'package:spacebook/profile_pages/change_password_page.dart';
import 'package:spacebook/profile_pages/personal_info.dart';
import 'package:spacebook/services/api_service.dart';
import 'package:spacebook/auth_screen.dart';

const Color _green = Color(0xFF3F6B00);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Center(child: _ProfileHeader()),
              const SizedBox(height: 30),
              const _SectionTitle("ACCOUNT SETTINGS"),
              const SizedBox(height: 12),
              const _AccountSection(),
              const SizedBox(height: 25),
              const _SectionTitle("PREFERENCES"),
              const SizedBox(height: 12),
              const _PreferenceSection(),
              const SizedBox(height: 25),
              const _SectionTitle("SUPPORT"),
              const SizedBox(height: 12),
              const _SupportSection(),
              const SizedBox(height: 30),
              _LogoutButton(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    final name = ApiService.currentUser?['name'] ?? 'User';
    final email = ApiService.currentUser?['email'] ?? '';

    return Column(
      children: [
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
                backgroundColor: _green.withOpacity(0.2),
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : 'U',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: _green,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: _green,
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
        const SizedBox(height: 14),
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 14),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PersonalInfoPage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Color(0xFFF8FAFC)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text("Edit Profile"),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
        letterSpacing: 1,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: _green),
      title: Text(title),
      trailing: trailing ??
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }
}

class _AccountSection extends StatelessWidget {
  const _AccountSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _SettingsTile(
            icon: Icons.person_outline,
            title: "Personal Information",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PersonalInfoPage(),
                ),
              );
            },
          ),
          const Divider(height: 0, color: Color(0xFFF1F5F9)),
          const _SettingsTile(
            icon: Icons.payment,
            title: "Payment Methods",
          ),
          const Divider(height: 0, color: Color(0xFFF1F5F9)),
          const _SettingsTile(
            icon: Icons.security,
            title: "Security",
          ),
          const Divider(height: 0, color: Color(0xFFF1F5F9)),
          _SettingsTile(
            icon: Icons.lock_outline,
            title: "Change Password",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangePasswordPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PreferenceSection extends StatefulWidget {
  const _PreferenceSection();

  @override
  State<_PreferenceSection> createState() => _PreferenceSectionState();
}

class _PreferenceSectionState extends State<_PreferenceSection> {
  bool darkMode = false;
  bool bookingNotifications = true;
  bool remainders = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        children: [
          const _SettingsTile(
            icon: Icons.notifications_none,
            title: "Notification Settings",
          ),
          const Divider(height: 0, color: Color(0xFFF1F5F9)),
          _SettingsTile(
            icon: Icons.dark_mode_outlined,
            title: "Dark Mode",
            trailing: Switch(
              value: darkMode,
              activeColor: _green,
              onChanged: (value) => setState(() => darkMode = value),
            ),
          ),
          const Divider(height: 0, color: Color(0xFFF1F5F9)),
          _SettingsTile(
            icon: Icons.notifications_active_outlined,
            title: "Booking Notifications",
            trailing: Switch(
              value: bookingNotifications,
              activeColor: _green,
              onChanged: (value) =>
                  setState(() => bookingNotifications = value),
            ),
          ),
          const Divider(height: 0, color: Color(0xFFF1F5F9)),
          _SettingsTile(
            icon: Icons.alarm_outlined,
            title: "Reminders",
            trailing: Switch(
              value: remainders,
              activeColor: _green,
              onChanged: (value) => setState(() => remainders = value),
            ),
          ),
        ],
      ),
    );
  }
}

class _SupportSection extends StatelessWidget {
  const _SupportSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        children: [
          const _SettingsTile(
            icon: Icons.help_outline,
            title: "Help Center",
          ),
          const Divider(height: 0, color: Color(0xFFF1F5F9)),
          _SettingsTile(
            icon: Icons.info_outline,
            title: "About Us",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ApiService.logout();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AuthScreen()),
          (route) => false,
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: const Text(
          "Logout",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: const Color(0xFFF1F5F9)),
  );
}