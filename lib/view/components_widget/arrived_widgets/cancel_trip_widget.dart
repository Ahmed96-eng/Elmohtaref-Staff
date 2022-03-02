import 'package:flutter/material.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:get/get.dart';
import '../../../constant.dart';

class CancelTaskWidget extends StatelessWidget {
  const CancelTaskWidget({
    Key? key,
    required this.width,
    required this.height,
    this.onTapYes,
    this.onTapNo,
  }) : super(key: key);

  final double width;
  final double height;
  final VoidCallback? onTapYes;
  final VoidCallback? onTapNo;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        width: width,
        height: height * 0.35,
        color: mainColor,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.02),
              child: Text(
                "cancel".tr + " " + "task name",
                style: labelStyleMinBlack,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.01),
              child: Divider(),
            ),
            CommonButton(
              width: width * 0.85,
              height: height * 0.08,
              containerColor: redColor,
              textColor: mainColor,
              text: "yes".tr,
              onTap: onTapYes,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            CommonButton(
              width: width * 0.85,
              height: height * 0.08,
              containerColor: mainColor,
              borderColor: redColor,
              textColor: redColor,
              text: "no".tr,
              onTap: onTapNo,
            ),
            SizedBox(
              height: height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
