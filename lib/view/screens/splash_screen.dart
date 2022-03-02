import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/view/components_widget/navigator.dart';
import 'package:mohtaref/view/screens/auth/welcome_screen.dart';
import 'package:mohtaref/view/screens/language_screen.dart';
import '../../constant.dart';
import 'home/home_screen.dart';
import 'internet_connection/no_internet_connection.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() async {
    Widget? screenWidget;
    print("llllllangScreeeeeen7777777777777--->$langScreen");

    if (langScreen == true) {
      if (userToken != null)
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            screenWidget = HomeScreen();
            // screenWidget = BarChartSample1();
            print('connected');
          }
        } on SocketException catch (_) {
          // showFlutterToast(message: "check_connection".tr);
          screenWidget = NoInternetConnection();
          print('not connected');
        }
      // screenWidget = BotomNavBarLayout();
      else
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            screenWidget = WelcomeScreen();
            print('connected');
          }
        } on SocketException catch (_) {
          screenWidget = NoInternetConnection();
          print('not connected');
        }
      (userToken != null)
          ? AppCubit.get(context)
              .getProfile()
              .then((value) => AppCubit.get(context).getStatics().then((value) {
                    AppCubit.get(context).onlineStatus(
                      stauts: "0",
                      servicesId:
                          AppCubit.get(context).profilModel!.data!.serviceId,
                      lat: (currentPosition!.latitude).toString(),
                      long: (currentPosition!.longitude).toString(),
                    );
                    AppCubit.get(context).onlineExpand = true;
                    // AppCubit.get(context).getTodaySummary();
                  }).then((value) => goToAndFinish(context, screenWidget!)))
          : goToAndFinish(context, screenWidget!);
    } else {
      screenWidget = LanguageScreen();
      goTo(context, screenWidget);
    }
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }
}

initScreen(BuildContext context) {
  return Scaffold(
    body: Container(
      // width: double.infinity,
      // height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("asset/images/splash_logo.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: MediaQuery.of(context).size.width / 3,
          child: Image.asset(
            "asset/images/main_logo.png",
            fit: BoxFit.cover,
            // width: 500,
            // height: 800,
          ),
        ),
      ),
    ),
  );
}
