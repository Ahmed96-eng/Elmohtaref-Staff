import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref/constant.dart';
import 'package:mohtaref/controller/cached_helper/cached_helper.dart';
import 'package:mohtaref/controller/cached_helper/key_constant.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/controller/language_helper/language_controller.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref/model/profile_model.dart';
import 'package:mohtaref/view/components_widget/account_widgets/account_widget.dart';
import 'package:mohtaref/view/components_widget/app_bar_widget.dart';
import 'package:get/get.dart';
import 'package:mohtaref/view/components_widget/navigator.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:mohtaref/view/screens/account/profile/profile_screen.dart';
import 'package:mohtaref/view/screens/account/summary/summaryScreen.dart';
import 'package:mohtaref/view/screens/account/wallet/wallet_screen.dart';
import 'package:mohtaref/view/screens/auth/enter_phone_number.dart';
import 'package:mohtaref/view/screens/auth/welcome_screen.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var homeCubit = AppCubit.get(context);
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(height * 0.1),
                  child: AppBarWidgets(
                    title: "setting".tr,
                    width: width,
                    closeIcon: true,
                  )),
              body: Stack(
                children: [
                  // constantBackgroundScreens(height, width),
                  ListView(
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        height: height * 0.7,
                        child: Column(
                          children: [
                            AccountWidget(
                              title: "profile".tr,
                              iconData: Icons.person_outline,
                              height: height,
                              width: width,
                              onTap: () {
                                goTo(context, ProfileScreen());
                              },
                            ),

                            /// LanguageController
                            Container(
                              width: width,
                              height: height * 0.1,
                              child: GetBuilder<LanguageController>(
                                init: LanguageController(),
                                builder: (controller) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.05,
                                      vertical: height * 0.01),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.language,
                                        // size: height * 0.045,
                                        color: redColor,
                                      ),
                                      SizedBox(
                                        width: width * 0.04,
                                      ),
                                      DropdownButton(
                                        underline: SizedBox(),
                                        icon: SizedBox(),
                                        // icon: Icon(
                                        //   Icons.language,
                                        //   size: height * 0.045,
                                        //   color: mainColor,
                                        // ),
                                        items: [
                                          DropdownMenuItem(
                                            child: Text(
                                              "EN".tr,
                                              style: lineStyleSmallBlack,
                                            ),
                                            value: 'en',
                                          ),
                                          DropdownMenuItem(
                                            child: Text(
                                              "AR".tr,
                                              style: lineStyleSmallBlack,
                                            ),
                                            value: 'ar',
                                          ),
                                        ],
                                        value: controller.localLanguage,
                                        onChanged: (String? value) {
                                          controller.localLanguage = value!;
                                          CachedHelper.setData(
                                              key: languageKey, value: value);
                                          print(CachedHelper.getData(
                                              key: languageKey));
                                          controller.toggleLanguge(value);
                                          Get.updateLocale(Locale(value));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            AccountWidget(
                              title: "change_password".tr,
                              iconData: Icons.change_circle_outlined,
                              height: height,
                              width: width,
                              onTap: () {
                                goTo(context, EnterPhoneNumberScreen());
                              },
                            ),
                            AccountWidget(
                              title: "my_earning".tr,
                              iconData: Icons.attach_money,
                              height: height,
                              width: width,
                              onTap: () {
                                goTo(context, WalletScreen());
                              },
                            ),
                            AccountWidget(
                              title: "summary".tr,
                              iconData: Icons.summarize_outlined,
                              height: height,
                              width: width,
                              onTap: () {
                                goTo(context, SummaryScreen());
                              },
                            ),
                            AccountWidget(
                              title: "delete_account".tr,
                              iconData: Icons.person_off_outlined,
                              height: height,
                              width: width,
                              onTap: () {
                                showAlertDailog(
                                    context: context,
                                    isContent: false,
                                    labelYes: "delete_account".tr,
                                    labelNo: "cancel".tr,
                                    titlle: "are_you_sure_?".tr,
                                    message: "delete_account_message".tr,
                                    onPressNo: () {
                                      back(context);
                                    },
                                    onPressYes: () {
                                      print("object");

                                      homeCubit.deleteAccount().then((value) {
                                        homeCubit.deleteCacheDir();
                                        homeCubit
                                            .onlineStatus(
                                          stauts: "0",
                                          servicesId: homeCubit
                                              .profilModel!.data!.serviceId,
                                          lat: (currentPosition!.latitude)
                                              .toString(),
                                          long: (currentPosition!.longitude)
                                              .toString(),
                                        )
                                            .then((value) {
                                          AppCubit.get(context).onlineExpand =
                                              true;
                                          CachedHelper.removeData(
                                              key: loginTokenId);
                                          AppCubit.get(context)
                                              .profilModel!
                                              .data = ProfileData();
                                          CachedHelper.removeData(
                                              key: mohtarefIdKey);
                                          CachedHelper.removeData(
                                              key: myEarningKey);
                                          myEarningAmount = 0.0;
                                          SchedulerBinding.instance!
                                              .addPostFrameCallback((_) {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        WelcomeScreen(),
                                              ),
                                              (route) => true,
                                            );
                                          });
                                        });
                                      });

                                      back(context);
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03,
                        ),
                        child: Text(
                          "help".tr,
                          style: thirdLineStyle,
                        ),
                      ),
                      Container(
                        height: height * 0.45,
                        child: Column(
                          children: [
                            AccountWidget(
                              title: "terms_condition".tr,
                              iconData: Icons.article_outlined,
                              height: height,
                              width: width,
                            ),
                            AccountWidget(
                              title: "privacy".tr,
                              iconData: Icons.article_outlined,
                              height: height,
                              width: width,
                            ),
                            AccountWidget(
                              title: "about".tr,
                              iconData: Icons.article_outlined,
                              height: height,
                              width: width,
                            ),
                            AccountWidget(
                              title: "contact_us".tr,
                              iconData: Icons.perm_phone_msg_outlined,
                              height: height,
                              width: width,
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
