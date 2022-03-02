import 'package:flutter/material.dart';

import 'clock.dart';
import 'clock_text.dart';

class AppClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Clock(
              circleColor: Colors.black,
              showBellsAndLegs: false,
              bellColor: Colors.green,
              clockText: ClockText.arabic,
              showHourHandleHeartShape: false,
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              // alignment: AlignmentDirectional.center,
              height: 120,
              color: Colors.amber,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              width: double.infinity,
              child: CustomPaint(
                foregroundPainter: GraphPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  //the one in the foreground
  Paint trackBarPaint = Paint()
    ..color = Color(0xff818aab)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 12;

  //the one in the background
  Paint trackPaint = Paint()
    ..color = Color(0xffdee6f1)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 16;

  @override
  void paint(Canvas canvas, Size size) {
    List val = [
      85.0, 50.0, 60.0, 10.0,
      70.0, 40.0, 20.0,
      // size.height * 0.8,
      // size.height * 0.5,
      // size.height * 0.7,
      // size.height * 0.8,
      // size.height * 0.3,
      // size.height * 0.4,
      // size.height * 0.2,
    ];
    double origin = 16;

    Path trackBarPath = Path();
    Path trackPath = Path();

    for (int i = 0; i < val.length; i++) {
      trackPath.moveTo(origin, size.height);
      trackPath.lineTo(origin, 0);

      trackBarPath.moveTo(origin, size.height);
      trackBarPath.lineTo(origin, val[i]);

      origin = origin + size.width * 0.15;
    }

    canvas.drawPath(trackPath, trackPaint);
    canvas.drawPath(trackBarPath, trackBarPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    //  implement shouldRepaint

    return false;
  }
}
