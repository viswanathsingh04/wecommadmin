// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        this.host,
        this.key,
        this.secret,
    });

    String host;
    String key;
    String secret;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        host: json["Host"],
        key: json["Key"],
        secret: json["Secret"],
    );

    Map<String, dynamic> toJson() => {
        "Host": host,
        "Key": key,
        "Secret": secret,
    };
}
