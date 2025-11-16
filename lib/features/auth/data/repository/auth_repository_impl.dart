import 'package:flutter_tdd_boilerplate/core/error/failures.dart';
import 'package:flutter_tdd_boilerplate/core/network/connection_checker.dart';
import 'package:flutter_tdd_boilerplate/features/auth/data/datasourses/auth_data_source.dart';
import 'package:flutter_tdd_boilerplate/features/auth/domain/entities/user.dart';
import 'package:flutter_tdd_boilerplate/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final ConnectionChecker connectionChecker;

  const AuthRepositoryImpl(this.authDataSource,this.connectionChecker);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
          () async => await authDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
      Future<User> Function() fn,
      ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(const ConnectionFailure(Constants.noConnectionErrorMessage));
      }
      final user = await fn();
      return Right(user);
    } on ServerException catch (e) {
      return  Left(ServerFailure(e.toString()));
    }
  }

}


