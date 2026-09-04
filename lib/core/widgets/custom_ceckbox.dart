import 'package:flutter/material.dart';

class CustomCeckbox extends StatelessWidget {
  const CustomCeckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });
  final bool value;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Color(0xFF15B86C),
      value: value,

      onChanged: (value) => onChanged(value),
    );
  }
}
