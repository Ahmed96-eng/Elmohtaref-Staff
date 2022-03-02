import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/model/tasks_model.dart';
import 'package:mohtaref/view/screens/home/home_screen.dart';
import 'package:mohtaref/view/screens/home_polyline_map/confirm_pay_screen.dart';
import 'package:mohtaref/view/screens/home_polyline_map/polyline_map.dart';
import 'components_widget/navigator.dart';

// String? confirmPaymentNotificationBody = "";

abstract class NotificationHandlerWidget {
  /// start Notification

  static void onMessagesNotification(BuildContext context) =>
      FirebaseMessaging.onMessage.listen((event) {
        print("onMessage-->${event.notification!.body}");
        print("onMessage-->new ---> ${event.data['status']}");
        print("onMessage-->${event.data['customer']}");
        print("onMessage-->${event.data['task_details']}");
        print("goto onMessage");
        var status = event.data['status'];
        print("onMessage-->new status ---> $status}");
        if (status.contains("accept_staff")) {
          var decodeCustomer = jsonDecode(event.data['customer']!);
          var decodeDetails = jsonDecode(event.data['task_details']!);
          print("ddddddddddddd->${decodeCustomer['profile']}");
          print("fffffffffff->${decodeDetails['time']}");
          var customer = CustomerData(
            id: decodeCustomer!['id'].toString(),
            email: decodeCustomer!['email'],
            profile: decodeCustomer!['profile'],
            username: decodeCustomer!['username'],
            location: decodeCustomer!['location'],
            rate: decodeCustomer!['rate'],
            mobile: decodeCustomer!['mobile'].toString(),
            lat: decodeCustomer!['lat'].toString(),
            long: decodeCustomer!['long'].toString(),
          );
          var details = TaskDetails(
            id: decodeDetails!['id'].toString(),
            description: decodeDetails!['description'],
            distance: decodeDetails!['distance'].toString(),
            time: decodeDetails!['time'].toString(),
            title: decodeDetails!['title'],
            lat: decodeDetails!['lat'].toString(),
            long: decodeDetails!['long'].toString(),
            created: decodeDetails!['created'].toString(),
          );

          print("vvvvvvvvvbbbbbbbbnnnnnnnnnnnnn--->${decodeDetails!['title']}");

          var homeCubit = AppCubit.get(context);
          homeCubit.resetPolyline();
          homeCubit.getDestinationAddressFromLatLng(
            destLatitude: double.parse(decodeDetails!['lat'].toString()),
            destLongitude: double.parse(decodeDetails!['long'].toString()),
          );
          goTo(
              context,
              PolyLineMapScreen(
                customerData: customer,
                taskDetails: details,
              ));
        }
        if (status.contains("refuse_staff")) {
          print("kkkkkkkkkkkkkkkkkkkkkkk");
          back(context);
          // goTo(context, HomeScreen());
        }

        // showFlutterToast(message: "onMessage", backgroundColor: Colors.green);
      });

  static void onAppOpenedNotification(BuildContext context) =>
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print("onMessageOpenedApp-->${event.notification!.body}");
        print("goto onMessageOpenedApp");
        var status = event.data['status'];
        if (status.contains("accept_staff")) {
          var decodeCustomer = jsonDecode(event.data['customer']!);
          var decodeDetails = jsonDecode(event.data['task_details']!);
          print("ddddddddddddd->${decodeCustomer['profile']}");
          print("fffffffffff->${decodeDetails['time']}");
          var customer = CustomerData(
            id: decodeCustomer!['id'].toString(),
            email: decodeCustomer!['email'],
            profile: decodeCustomer!['profile'],
            username: decodeCustomer!['username'],
            location: decodeCustomer!['location'],
            rate: decodeCustomer!['rate'],
            mobile: decodeCustomer!['mobile'].toString(),
            lat: decodeCustomer!['lat'].toString(),
            long: decodeCustomer!['long'].toString(),
          );
          var details = TaskDetails(
            id: decodeDetails!['id'].toString(),
            description: decodeDetails!['description'],
            distance: decodeDetails!['distance'].toString(),
            time: decodeDetails!['time'].toString(),
            title: decodeDetails!['title'],
            lat: decodeDetails!['lat'].toString(),
            long: decodeDetails!['long'].toString(),
            created: decodeDetails!['created'].toString(),
          );
          var homeCubit = AppCubit.get(context);
          homeCubit.resetPolyline();
          homeCubit.getDestinationAddressFromLatLng(
            destLatitude: double.parse(decodeDetails!['lat'].toString()),
            destLongitude: double.parse(decodeDetails!['long'].toString()),
          );
          goTo(
              context,
              PolyLineMapScreen(
                customerData: customer,
                taskDetails: details,
              ));
        }

