import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mohtaref/model/Weekly_wallet_model.dart';
import 'package:mohtaref/model/weekly_summary_model.dart';

import '../../../constant.dart';

class ChartWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final WeeklySummaryModel? summaryData;
  final WeeklyWalletModel? walletData;
  final bool isWallet;

  const ChartWidget(
      {Key? key,
      this.width,
      this.height,
      this.summaryData,
      this.walletData,
      this.isWallet = false})
      : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  int touchedIndex = -1;
  List<WeeklySummaryData>? data;
  List<WeeklyWalletData>? weeklyWalletData;
  List<WeeklySummaryData> newList = [
    WeeklySummaryData(
        customerId: "",
        date: "",
        day: "",
        dayNumber: "",
        numberOfTasks: "",
        total: "0"),
    WeeklySummaryData(
        customerId: "",
        date: "",
        day: "",
        dayNumber: "",
        numberOfTasks: "",
        total: "0"),
    WeeklySummaryData(
        customerId: "",
        date: "",
        day: "",
        dayNumber: "",
        numberOfTasks: "",
        total: "0"),
    WeeklySummaryData(
        customerId: "",
        date: "",
        day: "",
        dayNumber: "",
        numberOfTasks: "",
        total: "0"),
    WeeklySummaryData(
        customerId: "",
        date: "",
        day: "",
        dayNumber: "",
        numberOfTasks: "",
        total: "0"),
    WeeklySummaryData(
        customerId: "",
        date: "",
        day: "",
        dayNumber: "",
        numberOfTasks: "",
        total: "0"),
    WeeklySummaryData(
        customerId: "",
        date: "",
        day: "",
        dayNumber: "",
        numberOfTasks: "",
        total: "0"),
  ];
  List<WeeklyWalletData> newWalletList = [
    WeeklyWalletData(
        customerId: "",
        date: "",
        day: "",
        dayNumber: "",
        numberOfTasks: "",
        total: "0"),
    WeeklyWalletData(
        customerId: "",
        date: "",
        day: "",
        dayNumber: "",
        numberOfTasks: "",
        total: "0"),
    WeeklyWalletData(
        customerId: "",
        date: "",
        day: "",
        dayNumber: "",
        numberOfTasks: "",
        total: "0"),
    WeeklyWalletData(
        customerId: "",
        date: "",
        day: "",
        dayNumber: "",
        numberOfTasks: "",
        total: "0"),
    WeeklyWalletData(
        customerId: "",
        date: "",
        day: "",
        dayNumber: "",
        numberOfTasks: "",
        total: "0"),
    WeeklyWalletData(
        customerId: "",
        date: "",
        day: "",
        dayNumber: "",
        numberOfTasks: "",
        total: "0"),
    WeeklyWalletData(
        customerId: "",
        date: "",
        day: "",
        dayNumber: "",
        numberOfTasks: "",
        total: "0"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height! * 0.28,
      color: thirdColor,
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: mainColor,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.width! * 0.02,
                    vertical: widget.height! * 0.01),
                child: BarChart(
                  BarChartData(
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.grey,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            String weekDay;
                            switch (group.x.toInt()) {
                              case 0:
                                weekDay = 'Saturday';
                                break;
                              case 1:
                                weekDay = 'Sunday';
                                break;
                              case 2:
                                weekDay = 'Monday';
                                break;
                              case 3:
                                weekDay = 'Tuesday';
                                break;
                              case 4:
                                weekDay = 'Wednesday';
                                break;
                              case 5:
                                weekDay = 'Thursday';
                                break;
                              case 6:
                                weekDay = 'Friday';
                                break;
                              default:
                                throw Error();
                            }
                            return BarTooltipItem(
                              weekDay + '\n',
                              TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: widget.width! * 0.05,
                              ),
                              children: <TextSpan>[
                                /// change rod by data from api
                                TextSpan(
                                  text: (rod.y).toString(),
                                  style: TextStyle(
                                    // color: Colors.yellow,
                                    fontSize: widget.width! * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            );
                          }),
                      touchCallback: (FlTouchEvent event, barTouchResponse) {
                        // setState(() {
                        if (!event.isInterestedForInteractions ||
                            barTouchResponse == null ||
                            barTouchResponse.spot == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex =
                            barTouchResponse.spot!.touchedBarGroupIndex;
                        // });
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: SideTitles(showTitles: false),
                      topTitles: SideTitles(showTitles: false),
                      leftTitles: SideTitles(showTitles: false),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 16,
                        getTitles: (double value) {
                          // int dateLength = newWalletList[value.toInt()]
                          //     .date
                          //     .toString()
                          //     .split("-")
                          //     .length;
                          switch (value.toInt()) {
                            case 0:
                              return "S";
                            case 1:
                              return 'S';
                            case 2:
                              return 'M';
                            case 3:
                              return 'T';
                            case 4:
                              return 'W';
                            case 5:
                              return 'T';
                            case 6:
                              return 'F';
                            default:
                              return '';
                          }
                        },
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: widget.isWallet
                        ? showingGroupsForWallet()
                        : showingGroups(),
                    gridData: FlGridData(show: false),
                  ),
                  // swapAnimationDuration: animDuration,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    double maxY = 500,
    bool isTouched = false,
    Color barColor = Colors.red,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.blue.shade200] : [redColor!],
          width: width,
          borderSide: isTouched
              ? BorderSide(color: mainColor!, width: 1)
              : BorderSide(color: redColor!, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: maxY,
            colors: [Colors.grey.shade200],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        data = widget.summaryData!.data;

        for (int y = 0; y < data!.length; y++) {
          newList.insert(int.parse(data![y].dayNumber!), (data![y]));
          newList.removeAt(int.parse(data![y].dayNumber!) + 1);
        }

        switch (i) {
          case 0:
            return makeGroupData(0, double.parse(newList[i].total!),
                maxY: double.parse(widget.summaryData!.maxChartY!) + 1.0,
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, double.parse(newList[i].total!),
                maxY: double.parse(widget.summaryData!.maxChartY!) + 1.0,
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, double.parse(newList[i].total!),
                maxY: double.parse(widget.summaryData!.maxChartY!) + 1.0,
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, double.parse(newList[i].total!),
                maxY: double.parse(widget.summaryData!.maxChartY!) + 1.0,
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, double.parse(newList[i].total!),
                maxY: double.parse(widget.summaryData!.maxChartY!) + 1.0,
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, double.parse(newList[i].total!),
                maxY: double.parse(widget.summaryData!.maxChartY!) + 1.0,
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, double.parse(newList[i].total!),
                maxY: double.parse(widget.summaryData!.maxChartY!) + 1.0,
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  List<BarChartGroupData> showingGroupsForWallet() => List.generate(7, (i) {
        weeklyWalletData = widget.walletData!.data;
        for (int x = 0; x < weeklyWalletData!.length; x++) {
          newWalletList.insert(int.parse(weeklyWalletData![x].dayNumber!),
              (weeklyWalletData![x]));
          newWalletList
              .removeAt(int.parse(weeklyWalletData![x].dayNumber!) + 1);
        }
        switch (i) {
          case 0:
            return makeGroupData(0, double.parse(newWalletList[i].total!),
                maxY: double.parse(widget.walletData!.maxChartY!) + 1,
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, double.parse(newWalletList[i].total!),
                maxY: double.parse(widget.walletData!.maxChartY!) + 1,
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, double.parse(newWalletList[i].total!),
                maxY: double.parse(widget.walletData!.maxChartY!) + 1,
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, double.parse(newWalletList[i].total!),
                maxY: double.parse(widget.walletData!.maxChartY!) + 1,
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, double.parse(newWalletList[i].total!),
                maxY: double.parse(widget.walletData!.maxChartY!) + 1,
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, double.parse(newWalletList[i].total!),
                maxY: double.parse(widget.walletData!.maxChartY!) + 1,
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, double.parse(newWalletList[i].total!),
                maxY: double.parse(widget.walletData!.maxChartY!) + 1,
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });
}
