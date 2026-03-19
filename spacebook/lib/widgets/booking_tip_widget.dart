import 'package:flutter/material.dart';

class NearbyTipCard extends StatelessWidget {
  const NearbyTipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'BOOKING TIP',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                        height: 1.4),
                    children: [
                      TextSpan(text: 'Arrive 10 minutes early at '),
                      TextSpan(
                        text: 'the Venue',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                          text:
                              ' to complete your check-in process seamlessly.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}