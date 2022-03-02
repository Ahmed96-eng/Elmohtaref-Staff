class StaticsTasksModel {
  List<StaticsTasksData>? data;
  StaticsTasksModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] as List)
        .map((e) => StaticsTasksData.fromJson(e))
        .toList();
  }
}

class StaticsTasksData {
  String? id;
  String? title;
  String? customerId;
  String? staffId;
  String? lat;
  String? long;
  String? serviceId;
  String? description;
  String? status;
  String? createdAt;
  StaticsTasksData({
    this.id,
    this.title,
    this.customerId,
    this.staffId,
    this.lat,
    this.long,
    this.serviceId,
    this.description,
    this.status,
    this.createdAt,
  });
  StaticsTasksData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    customerId = json['customer_id'];
    staffId = json['staff_id'];
    lat = json['lat'];
    long = json['long'];
    serviceId = json['service_id'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
  }
}
