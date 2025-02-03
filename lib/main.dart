import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sola_ev_test/core/di/init_dependencies.dart';
import 'package:sola_ev_test/presentation/bloc/stations_bloc.dart';
import 'package:sola_ev_test/presentation/pages/all_stations_page.dart';
import 'package:sola_ev_test/presentation/theme/export.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<StationsBloc>(),
      child: MaterialApp(
        title: 'Sola',
        theme: theme,
        home: const MyHomePage(title: 'SOLA'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Center(child: Text(title)),
      ),
      body: AllStationsPage(
        textTheme: Theme.of(context).textTheme,
      ),
    );
  }
}
