import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String label;
  final bool isPass;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const CustomTextfield({
    super.key,
    required this.label,
    this.isPass = false,
    required this.controller,
    this.onChanged,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 440,
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.controller,
        autofocus: true,
        obscureText: widget.isPass,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.label,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Empty Fields!';
          }
          return null;
        },
      ),
    );
  }
}
