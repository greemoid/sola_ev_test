import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sola_ev_test/presentation/bloc/stations_bloc.dart';
import 'package:sola_ev_test/presentation/widgets/station_list_item.dart';

class AllStationsPage extends StatefulWidget {
  const AllStationsPage({super.key, required this.textTheme});

  final TextTheme textTheme;

  @override
  State<AllStationsPage> createState() => _AllStationsPageState();
}

class _AllStationsPageState extends State<AllStationsPage> {
  @override
  void initState() {
    super.initState();
    context.read<StationsBloc>().add(GetAllStationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: BlocBuilder<StationsBloc, StationsState>(
        builder: (context, state) {
          if (state is StationsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StationsError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: widget.textTheme.bodyLarge,
              ),
            );
          } else if (state is StationsLoaded) {
            return LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 234,
                  ),
                  itemCount: state.stations.length,
                  itemBuilder: (context, index) {
                    final station = state.stations[index];
                    final num? maxPower = station.connectors
                        ?.map((c) => c.maxPower ?? 0)
                        .reduce((a, b) => max(a, b));
                    return StationListItem(
                      title: station.title ?? '',
                      address: station.address ?? '',
                      imageUrl: station.imageUrl ?? '',
                      maxPower: maxPower ?? 0,
                      textTheme: widget.textTheme,
                      isFavorite: station.isFavorite,
                      onFavoritePressed: () {},
                      onButtonPressed: () {},
                      onArrowPressed: () {},
                      price: station.price ?? 0.0,
                    );
                  },
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'Something went wrong',
                style: widget.textTheme.bodyLarge,
              ),
            );
          }
        },
      ),
    );
  }
}
