import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref/model/tasks_model.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';
import 'package:get/get.dart';
import 'package:mohtaref/view/components_widget/navigator.dart';
import 'package:mohtaref/view/screens/home/home_screen.dart';
import 'package:mohtaref/view/screens/home_polyline_map/collect_cash_screen.dart';
import '../../../constant.dart';

class ConfirmPayScreen extends StatelessWidget {
  final CustomerData? customerData;
  final String? taskId;
  ConfirmPayScreen({this.customerData, this.taskId});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizeConfig) {
        final height = sizeConfig.screenHeight!;
        final width = sizeConfig.screenWidth!;
        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var homeCubit = AppCubit.get(context);
            return WillPopScope(
              onWillPop: () async {
                showFlutterToast(
                    message: "no_back".tr, backgroundColor: redColor);
                return false;
              },
              child: Scaffold(
                backgroundColor: Colors.grey[300],
                body: Stack(
                  children: [
                    constantBackgroundScreens(height, width),
                    Container(
                      width: width,
                      height: height,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: MediaQuery.of(context).size.width / 4,
                              child: Image.asset(
                                "asset/images/main_logo.png",
                                fit: BoxFit.cover,
                                // width: 500,
                                // height: 800,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.1,
                            ),
                            CommonButton(
                              text: "confirm_pay_btn".tr,
                              fontSize: width * 0.05,
                              width: width * 0.85,
                              containerColor: buttonColor,
                              textColor: buttonTextColor,
                              onTap: () {
                                goTo(
                                    context,
                                    CollectCashScreen(
                                      customerData: customerData,
                                    ));
                                customerDueAmount = 0.0;
                              },
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            CommonButton(
                              text: "no_pay_btn".tr,
                              fontSize: width * 0.05,
                              width: width * 0.85,
                              containerColor: mainColor,
                              textColor: buttonColor,
                              borderColor: buttonColor,
                              onTap: () {
                                homeCubit.tasksModel!.tasks = null;
                                homeCubit.resetPolyline();
                                homeCubit.googleMapController!.dispose();
                                homeCubit.taskCustomerData = [];
                                homeCubit.taskDetails = [];
                                // cubit.currentPage = 1;
                                homeCubit
                                    .customerRefusePayment(
                                        taskId: taskId!,
                                        due: customerDueAmount.toString())
                                    .then((value) {
                                  SchedulerBinding.instance!
                                      .addPostFrameCallback((_) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomeScreen(),
                                      ),
                                      (route) => true,
                                    );
                                  });
                                  customerDueAmount = 0.0;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
