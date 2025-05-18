import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiveapp/view/tasks/task_view.dart';

import '../../../utils/colors.dart';

class Fab extends StatelessWidget {
  const Fab({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => TaskView(
              task: null,
              titleTaskController: null,
              descriptionTaskController: null,

            ),
          ),
        );
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(child: Icon(Icons.add, color: Colors.white)),
        ),
      ),
    );
  }
}
