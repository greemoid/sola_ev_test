import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sola_ev_test/presentation/theme/color_palette.dart';

class StationListItem extends StatelessWidget {
  final String title;
  final String address;
  final String imageUrl;
  final num maxPower;
  final double price;
  final TextTheme textTheme;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final VoidCallback onButtonPressed;
  final VoidCallback onArrowPressed;

  const StationListItem({
    super.key,
    required this.title,
    required this.address,
    required this.imageUrl,
    required this.maxPower,
    required this.textTheme,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onButtonPressed,
    required this.onArrowPressed,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitleRow(),
              const SizedBox(height: 24),
              _buildDescriptionColumn(),
              const SizedBox(height: 24),
              _buildRowOfButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                address,
                style: textTheme.bodySmall?.copyWith(
                  color: ColorPalette.secondaryTextColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.star,
            color: isFavorite
                ? ColorPalette.favoriteStarColor
                : ColorPalette.secondaryTextColor,
          ),
          onPressed: onFavoritePressed,
        ),
      ],
    );
  }

  Widget _buildDescriptionColumn() {
    return Column(
      children: [
        _buildInfoRow('icons/lighting.svg', '$maxPower kW'),
        _buildInfoRow('icons/dollar.svg', '\$$price per kW'),
      ],
    );
  }

  Widget _buildInfoRow(String iconPath, String text) {
    return Row(
      children: [
        SvgPicture.asset(iconPath, height: 24, width: 24),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildRowOfButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
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
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
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
              'icons/arrow_right_up.svg',
              height: 24,
              width: 24,
            ),
          ),
        ),
      ],
    );
  }
}
