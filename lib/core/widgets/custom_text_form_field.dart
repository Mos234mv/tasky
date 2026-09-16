import 'package:flutter/material.dart';
import 'package:todoprof/core/constants/app_sizes.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.maxlines,
    required this.hintText,
    this.validator,
    required this.title,
  });

  final TextEditingController controller;
  final int? maxlines;
  final String hintText;
  final String? Function(String?)? validator;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.displaySmall!.copyWith(fontSize: AppSizes.sp16),
        ),

        SizedBox(height: AppSizes.ph8),
        TextFormField(
          controller: controller,

          style: Theme.of(context).textTheme.labelMedium,
          maxLines: maxlines,

          decoration: InputDecoration(hintText: hintText),

          validator: validator,
        ),
      ],
    );
  }
}
