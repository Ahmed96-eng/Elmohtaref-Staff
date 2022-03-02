class TasksModel {
  Tasks? tasks;
  TasksModel.fromJson(Map<String, dynamic> json) {
    tasks = Tasks.fromJson(json['data']);
  }
}

class Tasks {
  TasksData? tasksData;
  Tasks.fromJson(Map<String, dynamic> json) {
    tasksData = TasksData.fromJson(json['tasks']);
  }
}

class TasksData {
  List<CustomerData>? customerData;
  List<TaskDetails>? taskDetails;
  TasksData.fromJson(Map<String, dynamic> json) {
    customerData = (json['customer'] as List)
        .map((e) => CustomerData.fromJson(e))
        .toList();
    taskDetails = (json['task_detail'] as List)
        .map((e) => TaskDetails.fromJson(e))
        .toList();
  }
}

class CustomerData {
  String? id;
  String? username;
  String? email;
  String? lat;
  String? long;
  String? mobile;
  String? profile;
  String? location;
  String? rate;
  CustomerData({
    this.id,
    this.username,
    this.email,
    this.lat,
    this.long,
    this.mobile,
    this.profile,
    this.location,
    this.rate,
  });
  CustomerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    lat = json['lat'];
    long = json['long'];
    mobile = json['mobile'];
    profile = json['profile'];
    location = json['location'];
    rate = json['rate'];
  }
}

class TaskDetails {
  String? id;
  String? title;
  String? description;
  String? lat;
  String? long;
  String? distance;
  String? taskLocation;
  String? time;
  String? created;
  TaskDetails({
    this.id,
    this.title,
    this.description,
    this.lat,
    this.long,
    this.distance,
    this.taskLocation,
    this.time,
    this.created,
  });
  TaskDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    lat = json['lat'];
    long = json['long'];
    distance = json['distance'];
    taskLocation = json['task_location'];
    time = json['time'];
    created = json['created'];
  }
}
