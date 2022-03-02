class TodaySummaryModel {
  String? todayNumberOfTasks;
  String? todayBalance;
  String? todayAppFees;
  String? netBalance;

  List<TodaySummaryData>? data;
  TodaySummaryModel.fromJson(Map<String, dynamic> json) {
    todayNumberOfTasks ??= json['no_tasks'];
    todayBalance ??= json['today_balance'];
    todayAppFees ??= json['today_app_fees'];
    netBalance ??= json['net_balance'];

    data = (json['data'] as List)
        .map((e) => TodaySummaryData.fromJson(e))
        .toList();
  }
}

class TodaySummaryData {
  String? id;
  String? staffId;
  String? customerId;
  String? customerName;
  String? customerLocation;
  String? date;
  String? title;
  String? total;

  TodaySummaryData({
    this.id,
    this.staffId,
    this.customerId,
    this.customerName,
    this.customerLocation,
    this.date,
    this.title,
    this.total,
  });
  TodaySummaryData.fromJson(Map<String, dynamic> json) {
    id ??= json['id'];
    staffId ??= json['staff_id'];
    customerId ??= json['customer_id'];
    customerName ??= json['customer_name'];
    customerLocation ??= json['customer_location'];
    date ??= json['date'];
    title ??= json['title'];
    total ??= json['total'];
  }
}
