import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:hiveapp/main.dart';
import 'package:hiveapp/models/task.dart';
import 'package:hiveapp/utils/colors.dart';
import 'package:hiveapp/utils/constanst.dart';
import 'package:hiveapp/view/home/components/fab.dart';
import 'package:hiveapp/view/home/widgets/task_widget.dart';
import 'package:lottie/lottie.dart';

import '../../utils/strings.dart';
import 'components/home_app_bar.dart';
import 'components/slider_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  dynamic valueOfIndicator(List<Task> task) {
    return task.isNotEmpty ? task.length : 3;
  }

  int checkDoneTask(List<Task> tasks) {
    return tasks.where((task) => task.isCompleted).length;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTask(),
      builder: (ctx, Box<Task> box, Widget? child) {
        var tasks = box.values.toList();
        tasks.sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));

        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: const Fab(),
          body: SliderDrawer(
            key: drawerKey,
            isDraggable: false,
            animationDuration: 1000,
            slider: CustomDrawer(),
            appBar: HomeAppBar(drawerKey: drawerKey),
            child: _buildHomeBody(textTheme, size, base, tasks),
          ),
        );
      },
    );
  }

  Widget _buildHomeBody(
      TextTheme textTheme, Size size, BaseWidget base, List<Task> tasks) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.08,
                  height: size.width * 0.08,
                  child: CircularProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation(AppColors.primaryColor),
                    backgroundColor: Colors.grey,
                    value: checkDoneTask(tasks) / valueOfIndicator(tasks),
                  ),
                ),
                SizedBox(width: size.width * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppString.mainTitle, style: textTheme.displayLarge),
                      SizedBox(height: size.height * 0.005),
                      Text(
                        "${checkDoneTask(tasks)} of ${tasks.length} task",
                        style: textTheme.titleMedium,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: size.height * 0.015),
            Divider(
              thickness: 2,
              indent: size.width * 0.2,
              endIndent: size.width * 0.05,
            ),
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: tasks.isNotEmpty
                  ? ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  var task = tasks[index];
                  return Dismissible(
                    key: Key(task.id),
                    direction: DismissDirection.horizontal,
                    onDismissed: (_) {
                      base.dataStore.deleteTask(task: task);
                    },
                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: const [
                          Icon(Icons.delete_outline, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(
                            AppString.deletedTask,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    child: TaskWidget(task: task),
                  );
                },
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeIn(
                    child: SizedBox(
                      width: size.width * 0.5,
                      height: size.width * 0.5,
                      child: Lottie.asset(
                        lottieURL,
                        animate: tasks.isNotEmpty ? false : true,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  FadeInUp(
                    from: 30,
                    child: Text(
                      AppString.doneAllTask,
                      style: textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
