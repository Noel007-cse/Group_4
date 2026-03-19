import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
          "About Us",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE9F7EF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.business,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 16),

            /// App Name
            Text(
              "SpaceBook",
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            /// Subtitle
            const Text(
              "Connecting communities with premium spaces to play, study, and grow.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            /// Our Story
            _buildSectionTitle("OUR STORY", context),
            const SizedBox(height: 10),
            _buildCard(
              "Founded in 2023, SpaceBook was born out of the frustration of trying to find reliable public turfs and quiet study areas in bustling cities. What started as a simple directory has evolved into a comprehensive booking platform that empowers thousands of users to reclaim their city's public infrastructure.",
              context,
            ),

            const SizedBox(height: 25),

            /// Our Vision
            _buildSectionTitle("OUR VISION", context),
            const SizedBox(height: 10),
            _buildCard(
              "We envision a world where every individual has seamless access to the spaces they need to thrive—whether it's for physical fitness, creative collaboration, or academic excellence.",
              context,
            ),

            const SizedBox(height: 25),

            /// Contact Info
            _buildSectionTitle("CONTACT INFORMATION", context),
            const SizedBox(height: 10),
            _buildContactCard(context),

            const SizedBox(height: 40),

            /// Version Info
            const Text(
              "Version 2.4.0",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "© 2024 SPACEBOOK INC.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildCard(String text, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: const [
          _ContactRow(
            icon: Icons.email_outlined,
            title: "Email",
            value: "hello@spacebook.com",
          ),
          SizedBox(height: 12),
          _ContactRow(
            icon: Icons.language,
            title: "Website",
            value: "www.spacebook.com",
          ),
          SizedBox(height: 12),
          _ContactRow(
            icon: Icons.location_on_outlined,
            title: "Headquarters",
            value: "123 Innovation Way, Tech District, SF",
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ContactRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}