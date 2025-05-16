// import 'package:flutter/material.dart';
// import 'package:ftoast/ftoast.dart';
// import 'package:panara_dialogs/panara_dialogs.dart';
//
// ///
// import '../utils/strings.dart';
// import '../../main.dart';
//
// /// Empty Title & Subtite TextFields Warning
// emptyFieldsWarning(context) {
//   return FToast.toast(
//     context,
//     msg: AppString.oopsMsg,
//     subMsg: "You must fill all Fields!",
//     corner: 20.0,
//     duration: 2000,
//     padding: const EdgeInsets.all(20),
//   );
// }
//
// /// Nothing Enter When user try to edit the current tesk
// nothingEnterOnUpdateTaskMode(context) {
//   return FToast.toast(
//     context,
//     msg: AppString.oopsMsg,
//     subMsg: "You must edit the tasks then try to update it!",
//     corner: 20.0,
//     duration: 3000,
//     padding: const EdgeInsets.all(20),
//   );
// }
//
// /// No task Warning Dialog
// dynamic warningNoTask(BuildContext context) {
//   return PanaraInfoDialog.showAnimatedGrow(
//     context,
//     title: AppString.oopsMsg,
//     message:
//         "There is no Task For Delete!\n Try adding some and then try to delete it!",
//     buttonText: "Okay",
//     onTapDismiss: () {
//       Navigator.pop(context);
//     },
//     panaraDialogType: PanaraDialogType.warning,
//   );
// }
//
// /// Delete All Task Dialog
// dynamic deleteAllTask(BuildContext context) {
//   return PanaraConfirmDialog.show(
//     context,
//     title: AppString.areYouSure,
//     message:
//         "Do You really want to delete all tasks? You will no be able to undo this action!",
//     confirmButtonText: "Yes",
//     cancelButtonText: "No",
//     onTapCancel: () {
//       Navigator.pop(context);
//     },
//     onTapConfirm: () {
//       BaseWidget.of(context).dataStore.box.clear();
//       Navigator.pop(context);
//     },
//     panaraDialogType: PanaraDialogType.error,
//     barrierDismissible: false,
//   );
// }

import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:hiveapp/main.dart';
import 'package:hiveapp/utils/strings.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

/// lottie asset address
String lottieURL = 'assets/lottie/1.json';


// Empty Title or subtitle textfield warning
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(
      context,
    msg: AppString.oopsMsg,
    subMsg: 'You Must fill all fields!',
    corner: 20.0,
    duration: 2000,
    padding: EdgeInsets.all(20)
  );
}

// nothing entered when user try to edit or update the current task
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(
      context,
      msg: AppString.oopsMsg,
      subMsg: 'You must edit the task then try to update it!',
      corner: 20.0,
      duration: 5000,
      padding: EdgeInsets.all(20)
  );
}

// no task warning dialog for deleting
dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
      context,
      message: "There is no Task for Delete!\n Try adding some and then try to delete it!",
      buttonText: "Okay",
      onTapDismiss: () {
        Navigator.pop(context);
      },
      panaraDialogType: PanaraDialogType.warning,
  );
}

// Delete all task from DB Dialog
dynamic deleteAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(
      context,
      title: AppString.areYouSure,
      message: "Do you really want to delete all tasks? You will no be able to undo this action!",
      confirmButtonText: "Yes",
      cancelButtonText: "No",
      onTapConfirm: () {
        // we will clear all box data using this command
        BaseWidget.of(context).dataStore.box.clear();
        Navigator.pop(context);
      },
      onTapCancel: () {
        Navigator.pop(context);
      },
      panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,

  );
}