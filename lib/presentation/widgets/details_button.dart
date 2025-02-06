import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/color_palette.dart';
import '../utils/adjust_svg_path.dart';

class DetailsButton extends StatelessWidget {
  const DetailsButton({super.key, required this.onArrowPressed});

  final VoidCallback onArrowPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onArrowPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorPalette.primaryColor,
            width: 2,
          ),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          adjustSvgPath('icons/arrow_right_up.svg'),
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}
