import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sof_task/features/reputation/model/reputation_model.dart';

class ReputationWidget extends StatelessWidget {
  const ReputationWidget({
    super.key,
    required this.item,
    required this.dateFormat,
  });

  final ReputationModel item;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: item.isPositive
                ? Colors.green.withValues(alpha: 0.1)
                : Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '${item.isPositive ? '+' : ''}${item.reputationChange}',
              style: TextTheme.of(context).titleMedium?.copyWith(
                color: item.isPositive ? Colors.green[700] : Colors.red[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Text(
          item.readableType,
          style: TextTheme.of(
            context,
          ).titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            dateFormat.format(item.date),
            style: TextTheme.of(
              context,
            ).bodySmall?.copyWith(color: Colors.grey[600]),
          ),
        ),
        trailing: item.postId != null
            ? Text('ID: ${item.postId}', style: TextTheme.of(context).bodySmall)
            : null,
      ),
    );
  }
}
