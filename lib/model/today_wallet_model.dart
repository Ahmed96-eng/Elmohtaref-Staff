class TodayWalletModel {
  String? todayNumberOfTasks;
  String? todayBalance;
  String? todayAppFees;
  String? netBalance;
  String? staffFees;
  String? discount;
  String? distance;
  String? tax;
  String? items;
  String? serviceAmount;

  TodayWalletModel.fromJson(Map<String, dynamic> json) {
    todayNumberOfTasks ??= json['no_tasks'];
    todayBalance ??= json['total'];
    todayAppFees ??= json['app_fees'];
    netBalance ??= json['net_balance'];
    staffFees ??= json['staff_fees'];
    discount ??= json['discount'];
    distance ??= json['distance'];
    tax ??= json['tax'];
    items ??= json['items'];
    serviceAmount ??= json['service_amount'];
  }
}
