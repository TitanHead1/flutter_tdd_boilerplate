import 'package:flutter_tdd_boilerplate/core/network/connection_checker.dart';
import 'package:flutter_tdd_boilerplate/features/auth/data/datasourses/auth_data_source.dart';
import 'package:flutter_tdd_boilerplate/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_tdd_boilerplate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_tdd_boilerplate/features/product/data/datasourses/poduct_data_source.dart';
import 'package:flutter_tdd_boilerplate/features/product/data/repositories/product_repositories_impl.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/repositories/product_repositories.dart';
import 'package:flutter_tdd_boilerplate/features/product/domain/usecases/get_all_products_use_case.dart';
import 'package:flutter_tdd_boilerplate/features/product/presentation/bloc/product_home_bloc.dart';
import 'package:flutter_tdd_boilerplate/presentation/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/utils/database/database_helper.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'package:http/http.dart' as http;

import 'features/dashboard/presentation/cubit/dashboard_cubit.dart';

final serviceLocator = GetIt.instance;

initDependencies() {
//Http
  serviceLocator.registerLazySingleton(() => http.Client());

// core
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
  _initAuth();
  _initApp();
}

void _initApp() {
  serviceLocator
    ..registerFactory<ProductDataSource>(
      () => ProductDatasourceImpl(serviceLocator.get<http.Client>()),
    )
    ..registerFactory<ProductRepositories>(
      () => ProductRepositoriesImpl(serviceLocator()),
    )
    ..registerFactory(
      () => GetAllProductsUseCase(serviceLocator()),
    )
    ..registerLazySingleton<DashboardCubit>(() => DashboardCubit())
    ..registerLazySingleton(
        () => ProductHomeBloc(serviceLocator(), serviceLocator()));
}

void _initAuth() {
  //Datasource
  serviceLocator.registerFactory<AuthDataSource>(
    () => AuthDataSourceImpl(serviceLocator.get<http.Client>()),
  );

  serviceLocator.registerFactory<UserLoginUseCase>(
      () => UserLoginUseCase(serviceLocator()));

  // Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator.get<AuthDataSource>(),
      serviceLocator.get<ConnectionChecker>(),
    ),
  );

  serviceLocator
      .registerFactory<AuthBloc>(() => AuthBloc(userLogin: serviceLocator()));

  serviceLocator
      .registerLazySingleton<ConnectivityBloc>(() => ConnectivityBloc());

  serviceLocator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}
