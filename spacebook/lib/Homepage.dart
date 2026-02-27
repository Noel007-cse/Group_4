import 'package:flutter/material.dart';
import 'package:spacebook/main.dart';
import 'package:spacebook/mybookings.dart';
import 'package:spacebook/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(),
              const SizedBox(height: 16),
              _SearchBar(),
              const SizedBox(height: 24),
              _CategoriesSection(),
              const SizedBox(height: 20),
              _HostBanner(),
              const SizedBox(height: 24),
              _FavoritesSection(),
              const SizedBox(height: 24),
              _RecommendedSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Header ────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back,',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Hello, Sourav',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),

        // 🌙 Dark Mode Button
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode_outlined,
              size: 20,
            ),
            onPressed: () {
              SpaceBookApp.of(context)?.toggleTheme();
            },
          ),
        ),
      ],
    );
  }
}

// ─── Search Bar ────────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchPage(),
          ),
        );

      },
      child: Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          const Icon(Icons.search, color: Colors.grey, size: 20),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Search sports, study, or events...',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.tune, color: Colors.black54, size: 18),
          ),
        ],
      ),
    ),
    );
    
  }
}

// ─── Categories ────────────────────────────────────────────────────────────────

class _CategoriesSection extends StatelessWidget {
  final List<Map<String, dynamic>> categories = const [
    {
      'label': 'Sports Turfs',
      'icon': Icons.sports_soccer,
      'color': Color(0xFFE8F5E9),
      'iconColor': Color(0xFF2E7D32),
    },
    {
      'label': 'Study Halls',
      'icon': Icons.menu_book_outlined,
      'color': Color(0xFFE3F2FD),
      'iconColor': Color(0xFF1565C0),
    },
    {
      'label': 'Libraries',
      'icon': Icons.local_library_outlined,
      'color': Color(0xFFFFF3E0),
      'iconColor': Color(0xFFE65100),
    },
    {
      'label': 'Halls and Events',
      'icon': Icons.celebration_outlined,
      'color': Color(0xFFF3E5F5),
      'iconColor': Color(0xFF6A1B9A),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            Text(
              'See All',
              style: TextStyle(
                  fontSize: 13,
                  color: const Color(0xFF2E7D32),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories
              .map((cat) => _CategoryItem(
                    label: cat['label'],
                    icon: cat['icon'],
                    bgColor: cat['color'],
                    iconColor: cat['iconColor'],
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;

  const _CategoryItem({
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(height: 7),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11.5, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// ─── Host Banner ───────────────────────────────────────────────────────────────

class _HostBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D32),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Decorative background icon
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(
              Icons.store_outlined,
              size: 100,
              color: Colors.white.withOpacity(0.12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Host Your Space &\nEarn More!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Turn your empty rooms or fields\ninto income. It\'s free to list.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF2E7D32),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'List Your Space',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Favorites ─────────────────────────────────────────────────────────────────

class _FavoritesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Favorites',
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withOpacity(0.25),
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.favorite_border,
                  size: 36, color: Colors.grey.withOpacity(0.4)),
              const SizedBox(height: 12),
              const Text(
                'No favorites yet',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Tap the heart icon on any space to\nsave it here for quick access',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Recommended Section ───────────────────────────────────────────────────────

class _RecommendedSection extends StatelessWidget {
  final List<Map<String, dynamic>> spaces = const [
    {
      'title': 'Premier Arena Soccer Turf',
      'distance': '2.4 km away',
      'price': '₹1,200',
      'rating': '4.8',
      'image': 'https://images.unsplash.com/photo-1529900748604-07564a03e7a6?w=600',
    },
    {
      'title': 'Focus Hub Study Library',
      'distance': '0.8 km away',
      'price': '₹150',
      'rating': '4.9',
      'image': 'https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=600',
    },
    {
      'title': 'The Grand Ballroom',
      'distance': '5.1 km away',
      'price': '₹8,000',
      'rating': '4.5',
      'image': 'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?w=600',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recommended for You',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            Text(
              'View map',
              style: TextStyle(
                  fontSize: 13,
                  color: const Color(0xFF2E7D32),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...spaces.map((space) => _SpaceCard(space: space)),
      ],
    );
  }
}

class _SpaceCard extends StatelessWidget {
  final Map<String, dynamic> space;

  const _SpaceCard({required this.space});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(14)),
                child: Image.network(
                  space['image'],
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 170,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                ),
              ),
              // Favorite button
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite_border,
                      color: Colors.black54, size: 18),
                ),
              ),
              // Rating badge
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star,
                          color: Color(0xFFFFC107), size: 14),
                      const SizedBox(width: 3),
                      Text(
                        space['rating'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Details
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        space['title'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 13, color: Colors.grey),
                          const SizedBox(width: 3),
                          Text(
                            space['distance'],
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: space['price'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const TextSpan(
                        text: ' /hr',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

