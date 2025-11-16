import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract  interface class AuthRepository{

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}