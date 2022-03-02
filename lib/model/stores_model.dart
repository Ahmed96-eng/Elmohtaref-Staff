class StoresModel {
  List<StoresData>? data;
  StoresModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] as List).map((e) => StoresData.fromJson(e)).toList();
  }
}

class StoresData {
  String? id;
  String? storename;
  String? mobile;
  String? secondMobile;
  String? location;
  String? description;
  String? bio;
  String? status;
  String? createAt;

  StoresData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storename = json['name'];
    mobile = json['mobile'];
    secondMobile = json['mobile2'];
    location = json['location'];
    description = json['description'];
    bio = json['bio'];
    status = json['status'];
    createAt = json['created_at'];
  }
}
