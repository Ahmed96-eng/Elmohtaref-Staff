import 'package:flutter/material.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:get/get.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    Key? key,
    required this.width,
    required this.height,
    this.balance = "0.0",
  }) : super(key: key);

  final double width;
  final double height;
  final String balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.1),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ]),
      width: width * 0.4,
      height: height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            balance,
            style: thirdLineStyle,
          ),
          SizedBox(
            width: width * 0.01,
          ),
          Text(
            "sar".tr,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
