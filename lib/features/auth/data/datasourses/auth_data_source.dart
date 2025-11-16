import 'package:flutter/cupertino.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/param_keys.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

abstract interface class AuthDataSource {
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password});
}

class AuthDataSourceImpl implements AuthDataSource {
  final http.Client client;

  AuthDataSourceImpl(this.client);

  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await client.post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.login),
          body: {ParamKeys.username: email, ParamKeys.password: password});

      debugPrint("UserResponse : ${response.body.toString()}");
      if (response.statusCode == 200) {
        throw  ServerException();
      }
      return UserModel.formJson(response as Map<String, dynamic>);
    } catch (e) {
      throw ServerException();
    }
  }
}
