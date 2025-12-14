import 'package:flutter/material.dart';
import 'package:sof_task/core/widgets/custom_cached_image_widget.dart';
import 'package:sof_task/features/users/view/widgets/badge_widget.dart';
import '../../model/user_model.dart';

class UserItem extends StatelessWidget {
  final UserModel user;
  final bool isBookmarked;
  final VoidCallback onTap;
  final VoidCallback onBookmarkToggle;

  const UserItem({
    super.key,
    required this.user,
    required this.isBookmarked,
    required this.onTap,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Profile Image
              _buildProfileImage(),

              const SizedBox(width: 12),

              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display Name
                    Text(
                      user.displayName,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // Reputation
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text(
                          user.formattedReputation,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[700]),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Badges
                    if (user.badgeCounts != null) _buildBadges(),
                  ],
                ),
              ),

              // Bookmark Button
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? Colors.blue : Colors.grey,
                ),
                onPressed: onBookmarkToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build profile image with fallback
  Widget _buildProfileImage() {
    if (user.profileImage != null && user.profileImage?.isNotEmpty == true) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CustomCachedImageWidget(
          imageUrl: user.profileImage!,
          height: 70,
          width: 70,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.blue,
          width: 60,
          height: 60,
          child: Center(
            child: Text(
              user.displayName.isNotEmpty
                  ? user.displayName[0].toUpperCase()
                  : '?',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
  }

  /// Build badges display
  Widget _buildBadges() {
    final badges = user.badgeCounts!;

    return Row(
      children: [
        if (badges.gold > 0)
          BadgeWidget(
            icon: Icons.circle,
            color: Colors.amber,
            count: badges.gold,
          ),
        if (badges.gold > 0) const SizedBox(width: 8),
        if (badges.silver > 0)
          BadgeWidget(
            icon: Icons.circle,
            color: Colors.grey,
            count: badges.silver,
          ),
        if (badges.silver > 0) const SizedBox(width: 8),
        if (badges.bronze > 0)
          BadgeWidget(
            icon: Icons.circle,
            color: Colors.brown,
            count: badges.bronze,
          ),
      ],
    );
  }
}
