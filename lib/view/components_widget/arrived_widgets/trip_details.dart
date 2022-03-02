import 'package:flutter/material.dart';
import 'package:mohtaref/model/tasks_model.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant.dart';

class TripDetails extends StatelessWidget {
  const TripDetails({
    Key? key,
    required this.width,
    required this.height,
    required this.customerData,
    required this.taskDetails,
    // this.onTapDialogYes,
    // this.onTapDialogNo,
    this.onTap,
  }) : super(key: key);

  final double width;
  final double height;
  final CustomerData? customerData;
  final TaskDetails? taskDetails;
  final VoidCallback? onTap;
  // final VoidCallback? onTapDialogYes;
  // final VoidCallback? onTapDialogNo;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Container(
        width: width,
        height: height * 0.3,
        color: mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(top: height * 0.01),
              leading: IconButton(
                icon: Icon(Icons.phone),
                onPressed: () async {
                  String phoneNumber = customerData!.mobile!;
                  // another solution
                  // String phoneNumber = Uri.encodeComponent('0114919223');
                  await canLaunch("tel:$phoneNumber")
                      ? launch("tel:$phoneNumber")
                      : showFlutterToast(message: "call_faild".tr);
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(taskDetails!.time!),
                  CircleAvatar(
                    radius: width * 0.08,
                  ),
                  Text(taskDetails!.distance!),
                ],
              ),
              // subtitle: Text("arrived_jone"),
            ),
            Text(
              // "arrived_jone".tr,
              "arrived".tr + " " + "to".tr + " " + "${customerData!.username!}",
              style: labelStyleMinBlack,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Divider(),
            ),
            CommonButton(
                width: width * 0.85,
                height: height * 0.08,
                containerColor: redColor,
                textColor: mainColor,
                text: "complete".tr,
                onTap: onTap),
            SizedBox(
              height: height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
