import 'package:flutter/material.dart';
import 'package:spacebook/models/search_result_model.dart';
import 'package:spacebook/data/turf_result_data.dart';
import 'package:spacebook/widgets/spaces_card_widget.dart';

enum SortType { nearest, priceLow, ratingHigh }
const Color _green = Color(0xFF3F6B00);

// ─── Page ──────────────────────────────────────────────────────────────────────

class TurfListingPage extends StatefulWidget {
  const TurfListingPage({super.key});

  @override
  State<TurfListingPage> createState() => _TurfListingPageState();
}

class _TurfListingPageState extends State<TurfListingPage> {

  late List<SearchResultModel> _turfs;
  SortType _sortType = SortType.nearest;

  @override
  void initState() {
    super.initState();
    _turfs = List.from(allTurfs);
  }

  void _applySort(SortType type) {
    setState(() {
      _sortType = type;
      final sorted = List<SearchResultModel>.from(_turfs);
      switch (type) {
        case SortType.nearest:
          sorted.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
          break;
        case SortType.priceLow:
          sorted.sort((a, b) => a.pricePerHr.compareTo(b.pricePerHr));
          break;
        case SortType.ratingHigh:
          sorted.sort((a, b) => b.rating.compareTo(a.rating));
          break;
      }
      _turfs = sorted;
    });
  }

  String get _sortLabel {
    switch (_sortType) {
      case SortType.nearest:
        return 'Sort by: Nearest';
      case SortType.priceLow:
        return 'Sort by: Price ↑';
      case SortType.ratingHigh:
        return 'Sort by: Rating ↓';
    }
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _SortBottomSheet(
        current: _sortType,
        onSelected: (t) {
          Navigator.pop(context);
          _applySort(t);
        },
      ),
    );
  }

  void _showPriceFilter() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _PriceFilterSheet(
        onApply: () {
          Navigator.pop(context);
          _applySort(SortType.priceLow);
        },
      ),
    );
  }

  void _showRatingFilter() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _RatingFilterSheet(
        onApply: () {
          Navigator.pop(context);
          _applySort(SortType.ratingHigh);
        },
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
            // ── Top bar ──
            _TopBar(),
            const SizedBox(height: 12),

            // ── Filter chips ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Sort button
                  GestureDetector(
                    onTap: _showSortSheet,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 9),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.tune,
                              color: Colors.white, size: 15),
                          const SizedBox(width: 6),
                          Text(
                            _sortLabel,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Price chip
                  _FilterChip(
                    label: 'Price',
                    isActive: _sortType == SortType.priceLow,
                    onTap: _showPriceFilter,
                  ),
                  const SizedBox(width: 10),

                  // Rating chip
                  _FilterChip(
                    label: 'Rating',
                    isActive: _sortType == SortType.ratingHigh,
                    onTap: _showRatingFilter,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Listings ──
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: _turfs.length,
                itemBuilder: (_, i) => SpacesCardWidget(space: _turfs[i]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(activeIndex: 0),
    );
  }
}

// ─── Top Bar ───────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back,
                  color: Colors.black87, size: 18),
            ),
          ),
          const SizedBox(width: 10),

          // Search field
          Expanded(
            child: Container(
              height: 42,
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
                children: const [
                  SizedBox(width: 12),
                  Icon(Icons.search, color: Colors.grey, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Sports Turf',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Dark mode icon
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.dark_mode_outlined,
                color: Colors.black54, size: 18),
          ),
        ],
      ),
    );
  }
}

// ─── Filter Chip ───────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFE8F5E9) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive
                ? const Color(0xFF2E7D32)
                : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? const Color(0xFF2E7D32)
                    : Colors.black87,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color:
                  isActive ? const Color(0xFF2E7D32) : Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Turf Card ─────────────────────────────────────────────────────────────────


// ─── Sort Bottom Sheet ─────────────────────────────────────────────────────────

class _SortBottomSheet extends StatelessWidget {
  final SortType current;
  final ValueChanged<SortType> onSelected;

