import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mohtaref/constant.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref/model/today_summary_model.dart';
import 'package:mohtaref/view/components_widget/account_widgets/account_box_widget.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:get/get.dart';

class SummaryToday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var todaySummaryData = AppCubit.get(context).todaySummaryModel!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.28,
                  width: width,
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.01, vertical: height * 0.01),
                  // color: mainColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Jiffy().MMMMEEEEd,
                        style: lineStyleSmallBlack,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            todaySummaryData.todayBalance!,
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
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02),
                        child: Row(
                          children: [
                            AccountBoxWidget(
                              value: todaySummaryData.todayNumberOfTasks,
                              title: "service".tr,
                              width: width,
                              height: height,
                            ),
                            AccountBoxWidget(
                              value: todaySummaryData.todayAppFees! + "sar".tr,
                              title: "app_fees".tr,
                              width: width,
                              height: height,
                            ),
                            AccountBoxWidget(
                              value: todaySummaryData.netBalance! + "sar".tr,
                              title: "cash".tr,
                              width: width,
                              height: height,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03,
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
                        itemBuilder: (context, index) => ListTileSummaryWidget(
                              width: width,
                              todaySummaryData: todaySummaryData.data![index],
                            ),
                        separatorBuilder: (context, index) => Padding(
                              padding: EdgeInsets.all(width * 0.01),
                              child: Divider(
                                indent: width * 0.1,
                                endIndent: width * 0.1,
                              ),
                            ),
                        itemCount: todaySummaryData.data!.length),
                  ),
                ),
              ],
            );
          });
    });
  }
}

class ListTileSummaryWidget extends StatelessWidget {
  ListTileSummaryWidget({
    required this.width,
    required this.todaySummaryData,
  });

  final double width;
  final TodaySummaryData todaySummaryData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(Jiffy().format("${todaySummaryData.date}")),
      title: Text(
        todaySummaryData.title!,
        style: styleBlack,
      ),
      subtitle: Text(todaySummaryData.customerLocation!),
      trailing: Container(
        width: width * 0.2,
        // height: 50,
        child: Wrap(
          children: [
            Text(
              todaySummaryData.total!,
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
      ),
    );
  }
}
