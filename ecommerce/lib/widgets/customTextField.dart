import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String validateText;
  final TextInputType ?keyboardType;
  final int ? maxLine;
  const CustomTextField(
      {super.key,
      this.maxLine,
      required this.controller,
      required this.labelText,
      required this.validateText, this.keyboardType});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: widget.controller,
        maxLines: widget.maxLine,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
            labelText: widget.labelText, border: OutlineInputBorder()),
        validator: (value) {
          if (value?.isEmpty ?? false) {
            return widget.validateText;
          }
          return null;
        },
      ),
    );
  }
}
