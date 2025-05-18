import 'package:flutter/material.dart';
import 'package:hiveapp/models/task.dart';
import 'package:hiveapp/view/tasks/components/date_time_selection.dart';
import 'package:hiveapp/view/tasks/components/rep_textfield.dart';
import 'package:intl/intl.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/dialogs.dart';
import '../../../utils/strings.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';


class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
    required this.titleTaskController,
    required this.descriptionTaskController,
    this.task,
  });

  final TextEditingController? titleTaskController;
  final TextEditingController? descriptionTaskController;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  String? title;
  String? subtitle;
  DateTime? time;
  DateTime? date;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      widget.titleTaskController?.text = widget.task!.title;
      widget.descriptionTaskController?.text = widget.task!.subtitle;
      date = widget.task?.createdAtDate ?? DateTime.now();
      time = widget.task?.createdAtTime ?? DateTime.now();
    }
  }

  String showTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      return DateFormat('hh:mm a').format(time ?? DateTime.now());
    } else {
      return DateFormat('hh:mm a').format(widget.task!.createdAtTime);
    }
  }

  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      return DateFormat.yMMMEd().format(date ?? DateTime.now());
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate);
    }
  }


  bool isTaskAlreadyExist() {
    if (
    widget.titleTaskController?.text == null &&
        widget.descriptionTaskController?.text == null
    ) {
      return true;
    } else {
      return false;
    }
  }

  dynamic isTaskAlreadyExistUpdateTask() {
    if (widget.task != null) {
      // Update existing task
      try {
        widget.task!
          ..title = title ?? widget.titleTaskController?.text ?? ''
          ..subtitle = subtitle ?? widget.descriptionTaskController?.text ?? ''
          ..createdAtDate = date ?? widget.task!.createdAtDate
          ..createdAtTime = time ?? widget.task!.createdAtTime;

        widget.task!.save();
        Navigator.of(context).pop();
      } catch (error) {
        nothingEnterOnUpdateTaskMode(context);
      }
    } else {
      // Add new task
      if (title != null && subtitle != null) {
        var task = Task.create(
          title: title!,
          createdAtTime: time ?? DateTime.now(),
          createdAtDate: date ?? DateTime.now(),
          subtitle: subtitle!,
        );
        BaseWidget.of(context).dataStore.addTask(task: task);
        Navigator.of(context).pop();
      } else {
        emptyFieldsWarning(context);
      }
    }
  }

  /// Delete Selected Task
  dynamic deleteTask() {
    return widget.task?.delete();
  }

  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      return date ?? DateTime.now();
    } else {
      return widget.task!.createdAtDate;
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const MyAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopSideTexts(textTheme, screenWidth),
                SizedBox(height: screenHeight * 0.02),

                // Title Label
                Text(
                  AppString.titleOfTitleTextField,
                  style: textTheme.headlineMedium,
                ),
                SizedBox(height: screenHeight * 0.01),

                // Title TextField
                RepTextField(
                  controller: widget.titleTaskController,
                  onFieldSubmitted: (inputTitle) => title = inputTitle,
                  onChanged: (inputTitle) => title = inputTitle,
                ),
                SizedBox(height: screenHeight * 0.015),

                // Description TextField
                RepTextField(
                  isForDescription: true,
                  controller: widget.descriptionTaskController,
                  onFieldSubmitted: (inputSubtitle) => subtitle = inputSubtitle,
                  onChanged: (inputSubtitle) => subtitle = inputSubtitle,
                ),
                SizedBox(height: screenHeight * 0.015),

                // Time Picker
                DateTimeSectionWidget(
                  onTap: () {
                    DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      showSecondsColumn: false,
                      currentTime: showDateAsDateTime(time),
                      onChanged: (_) {},
                      onConfirm: (dateTime) {
                        setState(() {
                          time = dateTime;
                          widget.task?.createdAtTime = dateTime;
                        });
                      },
                    );
                  },
                  title: 'Time',
                  time: showTime(time),
                ),
                SizedBox(height: screenHeight * 0.015),

                // Date Picker
                DateTimeSectionWidget(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      maxTime: DateTime(2030, 4, 5),
                      minTime: DateTime.now(),
                      currentTime: showDateAsDateTime(date),
                      onChanged: (_) {},
                      onConfirm: (dateTime) {
                        setState(() {
                          date = dateTime;
                          widget.task?.createdAtDate = dateTime;
                        });
                      },
                    );
                  },
                  title: AppString.dateString,
                  isTime: true,
                  time: showDate(date),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Bottom Buttons
                _buildBottomButtons(context, screenWidth, screenHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildBottomButtons(BuildContext context, double screenWidth, double screenHeight) {
    final buttonWidth = screenWidth * 0.4;
    final buttonHeight = screenHeight * 0.07;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.03),
      child: Row(
        mainAxisAlignment: isTaskAlreadyExist()
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        children: [
          // Delete Button
          if (!isTaskAlreadyExist())
            Container(
              width: buttonWidth,
              height: buttonHeight,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onPressed: () {
                  deleteTask();
                  Navigator.pop(context);
                },
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.close, color: AppColors.primaryColor),
                    SizedBox(width: 5),
                    Text(
                      AppString.deleteTask,
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ),

          // Add/Update Button
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            minWidth: buttonWidth,
            height: buttonHeight,
            onPressed: () => isTaskAlreadyExistUpdateTask(),
            color: AppColors.primaryColor,
            child: Text(
              isTaskAlreadyExist()
                  ? AppString.addTaskString
                  : AppString.updateTaskString,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }


  // All Bottom Buttons
  Widget _buildTopSideTexts(TextTheme textTheme, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: screenWidth * 0.15, child: const Divider(thickness: 2)),
          Expanded(
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: isTaskAlreadyExist()
                      ? AppString.addNewTask
                      : AppString.updateCurrentTask,
                  style: textTheme.titleLarge,
                  children: const [
                    TextSpan(
                      text: AppString.taskStrnig,
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.15, child: const Divider(thickness: 2)),
        ],
      ),
    );
  }

}

/// AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back_ios_new_rounded, size: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}