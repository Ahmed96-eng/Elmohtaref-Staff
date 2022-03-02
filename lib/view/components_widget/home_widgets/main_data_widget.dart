import 'package:flutter/material.dart';
import 'package:mohtaref/model/statics_model.dart';
import 'package:mohtaref/view/components_widget/home_widgets/info_widget.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:get/get.dart';
import '../../../constant.dart';

class MainDataWidget extends StatelessWidget {
  const MainDataWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.staticsData,
    this.goOnTap,
    this.stopOnTap,
  }) : super(key: key);

  final double width;
  final double height;
  final GestureTapCallback? goOnTap;
  final GestureTapCallback? stopOnTap;
  final StaticsData? staticsData;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          InkWell(
            onTap: goOnTap,
            child: CircleAvatar(
              radius: width * 0.13,
              backgroundColor: redColor,
              child: CircleAvatar(
                radius: width * 0.115,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: width * 0.11,
                  backgroundColor: redColor,
                  child: Text(
                    "go".tr,
                    style: fourthLineStyle,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.05),
                  topRight: Radius.circular(width * 0.05)),
              color: Colors.white,
            ),
            width: width,
            height: height * 0.3,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: stopOnTap,
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
                      Text(
                        "online".tr,
                        style: thirdLineStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InfoWidget(
                        icon: Icons.check_circle_outline,
                        persentage:
                            "${double.parse(staticsData!.acceptPercentage!).toStringAsFixed(2)}" +
                                " " +
                                "%",
                        title: "acceptance".tr,
                      ),
                      InfoWidget(
                        icon: Icons.star_rate_outlined,
                        persentage:
                            "${double.parse(staticsData!.rate!).toStringAsFixed(2)}",
                        title: "rating".tr,
                      ),
                      InfoWidget(
                        icon: Icons.cancel_presentation_outlined,
                        persentage:
                            "${double.parse(staticsData!.cancelledPercentage!).toStringAsFixed(2)}" +
                                " " +
                                "%",
                        title: "cancellation".tr,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
