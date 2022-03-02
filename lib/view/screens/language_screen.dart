import 'package:flutter/material.dart';
import 'package:mohtaref/controller/cached_helper/cached_helper.dart';
import 'package:mohtaref/controller/cached_helper/key_constant.dart';
import 'package:mohtaref/controller/language_helper/language_controller.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref/view/components_widget/navigator.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:get/get.dart';
import 'package:mohtaref/view/screens/auth/welcome_screen.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      // final width = sizeConfig.screenWidth!;
      return GetBuilder<LanguageController>(
        init: LanguageController(),
        builder: (controller) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Container(),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "choose_language".tr,
                    style: secondLineStyle,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      child: Text(
                        "AR".tr,
                        style: thirdLineStyle,
                      ),
                    ),
                    onTap: () {
                      controller.localLanguage = 'ar';
                      CachedHelper.setData(key: languageKey, value: 'ar');
                      print(CachedHelper.getData(key: languageKey));
                      controller.toggleLanguge('ar');
                      Get.updateLocale(Locale('ar'));
                      print("Language is --->${controller.localLanguage}");
                      CachedHelper.setData(
                        key: langScreenKey,
                        value: true,
                      ).then((value) {
                        if (value) {
                          print("LanguageScreenKey is --->$value");
                          goTo(context, WelcomeScreen());
                        }
                      });
                    },
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      child: Text(
                        "EN".tr,
                        style: thirdLineStyle,
                      ),
                    ),
                    onTap: () {
                      controller.localLanguage = 'en';
                      CachedHelper.setData(key: languageKey, value: 'en');
                      print(CachedHelper.getData(key: languageKey));
                      controller.toggleLanguge('en');
                      Get.updateLocale(Locale('en'));
                      print("Language is --->${controller.localLanguage}");
                      CachedHelper.setData(
                        key: langScreenKey,
                        value: true,
                      ).then((value) {
                        if (value) {
                          print("LanguageScreenKey is --->$value");

                          goTo(context, WelcomeScreen());
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
