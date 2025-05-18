import 'package:flutter/material.dart';

class DateTimeSectionWidget extends StatelessWidget {
  const DateTimeSectionWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.time,
    this.isTime = false,
  });

  final VoidCallback onTap;
  final String title;
  final String time;
  final bool isTime;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    double containerHeight = size.height * 0.07; // 55 for normal 800-900 height
    double timeContainerWidth = isTime ? size.width * 0.35 : size.width * 0.2;
    double timeContainerHeight = size.height * 0.045;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(
          size.width * 0.05, // 20
          size.height * 0.025, // 20
          size.width * 0.05,
          0,
        ),
        height: containerHeight,
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
              padding: EdgeInsets.only(left: size.width * 0.025),
              child: Text(
                title,
                style: textTheme.headlineSmall,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: size.width * 0.025),
              width: timeContainerWidth,
              height: timeContainerHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
              ),
              child: Center(
                child: Text(
                  time,
                  style: textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
