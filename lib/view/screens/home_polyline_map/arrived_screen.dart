import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mohtaref/constant.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref/model/tasks_model.dart';
import 'package:mohtaref/view/components_widget/arrived_widgets/cancel_trip_widget.dart';
import 'package:mohtaref/view/components_widget/arrived_widgets/store_widget.dart';
import 'package:mohtaref/view/components_widget/arrived_widgets/trip_details.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';
import 'package:mohtaref/view/components_widget/icon_button_widget.dart';
import 'package:mohtaref/view/components_widget/navigator.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:mohtaref/view/components_widget/text_form_field_widget.dart';
import 'package:mohtaref/view/notification_handler_widget.dart';
import 'package:get/get.dart';
import 'cancel_task_screen.dart';

class ArrivedScreen extends StatefulWidget {
  // final String? reciverId;
  final CustomerData? customerData;
  final TaskDetails? taskDetails;

  ArrivedScreen({this.customerData, this.taskDetails});

  @override
  _ArrivedScreenState createState() => _ArrivedScreenState();
}

class _ArrivedScreenState extends State<ArrivedScreen> {
  final feesAmountController = TextEditingController();

  final itemsAmountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    var cubit = AppCubit.get(context);

    setState(() {
      /// origin marker
      cubit.orginMarker();
    });

