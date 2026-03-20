import 'package:flutter/material.dart';
import 'package:spacebook/models/space_frame_model.dart';
import 'package:spacebook/services/api_service.dart';
import 'package:spacebook/widgets/space_frame_widget.dart';

class FavoritesCardWidget extends StatefulWidget {
  final SpaceFrameModel space;
  final VoidCallback? onRefresh;

  const FavoritesCardWidget({
    super.key,
    required this.space,
    this.onRefresh,
  });

  @override
  State<FavoritesCardWidget> createState() => _FavoritesCardWidgetState();
}

class _FavoritesCardWidgetState extends State<FavoritesCardWidget> {
  bool _isFav = false;

  void _openDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SpaceFrameWidget(space: widget.space),
      ),
    ).then((_) => widget.onRefresh?.call());
  }

  @override
  Widget build(BuildContext context) {
    final space = widget.space;
    _isFav = space.isFavorite;
    return GestureDetector(
      onTap: _openDetail,
      child: Container(
        width: 160, 
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
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
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                  child: AspectRatio(
                    aspectRatio: 4 / 2, // good for small cards
                    child: Image.network(
                      space.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.image, color: Colors.grey),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 8,
                  left: 8,
                  child: GestureDetector(
                    onTap: () async {
                      await ApiService.toggleFavorite(space.id, _isFav);
                      widget.onRefresh?.call();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                              _isFav ? Icons.favorite : Icons.favorite_border,
                              color: _isFav ? Colors.red : Colors.black54,
                              size: 16,
                            ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    space.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer,
                    ),
                  ),
                  Text(
                    '₹${space.pricePerHr} /hr',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
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