class WeeklyWalletModel {
  String? weeklyNumberOfTasks;
  String? weeklyBalance;
  String? weeklyAppFees;
  String? netBalance;
  String? staffFees;
  String? discount;
  String? distance;
  String? tax;
  String? items;
  String? serviceAmount;
  String? maxChartY;
  List<WeeklyWalletData>? data;
  WeeklyWalletModel.fromJson(Map<String, dynamic> json) {
    weeklyNumberOfTasks ??= json['no_tasks'];
    weeklyBalance ??= json['total'];
    weeklyAppFees ??= json['app_fees'];
    netBalance ??= json['net_balance'];
    staffFees ??= json['staff_fees'];
    discount ??= json['discount'];
    distance ??= json['distance'];
    tax ??= json['tax'];
    items ??= json['items'];
    serviceAmount ??= json['service_amount'];
    maxChartY ??= json['max_y'];
    data = (json['data'] as List)
        .map((e) => WeeklyWalletData.fromJson(e))
        .toList();
  }
}

class WeeklyWalletData {
  String? numberOfTasks;
  String? customerId;
  String? date;
  String? total;
  String? day;
  String? dayNumber;
  WeeklyWalletData(
      {this.numberOfTasks,
      this.customerId,
      this.date,
      this.total,
      this.day,
      this.dayNumber});
  WeeklyWalletData.fromJson(Map<String, dynamic> json) {
    numberOfTasks ??= json['no_tasks'];
    customerId ??= json['customer_id'];
    date ??= json['date'];
    total ??= json['total'];
    day ??= json['day'];
    dayNumber ??= json['day_number'];
  }
}
