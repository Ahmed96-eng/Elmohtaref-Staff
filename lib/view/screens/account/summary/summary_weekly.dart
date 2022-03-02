import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mohtaref/constant.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref/view/components_widget/account_widgets/account_box_widget.dart';
import 'package:mohtaref/view/components_widget/account_widgets/chartWidget.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:get/get.dart';

class SummaryWeekly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var summaryData = AppCubit.get(context).weeklySummaryModel!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.5,
                  width: width,
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.01, vertical: height * 0.01),
                  // color: mainColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        Jiffy().MMMMEEEEd,
                        style: lineStyleSmallBlack,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            summaryData.weeklyBalance!,
                            style: thirdLineStyle,
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Text(
                            "sar".tr,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      InkWell(
                        // onTap: () {
                        //   goTo(context, TextChart());
                        // },
                        child: ChartWidget(
                          width: width,
                          height: height,
                          summaryData: summaryData,
                        ),

                        //   // child: BarChart(
                        //   //   BarChartData(
                        //   //     borderData: FlBorderData(
                        //   //         border: Border(
                        //   //       top: BorderSide.none,
                        //   //       right: BorderSide.none,
                        //   //       left: BorderSide.none,
                        //   //       bottom: BorderSide.none,
                        //   //     )),
                        //   //     groupsSpace: 10,
                        //   //     barGroups: [
                        //   //       BarChartGroupData(
                        //   //         x: 1,
                        //   //         barRods: [
                        //   //           BarChartRodData(
                        //   //               y: 5,

                        //   //               width: 15,
                        //   //               colors: [Colors.amber]),
                        //   //         ],
                        //   //       ),
                        //   //       BarChartGroupData(
                        //   //         x: 2,
                        //   //         barRods: [
                        //   //           BarChartRodData(
                        //   //               y: 9,
                        //   //               width: 15,
                        //   //               colors: [Colors.amber]),
                        //   //         ],
                        //   //       ),
                        //   //       BarChartGroupData(
                        //   //         x: 3,
                        //   //         barRods: [
                        //   //           BarChartRodData(
                        //   //             y: 4,
                        //   //             width: 15,
                        //   //             colors: [Colors.amber],
                        //   //           ),
                        //   //         ],
                        //   //       ),
                        //   //       BarChartGroupData(
                        //   //         x: 4,
                        //   //         barRods: [
                        //   //           BarChartRodData(
                        //   //             y: 2,
                        //   //             width: 15,
                        //   //             colors: [Colors.amber],
                        //   //           ),
                        //   //         ],
                        //   //       ),
                        //   //       BarChartGroupData(
                        //   //         x: 5,
                        //   //         barRods: [
                        //   //           BarChartRodData(
                        //   //             y: 13,
                        //   //             width: 15,
                        //   //             colors: [Colors.amber],
                        //   //           ),
                        //   //         ],
                        //   //       ),
                        //   //       BarChartGroupData(
                        //   //         x: 6,
                        //   //         barRods: [
                        //   //           BarChartRodData(
                        //   //             y: 17,
                        //   //             width: 15,
                        //   //             colors: [Colors.amber],
                        //   //           ),
                        //   //         ],
                        //   //       ),
                        //   //       BarChartGroupData(
                        //   //         x: 7,
                        //   //         barRods: [
                        //   //           BarChartRodData(
                        //   //             y: 19,
                        //   //             width: 15,
                        //   //             colors: [Colors.amber],
                        //   //           ),
                        //   //         ],
                        //   //       ),
                        //   //     ],
                        //   //   ),
                        //   // ),
                        // ),
                      ),
                      Row(
                        children: [
                          AccountBoxWidget(
                            value: summaryData.weeklyNumberOfTasks,
                            title: "service".tr,
                            width: width,
                            height: height,
                          ),
                          AccountBoxWidget(
                            value: summaryData.weeklyAppFees! + "sar".tr,
                            title: "app_fees".tr,
                            width: width,
                            height: height,
                          ),
                          AccountBoxWidget(
                            value: summaryData.netBalance! + "sar".tr,
                            title: "cash".tr,
                            width: width,
                            height: height,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                  ),
                  child: Text(
                    "service".tr,
                    style: thirdLineStyle,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: thirdColor,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => ListTile(
                              title: Text(summaryData.data![index].date!),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(summaryData.data![index].day!),
                                  Text(
                                    summaryData.data![index].numberOfTasks! +
                                        " " +
                                        "tasks".tr,
                                  ),
                                ],
                              ),
                              trailing: Text(
                                  summaryData.data![index].total! + "sar".tr),
                            ),
                        separatorBuilder: (context, index) => Padding(
                              padding: EdgeInsets.all(width * 0.02),
                              child: Divider(
                                indent: width * 0.1,
                                endIndent: width * 0.1,
                                color: greyColor,
                              ),
                            ),
                        itemCount: summaryData.data!.length),
                  ),
                  // child: ListView(
                  //   children: [ListTileSummaryWidget(width: width)],
                  // ),
                ),
              ],
            );
          });
    });
  }
}
