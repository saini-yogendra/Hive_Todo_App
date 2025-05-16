import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/strings.dart';

class RepTextField extends StatelessWidget {
  const RepTextField({
    super.key,
    required this.controller,
    this.isForDescription = false,
    required this.onFieldSubmitted,
    required this.onChanged,
  });

  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;
  final Function (String)? onChanged;
  final bool isForDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ListTile(
        title: TextFormField(
          controller: controller,
          maxLines: !isForDescription ? 6 : null,
          cursorHeight: !isForDescription? 60 : null,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: isForDescription ? InputBorder.none : null,
            counter: Container(),
            hintText: isForDescription ? AppString.addNote : null,
            prefixIcon:
            isForDescription
                ? Icon(Icons.bookmark_border, color: Colors.grey)
                : null,

            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}