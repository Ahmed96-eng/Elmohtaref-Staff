import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref/constant.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref/model/tasks_model.dart';
import 'package:get/get.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';
import 'package:mohtaref/view/components_widget/list_tile_wallet_widget.dart';
import 'package:mohtaref/view/components_widget/navigator.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:mohtaref/view/screens/home_polyline_map/rating_user.dart';

class CollectCashScreen extends StatelessWidget {
  final CustomerData? customerData;

  CollectCashScreen({this.customerData});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var homeCubit = AppCubit.get(context);
            var taskDetailsData = AppCubit.get(context).taskDetailsModel!.data!;
            return WillPopScope(
              onWillPop: () async {
                showFlutterToast(
                    message: "no_back".tr, backgroundColor: redColor);
                return false;
              },
              child: Scaffold(
                appBar: AppBar(
                  title:
                      Text("service_no".tr + " : " + "${taskDetailsData.id}"),
                  centerTitle: true,
                  backgroundColor: mainColor,
                  leadingWidth: 0.0,
                ),
                // appBar: PreferredSize(
                //     preferredSize: Size.fromHeight(height * 0.1),
                //     child: AppBarWidgets(
                //       title: "service".tr + " " + "#0001",
                //       width: width,
                //     )),
                body: Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  taskDetailsData.total!,
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
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              "collect_cash".tr + " " + customerData!.username!,
                              style: thirdLineStyle,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.1,
                                  vertical: height * 0.01),
                              child: Divider(),
                            ),
                            CommonButton(
                                width: width * 0.85,
                                height: height * 0.08,
                                containerColor: mainColor,
                                textColor: redColor,
                                text: homeCubit.moreDetails
                                    ? "less_details".tr
                                    : "more_details".tr,
                                onTap: () {
                                  homeCubit.changeMoreDetails(context);
                                }),
                            if (homeCubit.moreDetails)
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ListTileWalletWidget(
                                        width: width,
                                        height: height * 0.9,
                                        title: "task_fares".tr,
                                        amount: taskDetailsData.taskFees,
                                      ),
                                      ListTileWalletWidget(
                                        width: width,
                                        height: height * 0.9,
                                        title: "fees".tr,
                                        amount: taskDetailsData.serviceAmount,
                                      ),
                                      ListTileWalletWidget(
                                        width: width,
                                        height: height * 0.9,
                                        title: "+tax".tr,
                                        amount: taskDetailsData.vat,
                                      ),
                                      ListTileWalletWidget(
                                        width: width,
                                        height: height * 0.9,
                                        title: "items".tr,
                                        amount: taskDetailsData.items,
                                      ),
                                      if (taskDetailsData.couponCode != "")
                                        ListTileWalletWidget(
                                          width: width,
                                          height: height * 0.9,
                                          title: "discount".tr,
                                          amount: taskDetailsData.coupon,
                                        ),
                                      ListTileWalletWidget(
                                        width: width,
                                        height: height * 0.9,
                                        title: "top_up_added".tr,
                                        amount: taskDetailsData.distance,
                                      ),
                                      Divider(
                                        indent: width * 0.05,
                                        endIndent: width * 0.05,
                                      ),
                                      // SizedBox(
                                      //   height: height * 0.02,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.01),
                        child: CommonButton(
                            width: width * 0.85,
                            height: height * 0.08,
                            containerColor: redColor,
                            textColor: mainColor,
                            text: "done".tr,
                            onTap: () {
                              // homeCubit.changeMoreDetails(context);

                              goTo(
                                  context,
                                  RatingUser(
                                    customerData: customerData!,
                                  ));
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}
