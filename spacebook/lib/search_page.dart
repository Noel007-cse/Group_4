import 'package:flutter/material.dart';
import 'package:spacebook/TurfListingPage.dart'; // ✅ IMPORTANT IMPORT

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  void _openCategory(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TurfListingPage(
          categoryTitle: category,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F3),
      body: SafeArea(
        child: Column(
          children: [

            // ─── Search Bar ─────────────────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: const TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Search for turfs, study halls...",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 14),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),

            // ─── Recent Searches Card ─────────────────────────────
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                  )
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "RECENT SEARCHES",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _RecentItem(
                    title: "Sports Turf",
                    onTap: () => _openCategory(context, "Sports Turf"),
                  ),

                  _RecentItem(
                    title: "Study Halls",
                    onTap: () => _openCategory(context, "Study Halls"),
                  ),

                  _RecentItem(
                    title: "Libraries",
                    onTap: () => _openCategory(context, "Libraries"),
                  ),

                  _RecentItem(
                    title: "Event Halls",
                    onTap: () => _openCategory(context, "Event Halls"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ─── Recent Search Item Widget ─────────────────────────────

class _RecentItem extends StatelessWidget {

  final String title;
  final VoidCallback? onTap;

  const _RecentItem({
    required this.title,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),

        child: Row(
          children: [

            const Icon(
              Icons.history,
              size: 18,
              color: Colors.grey,
            ),

            const SizedBox(width: 10),

            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}