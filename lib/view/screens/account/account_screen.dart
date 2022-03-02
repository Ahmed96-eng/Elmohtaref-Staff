import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mohtaref/constant.dart';
import 'package:mohtaref/controller/cached_helper/cached_helper.dart';
import 'package:mohtaref/controller/cached_helper/key_constant.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:mohtaref/model/profile_model.dart';
import 'package:mohtaref/view/components_widget/account_widgets/account_circle_header.dart';
import 'package:mohtaref/view/components_widget/account_widgets/account_widget.dart';
import 'package:mohtaref/view/components_widget/navigator.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:mohtaref/view/screens/account/profile/profile_screen.dart';
import 'package:mohtaref/view/screens/account/ratings.dart';
import 'package:mohtaref/view/screens/account/settings.dart';
import 'package:mohtaref/view/screens/account/summary/summaryScreen.dart';
import 'package:mohtaref/view/screens/account/wallet/wallet_screen.dart';
import 'package:mohtaref/view/screens/auth/welcome_screen.dart';

// import 'package:mohtaref/view/components_widget/app_bar_widget.dart';
class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        // if (state is GetTodaySummaryLoadingState) {
        //   showLoadingDialog(context);
        // }
        // if (state is GetTodaySummarySuccessState) {
        //   back(context);
        // }
        // if (state is GetWeeklySummarySuccessState) {
        //   back(context);
        //   goTo(context, SummaryScreen());
        // }
        // if (state is GetWeeklySummaryErrorState) {
        //   back(context);
        // }
        // if (state is GetTodayWalletLoadingState) {
        //   showLoadingDialog(context);
        // }

        // if (state is GetWeeklyWalletSuccessState) {
        //   back(context);
        //   goTo(context, WalletScreen());
        // }
        // if (state is GetWeeklyWalletErrorState) {
        //   back(context);
        // }
      }, builder: (context, state) {
        var homeCubit = AppCubit.get(context);
        var profileData = AppCubit.get(context).profilModel!.data;

        return Scaffold(
          body: Stack(
            children: [
              constantBackgroundScreens(height, width),
              Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Container(
                        height: height * 0.3,
                        width: width, color: Colors.black26,
                        // color: darkColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                showLoadingDialog(context);
                                await homeCubit
                                    .getTodayWallet()
                                    .then((value) async {
                                  await homeCubit.getWeeklyWallet();
                                  back(context);
                                  goTo(context, WalletScreen());
                                }).then((value) {
                                  print(".......Wallet Load Success.......");
                                });
                              },
                              child: AccountCircleHeader(
                                width: width * 0.18,
                                height: height * 0.18,
                                isIcon: true,
                                iconData: Icons.account_balance_wallet,
                                // image: "asset/images/wallet.png",
                                title: "wallet".tr,
                              ),
                            ),
                            AccountCircleHeader(
                              width: width * 0.27,
                              height: height * 0.3,
                              image: profileData!.profile!,
                              title: profileData.username!,
                              rating: double.parse(profileData.rate!),
                              isStack: true,
                            ),
                            InkWell(
                              onTap: () async {
                                showLoadingDialog(context);
                                await homeCubit
                                    .getTodaySummary()
                                    .then((value) async {
                                  await homeCubit.getWeeklySummary();
                                  back(context);
                                  goTo(context, SummaryScreen());
                                }).then((value) {
                                  // if (state is GetTodaySummarySuccessState ||
                                  //     state is GetWeeklySummarySuccessState) {
                                  //   back(context);
                                  //   // Future.delayed(Duration(milliseconds: 200));
                                  //   goTo(context, SummaryScreen());
                                  // }
                                  print(",,,,,,,,Summary Load Success,,,,,,,");
                                });
                                // back(context);
                              },
                              child: AccountCircleHeader(
                                width: width * 0.18,
                                height: height * 0.18,
                                isIcon: true,
                                iconData: Icons.analytics,
                                // image: "asset/images/summary.png",
                                title: "summary".tr,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: height * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'help'.tr,
                              style: firstLineStyle,
                            ),
                            InkWell(
                              onTap: () {
                                back(context);
                              },
                              child: Icon(
                                Icons.close,
                                color: mainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: height * 0.13,
                    width: width,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.01, vertical: height * 0.01),
                    // color: mainColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Jiffy(DateTime.now()).MMMMEEEEd,
                          style: lineStyleSmallBlack,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "my_earning".tr + " : ",
                              style: styleBlack,
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Text(
                              profileData.balance!,
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
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      children: [
                        // AccountWidget(
                        //   title: "home".tr,
                        //   iconData: Icons.home,
                        //   width: width,
                        //   height: height,
                        //   onTap: () {
                        //     goTo(context, AnimateCamera());
                        //   },
                        // ),
                        AccountWidget(
                          title: "rating".tr,
                          iconData: Icons.star,
                          width: width,
                          height: height,
                          dividerColor: mainColor,
                          onTap: () {
                            goTo(context, Ratings());
                          },
                        ),
                        AccountWidget(
                          title: "profile".tr,
                          iconData: Icons.person,
                          width: width,
                          height: height,
                          dividerColor: mainColor,
                          onTap: () {
                            goTo(context, ProfileScreen());
                          },
                        ),

                        ///notification  soon

                        SwitchListTile(
                          title: Text(
                            "notification".tr,
                            style: lineStyleSmallBlack,
                          ),
                          secondary: Icon(
                            Icons.notifications,
                            color: redColor,
                          ),
                          activeColor: redColor,
                          value: AppCubit.get(context).notificationToggle,
                          onChanged: (bool value) {
                            AppCubit.get(context).changenotificationToggle(
                                context, value, profileData.serviceId!);
                            print(value);
                          },
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Divider(
                            color: mainColor,
                          ),
                        ),

                        /// setting
                        AccountWidget(
                          title: "setting".tr,
                          iconData: Icons.settings,
                          width: width,
                          height: height,
                          dividerColor: mainColor,
                          onTap: () {
                            goTo(context, Settings());
                          },
                        ),

                        /// log out
                        AccountWidget(
                          title: "logout".tr,
                          iconData: Icons.exit_to_app,
                          width: width,
                          height: height,
                          onTap: () {
                            showAlertDailog(
                              context: context,
                              isContent: false,
                              titlle: "exit_application".tr,
                              message: "are_you_sure_?".tr,
                              labelNo: "no".tr,
                              labelYes: "yes".tr,
                              onPressNo: () => back(context),
                              onPressYes: () {
                                AppCubit.get(context)
                                    .onlineStatus(
                                  stauts: "0",
                                  servicesId: profileData.serviceId,
                                  lat: (currentPosition!.latitude).toString(),
                                  long: (currentPosition!.longitude).toString(),
                                )
                                    .then((value) {
                                  AppCubit.get(context).onlineExpand = true;
                                  goToAndFinish(context, WelcomeScreen());
                                  print("LOG OUT Success and goToAndFinish ");
                                }).then((value) {
                                  print("LOG OUT Success before delay ");
                                  Future.delayed(Duration(milliseconds: 100))
                                      .then((value) {
                                    CachedHelper.removeData(key: loginTokenId);
                                    AppCubit.get(context).profilModel!.data =
                                        ProfileData();
                                    CachedHelper.removeData(key: mohtarefIdKey);
                                    CachedHelper.removeData(key: myEarningKey);
                                    myEarningAmount = 0.0;
                                    print("LOG OUT Success after delay");
                                  });
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
    });
  }
}
