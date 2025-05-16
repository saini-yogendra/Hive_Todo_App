import 'package:flutter/material.dart';

void emptyFieldsWarning(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Empty Fields"),
      content: const Text("Please enter both Title and Subtitle."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}

void nothingEnterOnUpdateTaskMode(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("No Changes Detected"),
      content: const Text("Nothing was changed to update."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
