class AuthModelModel {
  UserData? data;
  AuthModelModel.fromJson(Map<String, dynamic> json) {
    data = UserData.fromJson(json['data']);
  }
}

class UserData {
  String? id;
  String? username;
  String? email;
  String? password;
  String? mobile;
  String? secondMobile;
  String? profile;
  String? passport;
  String? serviceId;
  String? job;
  String? balance;
  String? nationality;
  String? long;
  String? lat;
  String? location;
  String? deviceToken;
  String? token;
  String? appFees;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    mobile = json['mobile'];
    secondMobile = json['mobile2'];
    profile = json['profile'];
    passport = json['passport'];
    serviceId = json['service_id'];
    job = json['job'];
    balance = json['balance'];
    nationality = json['nationality'];
    long = json['long'];
    lat = json['lat'];
    location = json['location'];
    deviceToken = json['deviceToken'];
    token = json['token'];
    appFees = json['app_fees'];
  }
}
