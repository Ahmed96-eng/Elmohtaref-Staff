import 'package:flutter/material.dart';

class ProfileInfoWidget extends StatelessWidget {
  final String? value;

  final String? title;
  final IconData? icon;
  final bool? showIcon;
  final double? width;
  final double? height;
  const ProfileInfoWidget(
      {Key? key,
      this.value,
      this.title,
      this.icon,
      this.showIcon = false,
      this.width,
      this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(
          width: width! * 0.003,
          color: Colors.black12,
        ),
        right: BorderSide(
          width: width! * 0.003,
          color: Colors.black12,
        ),
        top: BorderSide(
          width: width! * 0.003,
          color: Colors.black12,
        ),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value!),
              SizedBox(
                width: width! * 0.01,
              ),
              showIcon!
                  ? Icon(
                      icon,
                      color: Colors.amber,
                      size: width! * 0.05,
                    )
                  : Container(),
            ],
          ),
          Text(title!),
          SizedBox(
            height: height! * 0.01,
          ),
        ],
      ),
    ));
  }
}