        if (status.contains("refuse_staff")) {
          print("kkkkkkkkkkkkkkkkkkkkkkk");
          back(context);
          // goTo(context, HomeScreen());
        }
        // showFlutterToast(
        // message: "onMessageOpenedApp", backgroundColor: Colors.green);
      });

  static void onBackGroundNotification(BuildContext context) async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("goto onBackgroundMessage");
      print("onBackgroundMessage-->${message.notification!.body}");
      var status = message.data['status'];
      if (status.contains("accept_staff")) {
        var decodeCustomer = jsonDecode(message.data['customer']!);
        var decodeDetails = jsonDecode(message.data['task_details']!);
        print("ddddddddddddd->${decodeCustomer['profile']}");
        print("fffffffffff->${decodeDetails['time']}");
        var customer = CustomerData(
          id: decodeCustomer!['id'].toString(),
          email: decodeCustomer!['email'],
          profile: decodeCustomer!['profile'],
          username: decodeCustomer!['username'],
          location: decodeCustomer!['location'],
          rate: decodeCustomer!['rate'],
          mobile: decodeCustomer!['mobile'].toString(),
          lat: decodeCustomer!['lat'].toString(),
          long: decodeCustomer!['long'].toString(),
        );
        var details = TaskDetails(
          id: decodeDetails!['id'].toString(),
          description: decodeDetails!['description'],
          distance: decodeDetails!['distance'].toString(),
          time: decodeDetails!['time'].toString(),
          title: decodeDetails!['title'],
          lat: decodeDetails!['lat'].toString(),
          long: decodeDetails!['long'].toString(),
          created: decodeDetails!['created'].toString(),
        );
        var homeCubit = AppCubit.get(context);
        await homeCubit.resetPolyline();
        homeCubit.getDestinationAddressFromLatLng(
          destLatitude: double.parse(decodeDetails!['lat'].toString()),
          destLongitude: double.parse(decodeDetails!['long'].toString()),
        );
        goTo(
            context,
            PolyLineMapScreen(
              customerData: customer,
              taskDetails: details,
            ));
      }

      if (status.contains("refuse_staff")) {
        print("kkkkkkkkkkkkkkkkkkkkkkk");
        back(context);
        // goTo(context, HomeScreen());
      }
      // return showFlutterToast(
      // message: "onBackgroundMessage", backgroundColor: Colors.green);
    });
  }

  /// end Notification
  ///
  ///
  /// start ConfirmPayNotification

  static void onMessageConfirmPayNotification(BuildContext context) =>
      FirebaseMessaging.onMessage.listen((event) {
        print("onMessage-->${event.notification!.body}");
        print("goto onMessage");
        var status = event.data['status'];
        if (status.contains("payment_success")) {
          var cubit = AppCubit.get(context);
          var decodeCustomer = jsonDecode(event.data['customer']!);
          var decodeDetails = jsonDecode(event.data['task_details']!);
          var taskId = decodeDetails!['id'].toString();
          // print("ddddddddddddd->${decodeCustomer['profile']}");
          // print("fffffffffff->${decodeDetails['time']}");
          var customerData = CustomerData(
            id: decodeCustomer!['id'].toString(),
            email: decodeCustomer!['email'],
            profile: decodeCustomer!['profile'],
            username: decodeCustomer!['username'],
            location: decodeCustomer!['location'],
            rate: decodeCustomer!['rate'],
            mobile: decodeCustomer!['mobile'].toString(),
            lat: decodeCustomer!['lat'].toString(),
            long: decodeCustomer!['long'].toString(),
          );
          cubit.getTaskDetails(taskId).then(
            (value) {
              cubit.changePaymentExpand(context);
              goTo(
                  context,
                  ConfirmPayScreen(
                    taskId: taskId,
                    customerData: customerData,
                  ));
              // confirmPaymentNotificationBody = "";
            },
          );
        }

        if (status.contains("payment_refuse")) {
          var cubit = AppCubit.get(context);
          cubit.tasksModel!.tasks = null;
          cubit.resetPolyline();
          cubit.googleMapController!.dispose();
          cubit.taskCustomerData = [];
          cubit.taskDetails = [];
          // cubit.currentPage = 1;
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(),
              ),
              (route) => true,
            );
          });
        }

        // showFlutterToast(message: "onMessage", backgroundColor: Colors.green);
      });

  static void onAppOpenedConfirmPayNotification(BuildContext context) =>
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print("onMessageOpenedApp-->${event.notification!.body}");
        print("goto onMessageOpenedApp");
        var status = event.data['status'];
        if (status.contains("payment_success")) {
          var cubit = AppCubit.get(context);
          var decodeCustomer = jsonDecode(event.data['customer']!);
          var decodeDetails = jsonDecode(event.data['task_details']!);
          var taskId = decodeDetails!['id'].toString();
          // print("ddddddddddddd->${decodeCustomer['profile']}");
          // print("fffffffffff->${decodeDetails['time']}");
          var customerData = CustomerData(
            id: decodeCustomer!['id'].toString(),
            email: decodeCustomer!['email'],
            profile: decodeCustomer!['profile'],
            username: decodeCustomer!['username'],
            location: decodeCustomer!['location'],
            rate: decodeCustomer!['rate'],
            mobile: decodeCustomer!['mobile'].toString(),
            lat: decodeCustomer!['lat'].toString(),
            long: decodeCustomer!['long'].toString(),
          );
          cubit.getTaskDetails(taskId).then(
            (value) {
              cubit.changePaymentExpand(context);
              goTo(
                  context,
                  ConfirmPayScreen(
                    taskId: taskId,
                    customerData: customerData,
                  ));
              // confirmPaymentNotificationBody = "";
            },
          );
        }
        if (status.contains("payment_refuse")) {
          var cubit = AppCubit.get(context);
          cubit.tasksModel!.tasks = null;
          cubit.resetPolyline();
          cubit.googleMapController!.dispose();
          cubit.taskCustomerData = [];
          cubit.taskDetails = [];
          // cubit.currentPage = 1;
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(),
              ),
              (route) => true,
            );
          });
        }
        // showFlutterToast(
        // message: "onMessageOpenedApp", backgroundColor: Colors.green);
      });

  static void onBackGroundConfirmPayNotification(BuildContext context) async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("goto onBackgroundMessage");
      print("onBackgroundMessage-->${message.notification!.body}");
      var status = message.data['status'];
      if (status.contains("payment_success")) {
        var cubit = AppCubit.get(context);
        var decodeCustomer = jsonDecode(message.data['customer']!);
        var decodeDetails = jsonDecode(message.data['task_details']!);
        var taskId = decodeDetails!['id'].toString();
        // print("ddddddddddddd->${decodeCustomer['profile']}");
        // print("fffffffffff->${decodeDetails['time']}");
        var customerData = CustomerData(
          id: decodeCustomer!['id'].toString(),
          email: decodeCustomer!['email'],
          profile: decodeCustomer!['profile'],
          username: decodeCustomer!['username'],
          location: decodeCustomer!['location'],
          rate: decodeCustomer!['rate'],
          mobile: decodeCustomer!['mobile'].toString(),
          lat: decodeCustomer!['lat'].toString(),
          long: decodeCustomer!['long'].toString(),
        );
        cubit.getTaskDetails(taskId).then(
          (value) {
            cubit.changePaymentExpand(context);
            goTo(
                context,
                ConfirmPayScreen(
                  taskId: taskId,
                  customerData: customerData,
                ));
            // confirmPaymentNotificationBody = "";
          },
        );
      }
      if (status.contains("payment_refuse")) {
        var cubit = AppCubit.get(context);
        cubit.tasksModel!.tasks = null;
        cubit.resetPolyline();
        cubit.googleMapController!.dispose();
        cubit.taskCustomerData = [];
        cubit.taskDetails = [];

        SchedulerBinding.instance!.addPostFrameCallback((_) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(),
            ),
            (route) => true,
          );
        });
      }
    });
  }

  /// end ConfirmPayNotification
  ///
  ///
  /// start Notification CancelTask

  static void onMessagesNotificationCancelTask(BuildContext context) =>
      FirebaseMessaging.onMessage.listen((event) {
        print("onMessage-->${event.notification!.body}");
        print("onMessage-->new ---> ${event.data['status']}");

        print("goto onMessage");
        var status = event.data['status'];
        print("onMessage-->new status ---> $status}");
        if (status?.contains("cancel_task")) {
          var cubit = AppCubit.get(context);
          cubit.tasksModel!.tasks = null;
          cubit.resetPolyline();
          cubit.googleMapController?.dispose();
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(),
              ),
              (route) => true,
            );
          });
        }

        // showFlutterToast(message: "onMessage", backgroundColor: Colors.green);
      });

  static void onAppOpenedNotificationCancelTask(BuildContext context) =>
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print("onMessageOpenedApp-->${event.notification!.body}");
        print("goto onMessageOpenedApp");
        var status = event.data['status'];
        if (status.contains("cancel_task")) {
          var cubit = AppCubit.get(context);
          cubit.tasksModel!.tasks = null;
          cubit.resetPolyline();
          cubit.googleMapController!.dispose();
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(),
              ),
              (route) => true,
            );
          });
        }
        // showFlutterToast(
        // message: "onMessageOpenedApp", backgroundColor: Colors.green);
      });

  static void onBackGroundNotificationCancelTask(BuildContext context) async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("goto onBackgroundMessage");
      print("onBackgroundMessage-->${message.notification!.body}");
      var status = message.data['status'];
      if (status.contains("cancel_task")) {
        var cubit = AppCubit.get(context);
        cubit.tasksModel!.tasks = null;
        cubit.resetPolyline();
        cubit.googleMapController!.dispose();
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(),
            ),
            (route) => true,
          );
        });
      }
      // return showFlutterToast(
      // message: "onBackgroundMessage", backgroundColor: Colors.green);
    });
  }

  /// end Notification CancelTask

}
