import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiveapp/extensions/space_exs.dart';
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
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 90),
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
            radius: 50,
            backgroundImage: AssetImage("assets/img/avtar.jpg"),
          ),
          8.h,
          Text("Yogi", style: textTheme.displayMedium),
          Text("Flutter Dev.", style: textTheme.displaySmall),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print(texts[index] + " Item tapped");
                  },
                  child: Container(
                    margin: EdgeInsets.all(3),
                    child: ListTile(
                      leading: Icon(icons[index], color: Colors.white, size: 30),
                      title: Text(
                        texts[index],
                        style: TextStyle(color: Colors.white),
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
