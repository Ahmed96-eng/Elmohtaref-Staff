import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mohtaref/constant.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref/model/tasks_model.dart';
import 'package:mohtaref/view/components_widget/arrived_widgets/cancel_trip_widget.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';
import 'package:get/get.dart';
import 'package:mohtaref/view/components_widget/fixed_text_field_widget.dart';
import 'package:mohtaref/view/components_widget/navigator.dart';
import 'package:mohtaref/view/notification_handler_widget.dart';
import 'package:mohtaref/view/screens/chat/chat_screen.dart';
import 'package:mohtaref/view/screens/home_polyline_map/arrived_screen.dart';
import 'package:mohtaref/view/screens/home_polyline_map/cancel_task_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class PolyLineMapScreen extends StatefulWidget {
  final CustomerData? customerData;
  final TaskDetails? taskDetails;

  const PolyLineMapScreen({this.customerData, this.taskDetails});
  @override
  _PolyLineMapScreenState createState() => _PolyLineMapScreenState();
}

class _PolyLineMapScreenState extends State<PolyLineMapScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final Completer<GoogleMapController> _mapController = Completer();
  final titleComplaintController = TextEditingController();
  final descriptionComplaintController = TextEditingController();
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

  // @override
  // void dispose() {
  //   AppCubit.get(context).googleMapController!.dispose();

  //   // AppCubit.get(context).resetPolyline();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    NotificationHandlerWidget.onMessagesNotificationCancelTask(context);
    NotificationHandlerWidget.onAppOpenedNotificationCancelTask(context);
    // NotificationHandlerWidget.onBackGroundNotificationCancelTask(context);
    // print("cccccccccccccccccc---> ${widget.customerData!.email!}");
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is SendComplaintLoadingState) showLoadingDialog(context);
      }, builder: (context, state) {
        var homeCubit = AppCubit.get(context);
        return WillPopScope(
          onWillPop: () {
            homeCubit.changeCancelTaskExpand(context);
            return showFlutterToast(
                message: "cancel".tr, backgroundColor: Colors.transparent);
          },
          child: Scaffold(
            key: _scaffoldKey,
            body: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                /// Map
                GoogleMap(
                  padding: EdgeInsets.only(
                      bottom: height * 0.35, top: height * 0.15),
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

                /// Current Address
                Container(
                  margin: EdgeInsets.only(top: height * 0.05),
                  width: width * 0.9,
                  // height: height * 0.1,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(width * 0.1),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.person_pin_circle_outlined,
                      color: redColor,
                    ),
                    title: Text("$currentAddress"),
                  ),
                ),

                /// select task
                if (homeCubit.cancelTaskExpand == false)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      width: width,
                      height: height * 0.35,
                      color: mainColor,
                      child: Column(
                        children: [
                          ListTile(
                            leading: IconButton(
                              icon: Icon(Icons.phone),
                              onPressed: () async {
                                String phoneNumber =
                                    widget.customerData!.mobile!;
                                // another solution
                                // String phoneNumber = Uri.encodeComponent('0114919223');
                                await canLaunch("tel:$phoneNumber")
                                    ? launch("tel:$phoneNumber")
                                    : showFlutterToast(
                                        message: "call_faild".tr);
                              },
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(widget.taskDetails!.time!.toString()),
                                CircleAvatar(),
                                Text(widget.taskDetails!.distance!.toString()),
                              ],
                            ),
                            subtitle: Text(
                                "picking up ${widget.customerData!.username!}"),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: Divider(),
                          ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SocialWidget(
                                title: "complaint".tr,
                                icon: Icons.speaker_notes_outlined,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          FixedTextField(
                                            width: width,
                                            height: height * 0.3,
                                            hint: "title_complaint".tr,
                                            radiusValue: width * 0.02,
                                            controller:
                                                titleComplaintController,
                                            icon: Icons.description_outlined,
                                            iconColor: redColor,
                                          ),
                                          FixedTextField(
                                            width: width,
                                            height: height * 0.3,
                                            hint: "description_complaint".tr,
                                            radiusValue: width * 0.02,
                                            controller:
                                                descriptionComplaintController,
                                            textInputAction:
                                                TextInputAction.done,
                                            icon: Icons.description_outlined,
                                            iconColor: redColor,
                                          ),
                                          SizedBox(height: height * 0.02),
                                          CommonButton(
                                              width: width * 0.85,
                                              height: height * 0.09,
                                              containerColor: redColor,
                                              textColor: mainColor,
                                              text: "send_complaint".tr,
                                              onTap: () {
                                                if (titleComplaintController
                                                        .text.isEmpty ||
                                                    descriptionComplaintController
                                                        .text.isEmpty) {
                                                  showFlutterToast(
                                                      message:
                                                          "check_empty_fields_please"
                                                              .tr,
                                                      backgroundColor:
                                                          darkColor);
                                                } else {
                                                  homeCubit
                                                      .sendComplaint(
                                                          title:
                                                              titleComplaintController
                                                                  .text,
                                                          description:
                                                              descriptionComplaintController
                                                                  .text)
                                                      .then((value) => [
                                                            back(context),
                                                            back(context),
                                                            titleComplaintController
                                                                .clear(),
                                                            descriptionComplaintController
                                                                .clear(),
                                                          ]);
                                                }
                                              })
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SocialWidget(
                                title: "chat".tr,
                                icon: Icons.forum_outlined,
                                onTap: () {
                                  print(
                                      "recevierId--> ${widget.customerData!.id}");
                                  // AppCubit.get(context).getSenderMessages()
                                  // .then(
                                  //   (value) =>
                                  AppCubit.get(context).getMessages(
                                          widget.customerData!.id.toString())
                                      // )
                                      ;
                                  goTo(
                                      context,
                                      ChatScreen(
                                        reciverId: widget.customerData!.id,
                                        username: widget.customerData!.username,
                                        userImg: widget.customerData!.profile,
                                      ));
                                },
                              ),
                              SocialWidget(
                                title: "message".tr,
                                icon: Icons.sms_outlined,
                                onTap: () async {
                                  String androidUrl =
                                      'sms:${widget.customerData!.mobile!}?body=message';
                                  String iosUrl =
                                      'sms:+${widget.customerData!.mobile!}&body=message';
                                  // await launch("sms:$androidUrl");
                                  print(androidUrl);
                                  print(Platform.isAndroid);
                                  print(Platform.isIOS);
                                  //                                     await canLaunch("sms:01145919223")
                                  //                                         ? launch("sms:01145919223")
                                  //                                         // : showFlutterToast(
                                  //                                         //     message: "call_faild".tr);
                                  // :print("errrrrror");
                                  if (Platform.isAndroid) {
                                    //FOR Android
                                    await launch(
                                      androidUrl,
                                      enableJavaScript: true,
                                    );
                                  } else if (Platform.isIOS) {
                                    await launch(
                                      iosUrl,
                                      enableJavaScript: true,
                                    );
                                  } else {
                                    showFlutterToast(
                                        message: "send_message_faild".tr);
                                  }
                                },
                              ),
                              SocialWidget(
                                title: "cancel".tr,
                                icon: Icons.close_outlined,
                                onTap: () {
                                  homeCubit.changeCancelTaskExpand(context);
                                },
                              ),
                            ],
                          )),
                          CommonButton(
                              width: width * 0.85,
                              height: height * 0.08,
                              containerColor: redColor,
                              textColor: mainColor,
                              text: "arrived".tr,
                              onTap: () {
                                homeCubit
                                    .arriveNotificationToCustomer(
                                        customerId: widget.customerData!.id)
                                    .then((value) {
                                  homeCubit.startTimer();
                                  goTo(
                                      context,
                                      ArrivedScreen(
                                        customerData: widget.customerData!,
                                        taskDetails: widget.taskDetails!,
                                      ));
                                  homeCubit.resetPolyline();
                                });
                              }),
                          SizedBox(
                            height: height * 0.01,
                          ),
                        ],
                      ),
                    ),
                  ),

                /// cancel task
                if (homeCubit.cancelTaskExpand == true)
                  CancelTaskWidget(
                    width: width,
                    height: height,
                    onTapYes: (state is CancelTaskLoadingState)
                        ? () {
                            showFlutterToast(
                                message: "loading".tr,
                                backgroundColor: darkColor);
                          }
                        : () {
                            homeCubit.deleteCacheDir();
                            homeCubit.deleteMessages(widget.customerData!.id!);
                            homeCubit.tasksModel!.tasks = null;
                            homeCubit.googleMapController!.dispose();
                            homeCubit.resetPolyline().then((value) => homeCubit
                                .cancelTask(
                                    customerId: widget.customerData!.id!,
                                    taskId: widget.taskDetails!.id)
                                .then((value) => goTo(
                                    context,
                                    CancelTaskScreen(
                                      taskid: widget.taskDetails!.id,
                                    ))));
                          },
                    onTapNo: () {
                      homeCubit.changeCancelTaskExpand(context);
                    },
                  ),
              ],
            ),
          ),
        );
      });
    });
  }
}

class SocialWidget extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final GestureTapCallback? onTap;

  const SocialWidget({this.title, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon!),
            Text(title!),
          ],
        ),
      ),
    );
  }
}
