class UserTokenModel{

  UserTokenModel({required token});


  factory UserTokenModel.formJson(Map<String,dynamic> map){

    return UserTokenModel(
      token: map['token'] ?? '',

    );

  }
}