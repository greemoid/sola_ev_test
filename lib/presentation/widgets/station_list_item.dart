import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sola_ev_test/presentation/theme/color_palette.dart';
import 'package:sola_ev_test/presentation/utils/adjust_svg_path.dart';
import 'package:sola_ev_test/presentation/widgets/details_button.dart';
import 'package:sola_ev_test/presentation/widgets/favorite_icon_button.dart';
import 'package:sola_ev_test/presentation/widgets/primary_button.dart';

class StationListItem extends StatefulWidget {
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
  State<StationListItem> createState() => _StationListItemState();
}

class _StationListItemState extends State<StationListItem> {
  late bool isItemFavorite;

  @override
  void initState() {
    super.initState();
    isItemFavorite = widget.isFavorite;
  }

  void _toggleLikeUI() {
    setState(() {
      isItemFavorite = !isItemFavorite;
    });
    widget.onFavoritePressed();
  }

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
                widget.title,
                style: widget.textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                widget.address,
                style: widget.textTheme.bodySmall?.copyWith(
                  color: ColorPalette.secondaryTextColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        FavoriteIconButton(
          isItemFavorite: isItemFavorite,
          toggleLikeUI: _toggleLikeUI,
        )
      ],
    );
  }

  Widget _buildDescriptionColumn() {
    return Column(
      children: [
        _buildInfoRow('icons/lighting.svg', '${widget.maxPower} kW'),
        _buildInfoRow('icons/dollar.svg', '\$${widget.price} per kW'),
      ],
    );
  }

  Widget _buildInfoRow(String iconPath, String text) {
    return Row(
      children: [
        SvgPicture.asset(adjustSvgPath(iconPath), height: 24, width: 24),
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
          child: PrimaryButton(
              onButtonPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(64),
                        child: Text('Will be soon'),
                      );
                    });
              },
              textTheme: widget.textTheme),
        ),
        const SizedBox(width: 8),
        DetailsButton(onArrowPressed: widget.onArrowPressed),
      ],
    );
  }
}
