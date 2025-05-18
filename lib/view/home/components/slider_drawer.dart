import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiveapp/utils/colors.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];

  final List<String> texts = ["Home", "Profile", "Settings", "Details"];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = screenWidth * 0.13; // relative to width
    final verticalPadding = screenHeight * 0.1; // top/bottom padding

    return Container(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundImage: AssetImage("assets/img/avtar.jpg"),
          ),
          SizedBox(height: screenHeight * 0.015),
          Text("Yogi", style: Theme.of(context).textTheme.displayMedium),
          Text("Flutter Dev.", style: Theme.of(context).textTheme.displaySmall),
          SizedBox(height: screenHeight * 0.04),

          // Responsive ListTile Container
          Expanded(
            child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print("${texts[index]} Item tapped");
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.005,
                    ),
                    child: ListTile(
                      leading: Icon(
                        icons[index],
                        color: Colors.white,
                        size: screenWidth * 0.07, // 28–30px depending on device
                      ),
                      title: Text(
                        texts[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
