import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final int count;

  const BadgeWidget({
    super.key,
    required this.icon,
    required this.color,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 2),
        Text(
          count.toString(),
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
