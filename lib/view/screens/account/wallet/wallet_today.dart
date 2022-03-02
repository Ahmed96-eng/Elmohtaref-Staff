import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mohtaref/constant.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref/view/components_widget/account_widgets/account_box_widget.dart';
import 'package:mohtaref/view/components_widget/list_tile_wallet_widget.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:get/get.dart';

class WalletToday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var wallwtData = AppCubit.get(context).todayWalletModel!;
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
                            wallwtData.todayBalance!,
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
                              value: wallwtData.todayNumberOfTasks,
                              title: "service".tr,
                              width: width,
                              height: height,
                            ),
                            AccountBoxWidget(
                              value: wallwtData.todayAppFees! + "sar".tr,
                              title: "app_fees".tr,
                              width: width,
                              height: height,
                            ),
                            AccountBoxWidget(
                              value: wallwtData.netBalance! + "sar".tr,
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
                Expanded(
                  child: Container(
                    color: thirdColor,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      children: [
                        ListTileWalletWidget(
                          width: width,
                          height: height,
                          title: "task_fares".tr,
                          amount: (wallwtData.staffFees!),
                        ),
                        ListTileWalletWidget(
                          width: width,
                          height: height,
                          title: "fees".tr,
                          amount: (wallwtData.serviceAmount!),
                        ),
                        ListTileWalletWidget(
                          width: width,
                          height: height,
                          title: "+tax".tr,
                          amount: (wallwtData.tax!),
                        ),
                        ListTileWalletWidget(
                          width: width,
                          height: height,
                          title: "items".tr,
                          amount: (wallwtData.items!),
                        ),
                        ListTileWalletWidget(
                          width: width,
                          height: height,
                          title: "discount".tr,
                          amount: (wallwtData.discount!),
                        ),
                        ListTileWalletWidget(
                          width: width,
                          height: height,
                          title: "top_up_added".tr,
                          amount: (wallwtData.distance!),
                        ),
                        Divider(
                          indent: width * 0.05,
                          endIndent: width * 0.05,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        ListTileWalletWidget(
                          width: width,
                          height: height,
                          title: "total_earning".tr,
                          amount: (wallwtData.todayBalance!),
                          isTotal: true,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
    });
  }
}
