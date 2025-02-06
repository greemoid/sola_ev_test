import 'package:flutter/material.dart';
import 'package:sola_ev_test/presentation/theme/color_palette.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    super.key,
    required this.isItemFavorite,
    required this.toggleLikeUI,
  });

  final bool isItemFavorite;
  final VoidCallback toggleLikeUI;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.star,
        color: isItemFavorite
            ? ColorPalette.favoriteStarColor
            : ColorPalette.secondaryTextColor,
      ),
      onPressed: toggleLikeUI,
    );
  }
}
