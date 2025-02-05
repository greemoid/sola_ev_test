import 'package:flutter/material.dart';
import 'package:sola_ev_test/presentation/theme/color_palette.dart';

class ChargingStationDetails extends StatelessWidget {
  final String address;
  final String connectors;
  final String availability;
  final TextTheme textTheme;

  const ChargingStationDetails({
    super.key,
    required this.address,
    required this.connectors,
    required this.availability,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorPalette.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Full address:', address),
          _buildInfoRow('Connectors:', connectors),
          _buildInfoRow('Availability:', availability),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textTheme.bodySmall,
          ),
          SizedBox(width: 24),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                overflow: TextOverflow.fade,
                softWrap: true,
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
