import 'package:flutter/material.dart';

import '../theme/color_palette.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onButtonPressed,
    required this.textTheme,
  });

  final VoidCallback onButtonPressed;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonPressed,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: ColorPalette.primaryColor,
          borderRadius: BorderRadius.circular(42),
        ),
        alignment: Alignment.center,
        child: Text(
          'Call to action',
          style: textTheme.bodyMedium?.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