  const _SortBottomSheet({
    required this.current,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final options = [
      (SortType.nearest, Icons.near_me_outlined, 'Nearest First'),
      (SortType.priceLow, Icons.currency_rupee, 'Price: Low to High'),
      (SortType.ratingHigh, Icons.star_outline, 'Rating: High to Low'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Text(
            'Sort By',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 16),
          ...options.map((opt) {
            final isSelected = current == opt.$1;
            return GestureDetector(
              onTap: () => onSelected(opt.$1),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFE8F5E9)
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF2E7D32)
                        : Colors.grey.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(opt.$2,
                        color: isSelected
                            ? const Color(0xFF2E7D32)
                            : Colors.black54,
                        size: 20),
                    const SizedBox(width: 12),
                    Text(
                      opt.$3,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: isSelected
                            ? const Color(0xFF2E7D32)
                            : Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    if (isSelected)
                      const Icon(Icons.check_circle,
                          color: Color(0xFF2E7D32), size: 20),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Price Filter Sheet ────────────────────────────────────────────────────────

class _PriceFilterSheet extends StatefulWidget {
  final VoidCallback onApply;

  const _PriceFilterSheet({required this.onApply});

  @override
  State<_PriceFilterSheet> createState() => _PriceFilterSheetState();
}

class _PriceFilterSheetState extends State<_PriceFilterSheet> {
  RangeValues _range = const RangeValues(500, 2000);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Text(
            'Filter by Price',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${_range.start.toInt()}',
                style: const TextStyle(
                    color: Color(0xFF2E7D32), fontWeight: FontWeight.bold),
              ),
              Text(
                '₹${_range.end.toInt()}',
                style: const TextStyle(
                    color: Color(0xFF2E7D32), fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF2E7D32),
              thumbColor: const Color(0xFF2E7D32),
              overlayColor:
                  const Color(0xFF2E7D32).withOpacity(0.15),
              inactiveTrackColor: Colors.grey[300],
            ),
            child: RangeSlider(
              values: _range,
              min: 0,
              max: 3000,
              divisions: 30,
              onChanged: (v) => setState(() => _range = v),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onApply,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Apply — Sort Price Low to High',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Rating Filter Sheet ───────────────────────────────────────────────────────

class _RatingFilterSheet extends StatefulWidget {
  final VoidCallback onApply;

  const _RatingFilterSheet({required this.onApply});

  @override
  State<_RatingFilterSheet> createState() => _RatingFilterSheetState();
}

class _RatingFilterSheetState extends State<_RatingFilterSheet> {
  double _minRating = 4.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Text(
            'Filter by Rating',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 16),

          // Star selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [4.0, 4.2, 4.5, 4.7, 4.9].map((r) {
              final selected = _minRating == r;
              return GestureDetector(
                onTap: () => setState(() => _minRating = r),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF2E7D32)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF2E7D32)
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star,
                          color: selected
                              ? Colors.white
                              : const Color(0xFFFFC107),
                          size: 14),
                      const SizedBox(width: 4),
                      Text(
                        r.toString(),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Show venues rated $_minRating and above',
              style:
                  const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onApply,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Apply — Sort by Highest Rating',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom Nav Bar ────────────────────────────────────────────────────────────

class _BottomNavBar extends StatelessWidget {
  final int activeIndex;

  const _BottomNavBar({required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    const items = [
      _NavItemData(icon: Icons.home_outlined, label: 'Home'),
      _NavItemData(icon: Icons.calendar_today_outlined, label: 'Bookings'),
      _NavItemData(icon: Icons.grid_view_outlined, label: 'My Spaces'),
      _NavItemData(icon: Icons.person_outline, label: 'Profile'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              items.length,
              (i) => _NavItem(
                icon: items[i].icon,
                label: items[i].label,
                active: i == activeIndex,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;

  const _NavItemData({required this.icon, required this.label});
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF2E7D32) : Colors.grey;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: active ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}