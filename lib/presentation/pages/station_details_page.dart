import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sola_ev_test/presentation/bloc/stations_bloc.dart';
import 'package:sola_ev_test/presentation/theme/color_palette.dart';
import 'package:sola_ev_test/presentation/utils/find_max_power.dart';
import 'package:sola_ev_test/presentation/widgets/charging_station_details.dart';
import 'package:sola_ev_test/presentation/widgets/details_container.dart';
import 'package:sola_ev_test/presentation/widgets/favorite_icon_button.dart';

@RoutePage()
class StationDetailsPage extends StatefulWidget {
  const StationDetailsPage({
    super.key,
    @PathParam('stationId') required this.stationId,
  });

  final String stationId;

  @override
  State<StationDetailsPage> createState() => _StationDetailsPageState();
}

class _StationDetailsPageState extends State<StationDetailsPage> {
  bool isItemFavorite = false;

  @override
  void initState() {
    super.initState();
    context.read<StationsBloc>().add(GetStationByIdEvent(id: widget.stationId));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Hero(
      tag: widget.stationId,
      child: Material(
        type: MaterialType.transparency,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => context.router.popForced(),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: Center(
              child: Text(context.router.current.title(context),
                  style: textTheme.titleMedium),
            ),
            actions: [
              BlocListener<StationsBloc, StationsState>(
                listener: (context, state) {
                  if (state is StationByIdLoaded) {
                    setState(() {
                      isItemFavorite = state.station.isFavorite;
                    });
                  }
                },
                child: FavoriteIconButton(
                  isItemFavorite: isItemFavorite,
                  toggleLikeUI: () {
                    setState(() {
                      isItemFavorite = !isItemFavorite;
                    });
                    context
                        .read<StationsBloc>()
                        .add(ToggleLikeStationEvent(id: widget.stationId));
                  },
                ),
              )
            ],
          ),
          body: BlocBuilder<StationsBloc, StationsState>(
            builder: (context, state) {
              if (state is StationsError) {
                return Center(
                    child:
                        Text(state.errorMessage, style: textTheme.bodyLarge));
              } else if (state is StationsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is StationByIdLoaded) {
                final station = state.station;
                final maxPower = findMaxPower(station.connectors ?? []) ?? 0.0;
                final availableConnectors = station.connectors
                        ?.where((c) => c.maxPower != null)
                        .toList() ??
                    [];
                final isPublic = station.isPublic ?? false;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: station.imageUrl ?? '',
                        height: 200,
                        fit: BoxFit.fitHeight,
                      ),
                      const SizedBox(height: 16),
                      Text(station.title ?? '', style: textTheme.titleMedium),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        spacing: 8,
                        children: [
                          DetailsContainer(
                            svgPath: 'icons/lighting.svg',
                            description: 'Max power',
                            textTheme: textTheme,
                            property: '$maxPower kW',
                          ),
                          DetailsContainer(
                            svgPath: 'icons/dollar.svg',
                            description: 'Price',
                            textTheme: textTheme,
                            property: '\$${station.price ?? 0.0}',
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      ChargingStationDetails(
                        address: station.address ?? '',
                        connectors: availableConnectors
                            .map((c) => '${c.type}')
                            .join(', '),
                        availability: isPublic ? 'Public' : 'Private',
                        textTheme: textTheme,
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: ColorPalette.primaryColor,
                            borderRadius: BorderRadius.circular(42),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Call to action',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
