import 'package:flutter/material.dart';
import 'package:mohtaref/view/components_widget/style.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // margin: EdgeInsets.symmetric(
                  //   horizontal: width * 0.06,
                  //   vertical: height * 0.005,
                  // ),
                  child: Image.asset(
                    "asset/images/main_logo.png",
                    fit: BoxFit.fill,
                    width: width / 2,
                    height: height / 2,
                  ),
                ),
                // Icon(
                //   Icons.not_interested_sharp,
                //   size: width * 0.3,
                //   color: mainColor,
                // ),
                // Text(
                //   "No Data",
                //   style: secondLineStyle,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
