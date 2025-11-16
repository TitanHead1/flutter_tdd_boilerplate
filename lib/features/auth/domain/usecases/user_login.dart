import 'package:flutter_tdd_boilerplate/core/error/failures.dart';
import 'package:flutter_tdd_boilerplate/core/usecase/usecase.dart';
import 'package:flutter_tdd_boilerplate/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/user.dart';

class UserLoginUseCase  implements UseCase<User,UserLoginParams>{
  final AuthRepository authRepository;

  const UserLoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> execute(UserLoginParams params) async{
    return await authRepository.loginWithEmailPassword(
        email: params.email, password: params.password);
  }


}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}


