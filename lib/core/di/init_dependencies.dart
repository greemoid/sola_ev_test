import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sola_ev_test/data/datasources/ilocal_data_source.dart';
import 'package:sola_ev_test/data/datasources/inetwork_data_source.dart';
import 'package:sola_ev_test/data/datasources/local_data_source.dart';
import 'package:sola_ev_test/data/datasources/network_data_source.dart';
import 'package:sola_ev_test/data/repositories/stations_repository.dart';
import 'package:sola_ev_test/domain/repositories/istations_repository.dart';
import 'package:sola_ev_test/presentation/bloc/stations_bloc.dart';

part 'init_dependencies_main.dart';
