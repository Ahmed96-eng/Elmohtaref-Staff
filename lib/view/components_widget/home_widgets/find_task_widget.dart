import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/view/components_widget/cached_network_Image_widget.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';
import 'package:mohtaref/view/components_widget/navigator.dart';
import 'package:mohtaref/view/components_widget/style.dart';
// import 'package:mohtaref/view/screens/home_polyline_map/polyline_map.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../constant.dart';
import '../no_data_widget.dart';

class FindTaskWidget extends StatefulWidget {
  const FindTaskWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.homeCubit,
  }) : super(key: key);

  final double width;
  final double height;
  final AppCubit homeCubit;

  @override
  _FindTaskWidgetState createState() => _FindTaskWidgetState();
}

class _FindTaskWidgetState extends State<FindTaskWidget> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  Timer? timerPeriodic;
  @override
  void initState() {
    timerPeriodic = Timer.periodic(new Duration(seconds: 20), (timer) {
      widget.homeCubit.getTasksPagination(
        // isRefresh: false,
        lat: currentPosition!.latitude,
        long: currentPosition!.longitude,
        serviceId: widget.homeCubit.profilModel!.data!.serviceId,
      );
    });
    if (widget.homeCubit.notificationToggle) {
      FirebaseMessaging.instance
          .subscribeToTopic(widget.homeCubit.profilModel!.data!.serviceId!);
      print("subscribeToTopic");
    } else {
      FirebaseMessaging.instance
          .unsubscribeFromTopic(widget.homeCubit.profilModel!.data!.serviceId!);
      print("UNsubscribeToTopic");
    }
    super.initState();
  }

  @override
  void dispose() {
    timerPeriodic!.cancel();
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.homeCubit.notificationToggle) {
    //   FirebaseMessaging.instance
    //       .subscribeToTopic(widget.homeCubit.profilModel!.data!.serviceId!);
    //   print("subscribeToTopic");
    // } else {
    //   FirebaseMessaging.instance
    //       .unsubscribeFromTopic(widget.homeCubit.profilModel!.data!.serviceId!);
    //   print("UNsubscribeToTopic");
    // }

    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.width * 0.05),
                topRight: Radius.circular(widget.width * 0.05)),
            color: Colors.white,
          ),
          width: widget.width,
          height: widget.height * 0.6,
          child: Column(
            children: [
              SizedBox(
                height: widget.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "find_task".tr,
                    style: thirdLineStyle,
                  ),
                  InkWell(
                    onTap: () {
                      widget.homeCubit.changeGoExpand(context);
                      timerPeriodic!.cancel();
                      // widget.homeCubit.tasksModel!.tasks = null;
                      widget.homeCubit.taskCustomerData = [];
                      widget.homeCubit.taskDetails = [];
                      widget.homeCubit.currentPage = 1;
                    },
                    child: Container(
                      width: widget.width * 0.2,
                      height: widget.height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: thirdColor,
                          border: Border.all(
                            color: redColor!,
                            width: widget.width * 0.005,
                          )),
                      child: Center(
                        child: Text(
                          "stop".tr,
                          style: fifthLineStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),

              /// tasks orders
              Expanded(
                  child: SmartRefresher(
                controller: refreshController,
                enablePullUp: true,
                onRefresh: () async {
                  final result = await widget.homeCubit.getTasksPagination(
                    // isRefresh: false,
                    lat: currentPosition!.latitude,
                    long: currentPosition!.longitude,
                    serviceId: widget.homeCubit.profilModel!.data!.serviceId,
                  );
                  if (result != null) {
                    refreshController.refreshCompleted();
                  } else {
                    refreshController.refreshFailed();
                    refreshController.loadNoData();
                  }
                },
                // onLoading: () async {
                //   final result = await widget.homeCubit.getTasksPagination(
                //     lat: currentPosition!.latitude,
                //     long: currentPosition!.longitude,
                //     serviceId: widget.homeCubit.profilModel!.data!.serviceId,
                //   );
                //   if (result != null) {
                //     refreshController!.loadComplete();
                //   } else {
                //     refreshController!.loadFailed();
                //     refreshController!.loadNoData();
                //   }
                // },
                child: widget.homeCubit.taskCustomerData!.length != 0
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        // itemCount: taskDetails.length,
                        itemCount: widget.homeCubit.taskCustomerData!.length,
                        itemBuilder: (context, index) => ListTile(
                          title: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => AlertDialog(
                                  content: Text("confirm_task".tr),
                                  actions: [
                                    CommonButton(
                                        width: widget.width * 0.2,
                                        height: widget.height * 0.05,
                                        text: "confirm".tr,
                                        textColor: mainColor,
                                        containerColor: redColor,
                                        onTap: () {
                                          back(context);
                                          widget.homeCubit.staffOfferToCustomer(
                                              taskId: widget.homeCubit
                                                  .taskDetails![index].id);
                                          showLoadingDialog(context,
                                              showButton: true);
                                          timerPeriodic!.cancel();
                                          // showDialog(
                                          //   context: context,
                                          //   barrierDismissible: false,
                                          //   builder: (context) => WillPopScope(
                                          //     onWillPop: () async {
                                          //       return false;
                                          //     },
                                          //     child: AlertDialog(
                                          //       content: Text(
                                          //         "Loading",
                                          //         textAlign: TextAlign.center,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // );
                                          // showAlertDailog(
                                          //     context: context,
                                          //     isContent: true,
                                          //     labelNo: "",
                                          //     labelYes: "",
                                          //     titlle: " ",
                                          //     message: "loading",
                                          //     contentWidget: Center(
                                          //       child: Column(
                                          //         mainAxisSize: MainAxisSize.min,
                                          //         children: [
                                          //           Text("Loading"),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     onPressNo: () {},
                                          //     onPressYes: () {});

                                          // var taskDetails = AppCubit.get(context)
                                          //     .tasksModel!
                                          //     .tasks!
                                          //     .tasksData!
                                          //     .taskDetails!;
                                          // var customerDetails = AppCubit.get(context)
                                          //     .tasksModel!
                                          //     .tasks!
                                          //     .tasksData!
                                          //     .customerData!;
                                          // widget.homeCubit
                                          //     .getDestinationAddressFromLatLng(
                                          //   destLatitude: double.parse(widget
                                          //       .homeCubit.taskDetails![index].lat!),
                                          //   destLongitude: double.parse(widget
                                          //       .homeCubit.taskDetails![index].long!),
                                          // );

                                          // print(
                                          //     "qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq${widget.homeCubit.taskCustomerData![index].rate}");
                                          // goTo(
                                          //     context,
                                          //     PolyLineMapScreen(
                                          //       customerData: widget.homeCubit
                                          //           .taskCustomerData![index],
                                          //       taskDetails: widget
                                          //           .homeCubit.taskDetails![index],
                                          //     ));
                                        }),
                                    CommonButton(
                                        width: widget.width * 0.2,
                                        height: widget.height * 0.05,
                                        text: "cancel".tr,
                                        textColor: mainColor,
                                        containerColor: redColor,
                                        onTap: () {
                                          timerPeriodic!.cancel();
                                          widget.homeCubit
                                              .changeGoExpand(context);
                                          back(context);
                                        }),
                                  ],
                                ),
                              );
                            },
                            child: Card(
                              elevation: 3,
                              child: ListTile(
                                // leading: CircleAvatar(
                                //   backgroundImage: NetworkImage(
                                //       "https://el-mohtaref.com/" +
                                //           customerDetails[0]
                                //               .profile!),
                                // ),
                                leading: ClipOval(
                                  child: CachedNetworkImageWidget(
                                    width: widget.width * 0.09,
                                    height: widget.height * 0.05,
                                    image: widget.homeCubit
                                        .taskCustomerData![index].profile!,
                                    // image: homeCubit.tasks![index].tasks!.tasksData!.customerData![0].profile!,
                                  ),
                                ),
                                title: Text(
                                  // homeCubit.tasks![index].tasks!.tasksData!.taskDetails![0].title!,
                                  widget.homeCubit.taskDetails![index].title!,
                                  style: lineStyleSmallBlack,
                                ),
                                subtitle: Text(
                                  "location".tr +
                                      " : " +
                                      // homeCubit.tasks![index].tasks!.tasksData!.taskDetails![0].title!,
                                      widget.homeCubit.taskDetails![index]
                                          .taskLocation!,
                                  style: lineStyleSmallBlack,
                                ),
                                // trailing: Text(
                                //   taskDetails[index].distance!,
                                //   style: fifthLineStyle,
                                // ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "no_tasks_found_yet".tr,
                            textAlign: TextAlign.center,
                            style: labelStyleMinBlack,
                          ),
                          NoDataWidget(
                              width: widget.width * 0.6,
                              height: widget.height * 0.4)
                        ],
                      ),
              ))
            ],
          ),
        ));
  }
}
