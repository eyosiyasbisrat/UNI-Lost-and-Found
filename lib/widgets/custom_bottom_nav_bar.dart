import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, // Adjust height as needed
      decoration: BoxDecoration(
        color: const Color(0xFF3667B7), // Blue background from your image
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.search, 'Search', 0, '/items-found'),
          _buildNavItem(context, Icons.work_outline, 'Items Lost', 1, '/items-lost'),
          _buildNavItem(context, Icons.add, 'Report Item', 2, '/report-item'),
          _buildNavItem(context, Icons.chat_bubble_outline, 'Chats', 3, '/chats'),
          _buildNavItem(context, Icons.person_outline, 'Profile', 4, '/profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, IconData icon, String label, int index, String routeName) {
    final bool isSelected = currentIndex == index;
    final Color iconColor = isSelected ? Colors.white : Colors.white54;
    final Color textColor = isSelected ? Colors.white : Colors.white54;

    return GestureDetector(
      onTap: () {
        context.go(routeName);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
} 