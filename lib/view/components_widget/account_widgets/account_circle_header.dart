import 'package:flutter/material.dart';
import 'package:mohtaref/view/components_widget/cached_network_Image_widget.dart';
import 'package:mohtaref/view/components_widget/style.dart';

import '../../../constant.dart';

class AccountCircleHeader extends StatelessWidget {
  const AccountCircleHeader({
    Key? key,
    required this.width,
    required this.height,
    this.image = "",
    this.title = "",
    this.rating = 1,
    this.isStack = false,
    this.isIcon = false,
    this.iconData,
  }) : super(key: key);

  final double width;
  final double height;
  final String image;
  final String title;
  final double? rating;
  final bool isStack;
  final bool isIcon;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(bottom: height * 0.05),
      child: GridTile(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            // CircleAvatar(
            //   radius: width,
            //   // backgroundColor: mainColor,
            //   backgroundImage: AssetImage(image),
            // ),
            Container(
              width: width,
              height: height / 2,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: mainColor),
              child: isStack
                  ? ClipOval(
                      child: CachedNetworkImageWidget(
                        // height: height / 2,
                        image: image,
                      ),
                    )
                  // CircleAvatar(
                  //     backgroundImage: NetworkImage(
                  //       "https://el-mohtaref.com/$image",
                  //     ),
                  //   )
                  : isIcon
                      ? Icon(
                          iconData,
                          size: width * 0.6,
                          color: redColor,
                        )
                      : Image.asset(
                          image,
                          fit: BoxFit.fitWidth,
                        ),
            ),
            isStack
                ? Container(
                    margin: EdgeInsets.only(top: height * 0.4),
                    height: height * 0.15,
                    width: width * 0.55,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(width * 0.1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            double.parse(rating.toString()).toStringAsFixed(2)),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: width * 0.15,
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
        footer: Padding(
          padding: EdgeInsets.only(
            bottom: height * 0.02,
          ),
          child: Container(
              width: width,
              child: Text(
                title,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: firstLineStyle,
              )),
        ),
      ),
    );
  }
}
