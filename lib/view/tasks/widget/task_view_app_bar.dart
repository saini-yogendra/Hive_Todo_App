import 'package:flutter/material.dart';

class TaskViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const TaskViewAppBar({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Padding and icon size relative to the height and screen width
    final leftPadding = screenWidth * 0.05; // 5% of screen width
    final topPadding = height * 0.13; // 13% of app bar height
    final iconSize = height * 0.25; // 25% of app bar height

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Padding(
        padding: EdgeInsets.only(left: leftPadding),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: topPadding),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: iconSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
