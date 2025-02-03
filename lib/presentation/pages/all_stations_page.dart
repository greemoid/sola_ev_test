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
      padding: EdgeInsets.all(16),
      child: BlocBuilder<StationsBloc, StationsState>(
        builder: (context, state) {
          if (state is StationsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is StationsError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          } else if (state is StationsLoaded) {
            return ListView.separated(
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
                separatorBuilder: (context, index) => SizedBox(
                      height: 8,
                    ),
                itemCount: state.stations.length);
          } else {
            return Center(
              child: Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }
        },
      ),
    );
  }
}
