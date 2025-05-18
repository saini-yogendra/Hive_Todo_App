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

  final TextEditingController? controller;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final bool isForDescription;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04), // 4% horizontal padding
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // vertical padding for spacing
      child: TextFormField(
        controller: controller,
        maxLines: isForDescription ? null : 2,
        cursorHeight: isForDescription ? null : screenHeight * 0.04,
        style: TextStyle(
          color: Colors.black,
          fontSize: screenWidth * 0.04, // Responsive font size
        ),
        decoration: InputDecoration(
          border: isForDescription ? InputBorder.none : null,
          counter: const SizedBox.shrink(),
          hintText: isForDescription ? AppString.addNote : null,
          hintStyle: TextStyle(
            fontSize: screenWidth * 0.04,
            color: Colors.grey,
          ),
          prefixIcon: isForDescription
              ? Icon(
            Icons.bookmark_border,
            color: Colors.grey,
            size: screenWidth * 0.06,
          )
              : null,
          contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.015,
          ),
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
    );
  }
}
