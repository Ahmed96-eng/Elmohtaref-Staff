import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mohtaref/constant.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:mohtaref/view/components_widget/cached_network_Image_widget.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';
import 'package:mohtaref/view/components_widget/home_widgets/box_widget.dart';
import 'package:mohtaref/view/components_widget/home_widgets/find_task_widget.dart';
import 'package:mohtaref/view/components_widget/home_widgets/main_data_widget.dart';
import 'package:mohtaref/view/components_widget/home_widgets/offline_data_widget.dart';
import 'package:mohtaref/view/components_widget/navigator.dart';
import 'package:mohtaref/view/components_widget/no_data_widget.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:mohtaref/view/screens/account/account_screen.dart';
import '../../notification_handler_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // RefreshController? _refreshController;

  @override
  void initState() {
    // _refreshController = RefreshController(initialRefresh: true);
    // AppCubit.get(context).getTodaySummary();
    super.initState();
  }

  @override
  void dispose() {
    // _refreshController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NotificationHandlerWidget.onMessagesNotification(context);
    NotificationHandlerWidget.onAppOpenedNotification(context);
    // NotificationHandlerWidget.onBackGroundNotification(context);
    NotificationHandlerWidget.onMessageConfirmPayNotification(context);
    NotificationHandlerWidget.onAppOpenedConfirmPayNotification(context);
    // NotificationHandlerWidget.onBackGroundConfirmPayNotification(context);
    NotificationHandlerWidget.onMessagesNotificationCancelTask(context);
    NotificationHandlerWidget.onAppOpenedNotificationCancelTask(context);
    // NotificationHandlerWidget.onBackGroundNotificationCancelTask(context);

    return ResponsiveBuilder(
      builder: (context, sizeConfig) {
        final height = sizeConfig.screenHeight!;
        final width = sizeConfig.screenWidth!;
        return BlocConsumer<AppCubit, AppState>(listener: (context, state) {
          // if (state is GetTodaySummaryLoadingState) showLoadingDialog(context);
        }, builder: (context, state) {
          var homeCubit = AppCubit.get(context);

          return WillPopScope(
            onWillPop: () {
              if ((homeCubit.onlineExpand == false &&
                      homeCubit.goExpand == false) ||
                  homeCubit.goExpand == true) {
                homeCubit
                    .onlineStatus(
                  stauts: "0",
                  servicesId: homeCubit.profilModel!.data!.serviceId,
                  lat: (currentPosition!.latitude).toString(),
                  long: (currentPosition!.longitude).toString(),
                )
                    .then(
                  (value) {
                    homeCubit.goExpand = false;
                    homeCubit.onlineExpand = true;
                    // homeCubit.changeGoExpand(context);
                    // homeCubit.changeOnlineExpand(context);
                    // homeCubit.taskCustomerData!.clear();
                    // homeCubit.taskDetails!.clear();
                  },
                );
                return showFlutterToast(
                    message: "offline".tr, backgroundColor: redColor);
              } else {
                return showAlertDailog(
                  context: context,
                  isContent: false,
                  titlle: "exit_application".tr,
                  message: "are_you_sure_?".tr,
                  labelNo: "no".tr,
                  labelYes: "yes".tr,
                  onPressNo: () => back(context),
                  onPressYes: () {
                    homeCubit
                        .onlineStatus(
                      stauts: "0",
                      servicesId: homeCubit.profilModel!.data!.serviceId,
                      lat: (currentPosition!.latitude).toString(),
                      long: (currentPosition!.longitude).toString(),
                    )
                        .then((value) {
                      AppCubit.get(context).onlineExpand = true;
                      exit(0);
                    });
                  },
                );
              }
            },
            child: Scaffold(
              key: _scaffoldKey,
              body: Stack(
                // alignment: AlignmentDirectional.topCenter,
                children: [
                  /// GoogleMap
                  GoogleMap(
                    padding: EdgeInsets.only(
                        bottom: homeCubit.onlineExpand
                            ? height * 0.15
                            : homeCubit.goExpand
                                ? height * 0.6
                                : height * 0.3),
                    mapType: MapType.normal,
                    // myLocationButtonEnabled: true,
                    // myLocationEnabled: true,
                    // scrollGesturesEnabled: false,
                    // mapToolbarEnabled: false,
                    // zoomControlsEnabled: true,
                    initialCameraPosition: homeCubit.kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      // homeCubit.getCurrentPosition();
                    },
                  ),

                  // profile icon
                  Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.05),
                        // child: Badge(
                        //     value: "0",
                        //     color: redColor,
                        child: InkWell(
                          onTap: () {
                            print('profile');
                            goTo(context, AccountScreen());
                          },
                          child: CircleAvatar(
                              radius: width * 0.08,
                              backgroundColor: redColor,
                              child: ClipOval(
                                child: CachedNetworkImageWidget(
                                  // height: height * 0.08,
                                  // width: width * 0.15,
                                  // boxFit: BoxFit.contain,
                                  image: homeCubit.profilModel!.data!.profile,
                                ),
                                // ),
                              )),
                        ),
                      )),

                  //total price top
                  Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.05,
                          left: width * 0.02,
                          right: width * 0.02,
                        ),
                        child: BoxWidget(
                          width: width,
                          height: height,
                          balance: homeCubit.profilModel!.data!.balance!,
                        ),
                      )),
                  //if onlineExpand = false
                  if (homeCubit.onlineExpand == false &&
                      homeCubit.goExpand == false)
                    MainDataWidget(
                      width: width,
                      height: height,
                      staticsData: homeCubit.staticsModel!.data!,
                      goOnTap: () {
                        homeCubit.getCurrentPosition();
                        homeCubit.changeGoExpand(_scaffoldKey.currentContext!);
                      },
                      stopOnTap: () {
                        homeCubit
                            .onlineStatus(
                              stauts: "0",
                              servicesId:
                                  homeCubit.profilModel!.data!.serviceId,
                              lat: (currentPosition!.latitude).toString(),
                              long: (currentPosition!.longitude).toString(),
                            )
                            .then(
                              (value) => homeCubit.changeOnlineExpand(
                                  _scaffoldKey.currentContext!),
                            );
                        if (state is GetTodaySummarySuccessState)
                          back(_scaffoldKey.currentContext!);

                        // homeCubit
                        //     .changeOnlineExpand(_scaffoldKey.currentContext!)
                        //     .then((value) {
                        //   homeCubit.onlineStatus(
                        //       homeCubit.onlineExpand ==
                        //               false
                        //           ? "1"
                        //           : "0");
                        // });
                      },
                    ),

                  ///if onlineExpand = true
                  /// go online button
                  if (homeCubit.onlineExpand == true &&
                      homeCubit.goExpand == false)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.18),
                      child: Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        // child: InkWell(
                        //   onTap: () {
                        //     homeCubit
                        //         .onlineStatus(
                        //           stauts: "1",
                        //           servicesId:
                        //               homeCubit.profilModel!.data!.serviceId,
                        //           lat: (currentPosition!.latitude).toString(),
                        //           long:
                        //               (currentPosition!.longitude).toString(),
                        //         )
                        //         .then(
                        //           (value) => homeCubit.changeOnlineExpand(
                        //               _scaffoldKey.currentContext!),
                        //         );
                        //   },
                        //   child: Container(
                        //     margin: EdgeInsets.only(
                        //         bottom: height * 0.16, left: width * 0.05),
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: Colors.grey,
                        //           offset: Offset(0.0, 1.0), //(x,y)
                        //           blurRadius: 6.0,
                        //         ),
                        //       ],
                        //     ),
                        //     child: CircleAvatar(
                        //       radius: width * 0.08,
                        //       backgroundColor: mainColor,
                        //       child: Text(
                        //         "go".tr,
                        //         style: fifthLineStyle,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        child: InkWell(
                          onTap: () {
                            showLoadingDialog(_scaffoldKey.currentContext!);
                            homeCubit.getTodaySummary().then(
                              (value) {
                                back(_scaffoldKey.currentContext!);
                                showDialog(
                                  context: _scaffoldKey.currentContext!,
                                  builder: (context) {
                                    return WillPopScope(
                                      onWillPop: () async => false,
                                      child: AlertDialog(
                                        content: Column(
                                          children: [
                                            // Center(
                                            //     child: Text(
                                            //   "my_cash".tr,
                                            //   style: fifthLineStyle,
                                            // )),
                                            // SizedBox(
                                            //   height: height * 0.02,
                                            // ),
                                            // BoxWidget(
                                            //   width: width,
                                            //   height: height,
                                            // ),
                                            // Padding(
                                            //   padding:
                                            //       EdgeInsets.all(width * 0.01),
                                            //   child: Divider(),
                                            // ),
                                            // Center(
                                            //     child: Text(
                                            //   "part_price".tr,
                                            //   style: fifthLineStyle,
                                            // )),
                                            // SizedBox(
                                            //   height: height * 0.02,
                                            // ),
                                            // BoxWidget(
                                            //     width: width, height: height),
                                            // SizedBox(
                                            //   height: height * 0.01,
                                            // ),
                                            // Center(
                                            //     child: Text(
                                            //   "app_percent".tr,
                                            //   style: fifthLineStyle,
                                            // )),
                                            // SizedBox(
                                            //   height: height * 0.02,
                                            // ),
                                            // BoxWidget(
                                            //     width: width, height: height),
                                            // SizedBox(
                                            //   height: height * 0.03,
                                            // ),
                                            // CommonButton(
                                            //     text: "all_task".tr,
                                            //     width: width * 0.6,
                                            //     borderColor: redColor,
                                            //     textColor: redColor,
                                            //     onTap: () {
                                            //       goTo(
                                            //           context,
                                            //           Ratings(
                                            //             isOrderOnly: true,
                                            //           ));
                                            //     }),
                                            Expanded(
                                              child: homeCubit
                                                          .todaySummaryModel!
                                                          .data!
                                                          .length ==
                                                      0
                                                  ? NoDataWidget(
                                                      height: height / 2,
                                                      width: width,
                                                    )
                                                  : ListView.builder(
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      itemCount: homeCubit
                                                          .todaySummaryModel!
                                                          .data!
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Card(
                                                          child: ListTile(
                                                            title: Text(homeCubit
                                                                .todaySummaryModel!
                                                                .data![index]
                                                                .title!),
                                                            subtitle: Text(homeCubit
                                                                .todaySummaryModel!
                                                                .data![index]
                                                                .date!),
                                                            trailing: Text(homeCubit
                                                                    .todaySummaryModel!
                                                                    .data![
                                                                        index]
                                                                    .total! +
                                                                " " +
                                                                "sar".tr),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                            ),
                                            SizedBox(
                                              height: height * 0.03,
                                            ),
                                            CommonButton(
                                              width: width * 0.6,
                                              text: "confirm".tr,
                                              textColor: mainColor,
                                              containerColor: redColor,
                                              onTap: () {
                                                homeCubit
                                                    .onlineStatus(
                                                  stauts: "0",
                                                  servicesId: homeCubit
                                                      .profilModel!
                                                      .data!
                                                      .serviceId,
                                                  lat: (currentPosition!
                                                          .latitude)
                                                      .toString(),
                                                  long: (currentPosition!
                                                          .longitude)
                                                      .toString(),
                                                )
                                                    .then((value) {
                                                  homeCubit.staticsTasksList =
                                                      [];
                                                  homeCubit.staticsTasksList!
                                                      .clear();
                                                  AppCubit.get(context)
                                                      .onlineExpand = true;
                                                  exit(0);
                                                });
                                              },
                                              // onTap: confirmTap,
                                            ),
                                            SizedBox(height: height * 0.03),
                                            CommonButton(
                                                width: width * 0.6,
                                                height: height * 0.08,
                                                text: "cancel".tr,
                                                textColor: redColor,
                                                containerColor: mainColor,
                                                borderColor: redColor,
                                                onTap: () {
                                                  back(context);
                                                })
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ).then((value) {
                              print(",,,,,,,,,,,,");
                              // if (state is GetTodaySummaryLoadingState)
                              //   back(context);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: width * 0.09,
                              backgroundColor: mainColor,
                              child: CircleAvatar(
                                radius: width * 0.08,
                                backgroundColor: redColor,
                                child: CircleAvatar(
                                  radius: width * 0.075,
                                  backgroundColor: mainColor,
                                  child: Text(
                                    "stop".tr,
                                    style: fifthLineStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  /// if onlineExpand = true
                  /// offline Data and exit app
                  if (homeCubit.onlineExpand == true &&
                      homeCubit.goExpand == false)
                    OfflineDataWidget(
                      height: height,
                      width: width,
                      confirmTap: () {
                        homeCubit
                            .onlineStatus(
                              stauts: "1",
                              servicesId:
                                  homeCubit.profilModel!.data!.serviceId,
                              lat: (currentPosition!.latitude).toString(),
                              long: (currentPosition!.longitude).toString(),
                            )
                            .then(
                              (value) => homeCubit.changeOnlineExpand(
                                  _scaffoldKey.currentContext!),
                            );
                      },

                      // confirmTap: () {
                      //   homeCubit
                      //       .onlineStatus(
                      //     stauts: "0",
                      //     servicesId:
                      //         homeCubit.profilModel!.data!.serviceId,
                      //     lat: (currentPosition!.latitude).toString(),
                      //     long: (currentPosition!.longitude).toString(),
                      //   )
                      //       .then((value) {
                      //     AppCubit.get(context).onlineExpand = true;
                      //     exit(0);
                      //   });
                      // },
                    ),
                  //if go Expand = true
                  if (homeCubit.goExpand == true)
                    FindTaskWidget(
                      width: width,
                      height: height,
                      homeCubit: homeCubit,
                    )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
