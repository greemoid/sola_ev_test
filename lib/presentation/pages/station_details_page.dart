import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sola_ev_test/presentation/bloc/stations_bloc.dart';
import 'package:sola_ev_test/presentation/utils/find_max_power.dart';
import 'package:sola_ev_test/presentation/widgets/charging_station_details.dart';
import 'package:sola_ev_test/presentation/widgets/details_container.dart';
import 'package:sola_ev_test/presentation/widgets/favorite_icon_button.dart';

@RoutePage()
class StationDetailsPage extends StatefulWidget {
  const StationDetailsPage(
      {super.key,
      required this.stationId,
      required this.textTheme,
      required this.isFavorite});

  final String stationId;
  final TextTheme textTheme;
  final bool isFavorite;

  @override
  State<StationDetailsPage> createState() => _StationDetailsPageState();
}

class _StationDetailsPageState extends State<StationDetailsPage> {
  bool isItemFavorite = false;

  @override
  void initState() {
    super.initState();
    isItemFavorite = widget.isFavorite;
    context.read<StationsBloc>().add(GetStationByIdEvent(id: widget.stationId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.router.popUntilRouteWithName('/allStations'),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Center(
          child: Text('Details', style: widget.textTheme.titleMedium),
        ),
        actions: [
          FavoriteIconButton(
            isItemFavorite: isItemFavorite,
            toggleLikeUI: () {
              setState(() => isItemFavorite = !isItemFavorite);
              context
                  .read<StationsBloc>()
                  .add(ToggleLikeStationEvent(id: widget.stationId));
            },
          )
        ],
      ),
      body: BlocBuilder<StationsBloc, StationsState>(
        builder: (context, state) {
          if (state is StationsError) {
            return Center(
                child: Text(state.errorMessage,
                    style: widget.textTheme.bodyLarge));
          } else if (state is StationsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StationByIdLoaded) {
            final station = state.station;
            final maxPower = findMaxPower(station.connectors ?? []) ?? 0.0;
            final availableConnectors =
                station.connectors?.where((c) => c.maxPower != null).toList() ??
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
                  Text(station.title ?? '',
                      style: widget.textTheme.titleMedium),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 8,
                    children: [
                      DetailsContainer(
                        svgPath: 'icons/lighting.svg',
                        description: 'Max power',
                        textTheme: widget.textTheme,
                        property: '$maxPower kW',
                      ),
                      DetailsContainer(
                        svgPath: 'icons/dollar.svg',
                        description: 'Price',
                        textTheme: widget.textTheme,
                        property: '\$${station.price ?? 0.0}',
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  ChargingStationDetails(
                    address: station.address ?? '',
                    connectors:
                        availableConnectors.map((c) => '${c.type}').join(', '),
                    availability: isPublic ? 'Public' : 'Private',
                    textTheme: widget.textTheme,
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Call To Action'),
                  ),
                ],
              ),
            );
          } else {
            return Center(
                child: Text('Something went wrong',
                    style: widget.textTheme.bodyLarge));
          }
        },
      ),
    );
  }
}
