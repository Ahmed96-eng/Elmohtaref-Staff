import 'package:flutter/material.dart';

class AccountBoxWidget extends StatelessWidget {
  final String? value;
  final String? title;
  final double? width;
  final double? height;

  const AccountBoxWidget(
      {Key? key, this.value, this.title, this.width, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // width: width! / 3,
        height: height! * 0.1,
        padding: EdgeInsets.all(width! * 0.02),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: width! * 0.002,
            color: Colors.black12,
          ),
          left: BorderSide(
            width: width! * 0.002,
            color: Colors.black12,
          ),
          right: BorderSide(
            width: width! * 0.002,
            color: Colors.black12,
          ),
          top: BorderSide(
            width: width! * 0.002,
            color: Colors.black12,
          ),
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(value!),
            Text(title!),
          ],
        ),
      ),
    );
  }
}
