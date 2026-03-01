import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F3),
      body: SafeArea(
        child: Column(
          children: [
            // Top Search Field
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

            // Recent Searches
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                    "RECENT SEARCHES",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  _RecentItem(title: "Sports Turf",
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const TurfListingPage(),),
                    );
                  },
                  ),
                  _RecentItem(title: "Study Halls",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const StudyHallsScreen(),),);
                  },
                  ),
                  _RecentItem(title: "Libraries"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _RecentItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const _RecentItem({required this.title,
  this.onTap,
  super.key,
  });

  @override
   Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,            // ✅ USE IT HERE
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            const Icon(Icons.history, size: 18, color: Colors.grey),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}