    /// destination marker
    cubit.destinationMarker(
      destLatitude: double.parse(widget.taskDetails!.lat!),
      destLongitude: double.parse(widget.taskDetails!.long!),
    );
    cubit.getPolyline(
      destLatitude: double.parse(widget.taskDetails!.lat!),
      destLongitude: double.parse(widget.taskDetails!.long!),
    );
  }

  @override
  Widget build(BuildContext context) {
    NotificationHandlerWidget.onMessageConfirmPayNotification(context);
    NotificationHandlerWidget.onAppOpenedConfirmPayNotification(context);
    // NotificationHandlerWidget.onBackGroundConfirmPayNotification(context);
    NotificationHandlerWidget.onMessagesNotificationCancelTask(context);
    NotificationHandlerWidget.onAppOpenedNotificationCancelTask(context);
    // NotificationHandlerWidget.onBackGroundNotificationCancelTask(context);
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is ConfirmPayLoadingState) showLoadingDialog(context);
        if (state is ConfirmPaySuccessState) back(context);
        if (state is ConfirmPayErrorState) back(context);
      }, builder: (context, state) {
        var homeCubit = AppCubit.get(context);
        String twoDigit(int numDigit) => numDigit.toString().padLeft(2, '0');
        final second = twoDigit(homeCubit.duration.inSeconds.remainder(60));
        final minutes = twoDigit(homeCubit.duration.inMinutes.remainder(60));

        final hours = twoDigit(homeCubit.duration.inHours);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              // constantBackgroundScreens(height, width),
              /// Map
              GoogleMap(
                padding:
                    EdgeInsets.only(bottom: height * 0.35, top: height * 0.15),
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                // trafficEnabled: true,
                initialCameraPosition: homeCubit.kGooglePlex,
                onMapCreated: homeCubit.onMapCreated,
                // onMapCreated: (GoogleMapController controller) {
                //   // _mapController.complete(controller);

                //   homeCubit.mapController.complete(controller);
                //   // homeCubit.getCurrentPosition();
                // },
                markers: Set<Marker>.of(homeCubit.markers.values),
                polylines: Set<Polyline>.of(homeCubit.polylines.values),
              ),
              Container(
                height: height * 0.7,
                width: width,
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.1),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(width * 0.05)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Padding(
                    //   padding:
                    //       EdgeInsets.symmetric(vertical: height * 0.08),
                    //   child: BoxWidget(width: width, height: height),
                    // ),

                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButtonWidget(
                            circleAvatarColor: redColor,
                            radius: width * 0.1,
                            icon: Icons.shopping_cart_rounded,
                            size: width * 0.08,
                            onpressed: () {
                              homeCubit.changeStoresExpand(context);
                            },
                          ),
                          IconButtonWidget(
                            circleAvatarColor: mainColor,
                            radius: width * 0.1,
                            icon: Icons.close,
                            size: width * 0.08,
                            borderColor: redColor,
                            onpressed: () {
                              homeCubit.changeCancelTaskExpand(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.05),
                      child: Text(
                        "$second : $minutes : $hours",
                        style: secondLineStyle,
                      ),
                    ),

                    /// Trip Details
                    TripDetails(
                      width: width,
                      height: height,
                      customerData: widget.customerData,
                      taskDetails: widget.taskDetails,
                      onTap: () {
                        homeCubit.stopTimer();
                        homeCubit.changePaymentExpand(context);
                        // showDialog(
                        //   context: context,
                        //   barrierDismissible: false,
                        //   builder: (context) => AlertDialog(
                        //     content: WillPopScope(
                        //       onWillPop: () async {
                        //         showFlutterToast(
                        //             message: "no_back".tr,
                        //             backgroundColor: redColor);
                        //         return false;
                        //       },
                        //       child: SingleChildScrollView(
                        //         child: Form(
                        //           key: _formKey,
                        //           child: Column(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               TextFormFieldWidget(
                        //                 controller: feesAmountController,
                        //                 hint: "please_enter_fees_amount".tr,
                        //                 keyboardType: TextInputType.number,
                        //                 textInputAction:
                        //                     TextInputAction.next,
                        //                 valdiator: (value) {
                        //                   if (value!.isEmpty) {
                        //                     return "enter_this_field_please!"
                        //                         .tr;
                        //                   }
                        //                   return null;
                        //                 },
                        //               ),
                        //               TextFormFieldWidget(
                        //                 controller: itemsAmountController,
                        //                 hint: "please_buy_items_amount".tr,
                        //                 keyboardType: TextInputType.number,
                        //                 textInputAction:
                        //                     TextInputAction.done,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     actions: [
                        //       CommonButton(
                        //         text: "done".tr,
                        //         textColor: buttonColor,
                        //         onTap: () {
                        //           if (!_formKey.currentState!.validate()) {
                        //             return;
                        //           }
                        //           print(
                        //               "Customer ID is --> ${customerData!.id!}");
                        //           homeCubit
                        //               .deleteMessages(customerData!.id!);
                        //           // homeCubit.stopTimer();
                        //           timeEstmate = (hours == "00")
                        //               ? "$minutes " + "mins".tr
                        //               : "$hours " +
                        //                   "hrs".tr +
                        //                   " , " +
                        //                   "$minutes " +
                        //                   "mins".tr;
                        //           homeCubit
                        //               .confirmPay(
                        //             taskId: taskDetails!.id,
                        //             fees: feesAmountController.text,
                        //             spares: itemsAmountController.text,
                        //           )
                        //               .then((value) {
                        //             back(context);
                        //             showLoadingDialog(context);
                        //           });
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // );

                        // showAlertDailog(
                        //   isContent: true,
                        //   barrierDismissible: false,
                        //   context: context,
                        //   labelNo: "cancel".tr,
                        //   labelYes: "done".tr,
                        //   titlle: "enter_fees_amount".tr,
                        //   contentWidget: WillPopScope(
                        //     onWillPop: () async {
                        //       showFlutterToast(
                        //           message: "no_back".tr,
                        //           backgroundColor: redColor);
                        //       return false;
                        //     },
                        //     child: SingleChildScrollView(
                        //       child: Form(
                        //         key: _formKey,
                        //         child: Column(
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: [
                        //             TextFormFieldWidget(
                        //               controller: feesAmountController,
                        //               hint: "please_enter_fees_amount".tr,
                        //               keyboardType: TextInputType.number,
                        //               textInputAction: TextInputAction.next,
                        //               valdiator: (value) {
                        //                 if (value!.isEmpty) {
                        //                   return "enter_this_field_please!"
                        //                       .tr;
                        //                 }
                        //                 return null;
                        //               },
                        //             ),
                        //             TextFormFieldWidget(
                        //               controller: itemsAmountController,
                        //               hint: "please_buy_items_amount".tr,
                        //               keyboardType: TextInputType.number,
                        //               textInputAction: TextInputAction.done,
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        //   onPressNo: () {
                        //     back(context);
                        //   },
                        //   onPressYes: () {
                        //     if (!_formKey.currentState!.validate()) {
                        //       return;
                        //     }
                        //     print(
                        //         "Customer ID is --> ${customerData!.id!}");
                        //     homeCubit.deleteMessages(customerData!.id!);
                        //     // homeCubit.stopTimer();
                        //     timeEstmate = (hours == "00")
                        //         ? "$minutes " + "mins".tr
                        //         : "$hours " +
                        //             "hrs".tr +
                        //             " , " +
                        //             "$minutes " +
                        //             "mins".tr;
                        //     homeCubit
                        //         .confirmPay(
                        //       taskId: taskDetails!.id,
                        //       fees: feesAmountController.text,
                        //       spares: itemsAmountController.text,
                        //     )
                        //         .then((value) {
                        //       back(context);
                        //       showLoadingDialog(context);
                        //     });
                        //   },
                        // );
                      },
                    ),
                  ],
                ),
              ),

              /// Cancel Task Widget
              if (homeCubit.cancelTaskExpand == true)
                CancelTaskWidget(
                  width: width,
                  height: height,
                  onTapYes: () {
                    homeCubit.deleteCacheDir();
                    homeCubit.deleteMessages(widget.customerData!.id!);
                    homeCubit.resetPolyline();
                    homeCubit.googleMapController!.dispose();
                    homeCubit.stopTimer();
                    homeCubit.tasksModel!.tasks = null;
                    homeCubit
                        .cancelTask(
                          customerId: widget.customerData!.id!,
                          taskId: widget.taskDetails!.id,
                        )
                        .then((value) => goTo(
                            context,
                            CancelTaskScreen(
                              taskid: widget.taskDetails!.id,
                            )));
                  },
                  onTapNo: () {
                    homeCubit.changeCancelTaskExpand(context);
                  },
                ),

              /// Store Widget
              if (homeCubit.storesExpand == true)
                StoreWidget(
                  width: width,
                  height: height,
                  homeCubit: homeCubit,
                  onTap: () {
                    homeCubit.changeStoresExpand(context);
                  },
                ),

              /// Store Widget
              if (homeCubit.paymentExpand == true)
                WillPopScope(
                  onWillPop: () async {
                    showFlutterToast(
                        message: "no_back".tr, backgroundColor: redColor);
                    return false;
                  },
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Container(
                          width: width,
                          height: height,
                          color: mainColor,
                          margin: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                              vertical: height * 0.01),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "enter_fees_amount".tr,
                                style: thirdLineStyle,
                              ),
                              TextFormFieldWidget(
                                controller: feesAmountController,
                                hint: "please_enter_fees_amount".tr,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                valdiator: (value) {
                                  if (value!.isEmpty) {
                                    return "enter_this_field_please!".tr;
                                  }
                                  return null;
                                },
                              ),
                              TextFormFieldWidget(
                                controller: itemsAmountController,
                                hint: "please_buy_items_amount".tr,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                              ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              CommonButton(
                                text: "done".tr,
                                width: width * 0.8,
                                containerColor: redColor,
                                textColor: mainColor,
                                onTap: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  print(
                                      "Customer ID is --> ${widget.customerData!.id!}");
                                  homeCubit
                                      .deleteMessages(widget.customerData!.id!);
                                  // homeCubit.stopTimer();
                                  timeEstmate = (hours == "00")
                                      ? "$minutes " + "mins".tr
                                      : "$hours " +
                                          "hrs".tr +
                                          " , " +
                                          "$minutes " +
                                          "mins".tr;
                                  homeCubit
                                      .confirmPay(
                                    taskId: widget.taskDetails!.id,
                                    fees: feesAmountController.text,
                                    spares: itemsAmountController.text,
                                  )
                                      .then((value) {
                                    // back(context);
                                    // homeCubit.changePaymentExpand(context);
                                    customerDueAmount = double.parse(
                                            feesAmountController.text) +
                                        double.parse(
                                            itemsAmountController.text);
                                    print(
                                        "customerDueAmount--> $customerDueAmount");
                                    showLoadingDialog(context);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              /// confirm payment notification
              // if (confirmPaymentNotificationBody!
              //     .contains("payment_success")) ...[
              //   Align(
              //     alignment: AlignmentDirectional.bottomCenter,
              //     child: Container(
              //       height: height,
              //       width: width,
              //       color: mainColor,
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Text(
              //             "success_pay".tr,
              //             style: secondLineStyle,
              //           ),
              //           SizedBox(
              //             height: height * 0.1,
              //           ),
              //           CommonButton(
              //             height: height * 0.08,
              //             width: width * 0.45,
              //             fontSize: width * 0.04,
              //             text: "continue".tr,
              //             textColor: mainColor,
              //             containerColor: redColor,
              //             onTap: () {
              //               print(
              //                   ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,$confirmPaymentNotificationBody");
              //               print(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
              //               // back(context);

              //               homeCubit.getTaskDetails(taskDetails!.id).then(
              //                 (value) {
              //                   goTo(
              //                       context,
              //                       CollectCashScreen(
              //                         customerData: customerData!,
              //                       ));
              //                   confirmPaymentNotificationBody = "";
              //                 },
              //               );

              //               print(
              //                   ",,,,,,,,,,,,,,,,,,,,,,,,55555555,,,,,,,$confirmPaymentNotificationBody");
              //               print(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),

              // ]
            ],
          ),
        );
      });
    });
  }
}
