import 'package:flutter/material.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import '../../../constant.dart';

class InfoWidget extends StatelessWidget {
  final IconData? icon;
  final String? persentage;
  final String? title;

  const InfoWidget({Key? key, this.icon, this.persentage, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(
          width: 1,
          color: Colors.black12,
        ),
        top: BorderSide(
          width: 1,
          color: Colors.black12,
        ),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            icon,
            color: redColor,
          ),
          Text(
            persentage!,
            style: lineStyleSmallBlack,
          ),
          Text(title!),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    ));
  }
}
