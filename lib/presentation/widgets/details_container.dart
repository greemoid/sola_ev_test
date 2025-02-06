import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sola_ev_test/presentation/theme/color_palette.dart';
import 'package:sola_ev_test/presentation/utils/adjust_svg_path.dart';

class DetailsContainer extends StatelessWidget {
  const DetailsContainer({
    super.key,
    required this.svgPath,
    required this.description,
    required this.textTheme,
    required this.property,
  });

  final String svgPath;
  final String description;
  final TextTheme textTheme;
  final String property;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: ColorPalette.secondaryBackgroundColor),
        child: Row(
          children: [
            SvgPicture.asset(
              adjustSvgPath(svgPath),
              height: 40,
              width: 40,
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: textTheme.bodySmall,
                  overflow: TextOverflow.fade,
                ),
                SizedBox(height: 8),
                Text(
                  property,
                  style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                  overflow: TextOverflow.fade,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
