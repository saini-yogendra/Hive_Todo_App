import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeSectionWidget extends StatelessWidget {
  const DateTimeSectionWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.isTime,
  });

  final VoidCallback onTap;
  final String title;
  final bool isTime;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                title,
                style: textTheme.headlineSmall,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 12),
              width: size.width * 0.2,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
              ),
              child: Center(
                child: Text(
                  isTime ? "Time" : "Date",
                  style: textTheme.titleSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}