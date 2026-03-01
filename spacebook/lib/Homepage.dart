import 'package:flutter/material.dart';
import 'package:spacebook/data/recommedation_data.dart';
import 'package:spacebook/main.dart';
import 'package:spacebook/models/category_item_model.dart';
import 'package:spacebook/models/space_frame_model.dart';
import 'package:spacebook/mybookings.dart';
import 'package:spacebook/search_page.dart';
import 'package:spacebook/widgets/spaces_card_widget.dart';
import 'package:spacebook/widgets/search_result_widget.dart'; // ✅ added for navigation
import 'data/category_item_data.dart';

const Color _green = Color(0xFF3F6B00);

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
                  color: _green,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // Pass context so each item can navigate
          children: categories
              .map((category) => _CategoryItem(
                    category: category,
                    onTap: () => _onCategoryTap(context, category.label),
                  ))
              .toList(),
        ),
      ],
    );
  }

  void _onCategoryTap(BuildContext context, String label) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultPage(categoryTitle: label),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final CategoryItemModel category;
  final VoidCallback? onTap;

  const _CategoryItem({required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: category.bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(category.icon, color: category.iconColor, size: 28),
            ),
            const SizedBox(height: 7),
            Text(
              category.label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11.5, color: Colors.black87),
            ),
          ],
        ),
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
        color: _green,
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
                  foregroundColor: _green,
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
  // ✅ Kept exactly as-is — uses allRecommended from recommedation_data.dart
  final List<SpaceFrameModel> spaces = allRecommended;

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
                  color: _green,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 14),
        // ✅ Kept exactly as-is — uses SpacesCardWidget
        ...spaces.map((space) => SpacesCardWidget(space: space)),
      ],
    );
  }
}