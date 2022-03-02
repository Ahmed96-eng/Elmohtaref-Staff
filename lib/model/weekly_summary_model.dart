class WeeklySummaryModel {
  String? weeklyNumberOfTasks;
  String? weeklyBalance;
  String? weeklyAppFees;
  String? netBalance;
  String? maxChartY;
  List<WeeklySummaryData>? data;
  WeeklySummaryModel.fromJson(Map<String, dynamic> json) {
    weeklyNumberOfTasks ??= json['no_tasks'];
    weeklyBalance ??= json['weekly_balance'];
    weeklyAppFees ??= json['weekly_app_fees'];
    netBalance ??= json['net_balance'];
    maxChartY ??= json['max_y'];
    data = (json['data'] as List)
        .map((e) => WeeklySummaryData.fromJson(e))
        .toList();
  }
}

class WeeklySummaryData {
  String? numberOfTasks;
  String? customerId;
  String? date;
  String? total;
  String? day;
  String? dayNumber;
  WeeklySummaryData(
      {this.numberOfTasks,
      this.customerId,
      this.date,
      this.total,
      this.day,
      this.dayNumber});
  WeeklySummaryData.fromJson(Map<String, dynamic> json) {
    numberOfTasks ??= json['no_tasks'];
    customerId ??= json['customer_id'];
    date ??= json['date'];
    total ??= json['total'];
    day ??= json['day'];
    dayNumber ??= json['day_number'];
  }
}
