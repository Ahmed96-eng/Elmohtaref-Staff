import 'package:flutter/material.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:get/get.dart';
import '../../../constant.dart';

class OfflineDataWidget extends StatelessWidget {
  const OfflineDataWidget({
    Key? key,
    required this.height,
    required this.width,
    this.confirmTap,
  }) : super(key: key);

  final double height;
  final double width;
  final VoidCallback? confirmTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Column(
          children: [
            InkWell(
              onTap: confirmTap,
              // onTap: () {
              //   homeCubit
              //       .onlineStatus(
              //         stauts: "1",
              //         servicesId:
              //             homeCubit.profilModel!.data!.serviceId,
              //         lat: (currentPosition!.latitude).toString(),
              //         long:
              //             (currentPosition!.longitude).toString(),
              //       )
              //       .then(
              //         (value) => homeCubit.changeOnlineExpand(
              //             _scaffoldKey.currentContext!),
              //       );
              // },

              child: Container(
                margin:
                    EdgeInsets.only(bottom: height * 0.04, left: width * 0.05),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: width * 0.005, color: mainColor!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.5, 1.0), //(x,y)
                      blurRadius: 9.0,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: width * 0.12,
                  backgroundColor: redColor,
                  child: Text(
                    "start".tr,
                    style: fourthLineStyle,
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     showDialog(
            //       context: context,
            //       builder: (context) {
            //         return AlertDialog(
            //           content: ListView(
            //             children: [
            //               Center(
            //                   child: Text(
            //                 "my_cash".tr,
            //                 style: fifthLineStyle,
            //               )),
            //               SizedBox(
            //                 height: height * 0.02,
            //               ),
            //               BoxWidget(
            //                 width: width,
            //                 height: height,
            //               ),
            //               Padding(
            //                 padding: EdgeInsets.all(width * 0.01),
            //                 child: Divider(),
            //               ),
            //               Center(
            //                   child: Text(
            //                 "part_price".tr,
            //                 style: fifthLineStyle,
            //               )),
            //               SizedBox(
            //                 height: height * 0.02,
            //               ),
            //               BoxWidget(width: width, height: height),
            //               SizedBox(
            //                 height: height * 0.01,
            //               ),
            //               Center(
            //                   child: Text(
            //                 "app_percent".tr,
            //                 style: fifthLineStyle,
            //               )),
            //               SizedBox(
            //                 height: height * 0.02,
            //               ),
            //               BoxWidget(width: width, height: height),
            //               SizedBox(
            //                 height: height * 0.03,
            //               ),
            //               CommonButton(
            //                   text: "all_task".tr,
            //                   width: width * 0.6,
            //                   borderColor: redColor,
            //                   textColor: redColor,
            //                   onTap: () {
            //                     goTo(
            //                         context,
            //                         Ratings(
            //                           isOrderOnly: true,
            //                         ));
            //                   }),
            //               SizedBox(
            //                 height: height * 0.03,
            //               ),
            //               CommonButton(
            //                 width: width * 0.6,
            //                 text: "confirm".tr,
            //                 textColor: mainColor,
            //                 containerColor: redColor,
            //                 onTap: confirmTap,
            //               ),
            //             ],
            //           ),
            //         );
            //       },
            //     );
            //   },
            //   child: Container(
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
            //       radius: width * 0.13,
            //       backgroundColor: mainColor,
            //       child: CircleAvatar(
            //         radius: width * 0.115,
            //         backgroundColor: redColor,
            //         child: CircleAvatar(
            //           radius: width * 0.11,
            //           backgroundColor: mainColor,
            //           child: Text(
            //             "stop".tr,
            //             style: fifthLineStyle,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

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
              height: height * 0.15,
              child: Center(
                child: Text(
                  "offline".tr,
                  style: thirdLineStyle,
                ),
              ),
            ),
          ],
        ));
  }
}
