import 'package:flutter/material.dart';
import 'package:spacebook/models/space_frame_model.dart';
import 'package:spacebook/services/api_service.dart';
import 'package:spacebook/widgets/space_frame_widget.dart';

class SpacesCardWidget extends StatefulWidget {
  final SpaceFrameModel space;

  const SpacesCardWidget({required this.space});

  @override
  State<SpacesCardWidget> createState() => _SpacesCardWidgetState();
}

class _SpacesCardWidgetState extends State<SpacesCardWidget> {
  late bool _isFav;

  @override
  void initState() {
    super.initState();
    _isFav = ApiService.isFavorite(widget.space.id);
  }

  void _openDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SpaceFrameWidget(space: widget.space),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final space = widget.space;
    return GestureDetector(
      onTap: _openDetail,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    space.imageUrl,
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 190,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image,
                          size: 50, color: Colors.grey),
                    ),
                  ),
                ),

                // Favorite button
                Positioned(
                  top: 12,
                  left: 12,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFav = !_isFav;
                        ApiService.toggleFavorite(widget.space);
                      });
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isFav ? Icons.favorite : Icons.favorite_border,
                        color: _isFav ? Colors.red : Colors.black54,
                        size: 18,
                      ),
                    ),
                  ),
                ),

                // Rating badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star,
                            color: Color(0xFFFFC107), size: 14),
                        const SizedBox(width: 3),
                        Text(
                          space.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          space.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined,
                                size: 13, color: Colors.grey),
                            const SizedBox(width: 3),
                            Text(
                              '${space.distanceKm.toStringAsFixed(1)} km away',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '₹${space.pricePerHr}',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const TextSpan(
                          text: ' /hr',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
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
      ),
    );
  }
}