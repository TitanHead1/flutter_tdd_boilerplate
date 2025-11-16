import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';



/// connectivity events
abstract class ConnectivityEvent {}

class ConnectivityLostEvent extends ConnectivityEvent {}

class ConnectivityRecoverEvent extends ConnectivityEvent {}

class CheckInternetEvent extends ConnectivityEvent {}

/// connectivity states

abstract class ConnectivityState {}

class ConnectivityInitialState extends ConnectivityState {}

class ConnectivityLostState extends ConnectivityState {}

class ConnectivityRecoverState extends ConnectivityState {}

/// main bloc class

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final _connectivity = Connectivity();
  int connectionTimes = 1;
  int errorTimes = 1;

  ConnectivityBloc() : super(ConnectivityInitialState()) {
    on<CheckInternetEvent>((event, emit) async {
      // AppUtil.printLog("CheckInternetEvent hit");
      final connectivityResult = await _connectivity.checkConnectivity();
      //AppLog.printLog("connectivityResult ----$connectivityResult");
      //debugPrint("connectivityResult ----$connectivityResult");

      if (connectivityResult.first == ConnectivityResult.none) {
        debugPrint("connectivityResult ----$connectivityResult");
        if (errorTimes > 2) {
          emit(ConnectivityLostState());
          debugPrint("connectivityResult ----errorTimes2");
        }
      } else {
        debugPrint("connectivityResultElse ----$connectivityResult");
        if (connectionTimes > 2) {
          debugPrint("connectivityResult ----connectionTimes2");
          add(ConnectivityRecoverEvent());
        }
      }
    });

    on<ConnectivityLostEvent>((event, emit) => emit(ConnectivityLostState()));

    on<ConnectivityRecoverEvent>(
        (event, emit) => emit(ConnectivityRecoverState()));

    _connectivity.onConnectivityChanged.listen((event) {
      debugPrint("onConnectivityChanged ----$event");
      if (event.first == ConnectivityResult.none) {
        if (errorTimes > 1) {
          add(ConnectivityLostEvent());
        } else {
          ++errorTimes;
        }
      } else {
        if (connectionTimes > 1) {
          add(ConnectivityRecoverEvent());
        } else {
          connectionTimes += 1;
        }
      }
    });
  }
}
