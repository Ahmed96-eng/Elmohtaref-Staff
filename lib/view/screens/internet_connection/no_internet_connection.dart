import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';
import 'package:mohtaref/view/components_widget/navigator.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:mohtaref/view/screens/auth/sign_in.dart';
import 'package:mohtaref/view/screens/home/home_screen.dart';
import 'package:mohtaref/view/screens/internet_connection/restart_app.dart';
import '../../../constant.dart';

class NoInternetConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "No_internet_connection".tr,
                style: secondLineStyle,
              ),
              CommonButton(
                  text: 'check_connection'.tr,
                  containerColor: buttonColor,
                  width: MediaQuery.of(context).size.width / 2,
                  textColor: Colors.white,
                  onTap: () {
                    // final result = await InternetAddress.lookup('google.com');

                    // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    // print('connected');
                    showAlertDailog(
                        context: context,
                        titlle: "check_connection".tr,
                        message: "check_message".tr,
                        labelNo: "exit_application".tr,
                        labelYes: "restart".tr,
                        onPressNo: () => exit(0),
                        onPressYes: () async {
                          final result =
                              await InternetAddress.lookup('google.com');

                          if (result.isNotEmpty &&
                              result[0].rawAddress.isNotEmpty) {
                            RestartWidget.restartApp(context).then((value) {
                              if (userToken != null) {
                                AppCubit.get(context).getProfile().then(
                                    (value) => AppCubit.get(context)
                                            .getStatics()
                                            .then((value) =>
                                                AppCubit.get(context)
                                                    .onlineStatus(
                                                  stauts: "0",
                                                  servicesId:
                                                      AppCubit.get(context)
                                                          .profilModel!
                                                          .data!
                                                          .serviceId,
                                                  lat: (currentPosition!
                                                          .latitude)
                                                      .toString(),
                                                  long: (currentPosition!
                                                          .longitude)
                                                      .toString(),
                                                ))
                                            .then((value) {
                                          AppCubit.get(context).onlineExpand =
                                              true;
                                          goToAndFinish(context, HomeScreen());
                                        }));
                              } else
                                goToAndFinish(context, SignIn());
                            });
                          }
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
