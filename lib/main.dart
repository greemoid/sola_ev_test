import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sola_ev_test/core/di/init_dependencies.dart';
import 'package:sola_ev_test/core/router/app_router.dart';
import 'package:sola_ev_test/presentation/bloc/stations_bloc.dart';
import 'package:sola_ev_test/presentation/pages/all_stations_page.dart';
import 'package:sola_ev_test/presentation/theme/export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<StationsBloc>(),
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        title: 'Sola',
        theme: theme,
        // home: const MyHomePage(title: 'SOLA'),
      ),
    );
  }
}

@RoutePage()
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Center(child: Text('SOLA')),
      ),
      body: AllStationsPage(
        textTheme: Theme.of(context).textTheme,
      ),
    );
  }
}
