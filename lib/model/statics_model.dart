class StaticsModel {
  StaticsData? data;
  StaticsModel.fromJson(Map<String, dynamic> json) {
    data = StaticsData.fromJson(json['data']);
  }
}

class StaticsData {
  String? id;
  String? username;
  String? experience;
  String? rate;
  String? serviceId;
  String? nationality;
  String? noTasks;
  String? noCancelledTasks;
  String? cancelledPercentage;
  String? acceptPercentage;
  String? percentage;

  StaticsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    serviceId = json['service_id'];
    percentage = json['percentage'];
    noTasks = json['no_tasks'];
    noCancelledTasks = json['no_cancelled_tasks'];
    cancelledPercentage = json['cancelled_percentage'];
    acceptPercentage = json['accept_percentage'];
    rate = json['rate'];
    nationality = json['nationality'];
    experience = json['experience'];
  }
}
