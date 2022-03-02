// // // import 'package:flutter/material.dart';

// // // class TextChart extends StatefulWidget {
// // //   @override
// // //   _TextChartState createState() => _TextChartState();
// // // }

// // // class _TextChartState extends State<TextChart> {
// // //   int _currentPage = 0;

// // //   final _controller = PageController(initialPage: 0);
// // //   final _duration = Duration(milliseconds: 300);
// // //   final _curve = Curves.easeInOutCubic;
// // //   final _pages = [
// // //     // LineChartPage(),
// // //     // BarChartPage(),
// // //     // BarChartPage2(),
// // //     // PieChartPage(),
// // //     // LineChartPage2(),
// // //     // LineChartPage3(),
// // //     // LineChartPage4(),
// // //     // BarChartPage3(),
// // //     // ScatterChartPage(),
// // //     // RadarChartPage(),
// // //   ];

// // //   // bool get isDesktopOrWeb => PlatformInfo().isDesktopOS() || PlatformInfo().isWeb();

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _controller.addListener(() {
// // //       setState(() {
// // //         _currentPage = _controller.page!.round();
// // //       });
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: SafeArea(
// // //         child: PageView(
// // //           physics: NeverScrollableScrollPhysics(),
// // //           controller: _controller,
// // //           children: [],
// // //         ),
// // //       ),
// // //       bottomNavigationBar: Container(
// // //         padding: EdgeInsets.all(16),
// // //         color: Colors.transparent,
// // //         child: Row(
// // //           mainAxisSize: MainAxisSize.max,
// // //           children: [
// // //             Visibility(
// // //               visible: _currentPage != 0,
// // //               child: FloatingActionButton(
// // //                 onPressed: () => _controller.previousPage(
// // //                     duration: _duration, curve: _curve),
// // //                 child: Icon(Icons.chevron_left_rounded),
// // //               ),
// // //             ),
// // //             Spacer(),
// // //             Visibility(
// // //               visible: _currentPage != _pages.length - 1,
// // //               child: FloatingActionButton(
// // //                 onPressed: () =>
// // //                     _controller.nextPage(duration: _duration, curve: _curve),
// // //                 child: Icon(Icons.chevron_right_rounded),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:mohtaref/view/components_widget/style.dart';

// // class DashboardScreen extends StatefulWidget {
// //   @override
// //   _DashboardState createState() => _DashboardState();
// // }

// // class _DashboardState extends State<DashboardScreen> {
// //   final Geolocator geolocator = Geolocator();
// //   Position? _currentPosition;
// //   String? _currentAddress;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _getCurrentLocation();
// //   }

// //   _getCurrentLocation() {
// //     Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
// //         .then((Position position) {
// //       setState(() {
// //         _currentPosition = position;
// //       });
// //       print("cccccccccccc" + "$_currentPosition");

// //       _getAddressFromLatLng();
// //       print("zzzzzzzzzzzz" + "$_currentPosition");
// //     }).catchError((e) {
// //       print(e);
// //     });
// //   }

// //   _getAddressFromLatLng() async {
// //     try {
// //       print("start");
// //       List<Placemark> placemarks = await placemarkFromCoordinates(
// //           _currentPosition!.latitude, _currentPosition!.longitude);
// //       // List<Placemark> placemarks =
// //       //     await placemarkFromCoordinates(52.2165157, 6.9437819);
// //       Placemark place = placemarks[0];
// //       print("start1");
// //       print(place.street);
// //       print(place.administrativeArea);
// //       print(place.subAdministrativeArea);
// //       print(place.country);
// //       print(place.name);
// //       print(place.locality);
// //       print(place.subLocality);
// //       print(place.isoCountryCode);
// //       print(place.postalCode);
// //       print(place.subThoroughfare);
// //       print(place.thoroughfare);

// //       setState(() {
// //         _currentAddress =
// //             "${place.street},${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
// //       });
// //       return print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx " + "$_currentAddress");
// //     } catch (e) {
// //       print(e);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("DASHBOARD"),
// //         actions: [
// //           TextButton(
// //               onPressed: () {
// //                 _getAddressFromLatLng();
// //               },
// //               child: Text("data"))
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             Container(
// //                 decoration: BoxDecoration(
// //                   color: Theme.of(context).canvasColor,
// //                 ),
// //                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //                 child: Column(
// //                   children: <Widget>[
// //                     Row(
// //                       children: <Widget>[
// //                         Icon(Icons.location_on),
// //                         SizedBox(
// //                           width: 8,
// //                         ),
// //                         Expanded(
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: <Widget>[
// //                               Text(
// //                                 'Location',
// //                                 style: Theme.of(context).textTheme.caption,
// //                               ),
// //                               if (_currentPosition != null &&
// //                                   _currentAddress != null)
// //                                 Text(
// //                                   _currentAddress!,
// //                                   style: thirdLineStyle,
// //                                 ),
// //                             ],
// //                           ),
// //                         ),
// //                         SizedBox(
// //                           width: 8,
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ))
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // class Placemark{}

// import 'dart:async';
// import 'dart:math';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:mohtaref/constant.dart';
// // import 'package:example/utils/color_extensions.dart';

// class BarChartSample1 extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => BarChartSample1State();
// }

// class BarChartSample1State extends State<BarChartSample1> {
//   final Color barBackgroundColor = const Color(0xff72d8bf);
//   final Duration animDuration = const Duration(milliseconds: 250);

//   int touchedIndex = -1;

//   // bool isPlaying = false;

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1,
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//         color: const Color(0xff81e5cd),
//         child: Stack(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Container(
//                 margin: EdgeInsets.only(top: 36),
//                 height: 150,
//                 width: double.infinity,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: BarChart(
//                     mainBarData(),
//                     swapAnimationDuration: animDuration,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   BarChartGroupData makeGroupData(
//     int x,
//     double y, {
//     bool isTouched = false,
//     Color barColor = Colors.white,
//     double width = 22,
//     List<int> showTooltips = const [],
//   }) {
//     return BarChartGroupData(
//       x: x,
//       barRods: [
//         BarChartRodData(
//           y: isTouched ? y + 1 : y,
//           colors: isTouched ? [redColor!] : [barColor],
//           width: width,
//           borderSide: isTouched
//               ? BorderSide(color: redColor!, width: 1)
//               : BorderSide(color: Colors.white, width: 0),
//           backDrawRodData: BackgroundBarChartRodData(
//             show: true,
//             y: 15,
//             colors: [barBackgroundColor],
//           ),
//         ),
//       ],
//       showingTooltipIndicators: showTooltips,
//     );
//   }

//   List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
//         switch (i) {
//           case 0:
//             return makeGroupData(0, 2, isTouched: i == touchedIndex);
//           case 1:
//             return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
//           case 2:
//             return makeGroupData(2, 5, isTouched: i == touchedIndex);
//           case 3:
//             return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
//           case 4:
//             return makeGroupData(4, 9, isTouched: i == touchedIndex);
//           case 5:
//             return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
//           case 6:
//             return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
//           default:
//             return throw Error();
//         }
//       });

//   BarChartData mainBarData() {
//     return BarChartData(
//       barTouchData: BarTouchData(
//         touchTooltipData: BarTouchTooltipData(
//             tooltipBgColor: Colors.blueGrey,
//             getTooltipItem: (group, groupIndex, rod, rodIndex) {
//               String weekDay;
//               switch (group.x.toInt()) {
//                 case 0:
//                   weekDay = 'Saturday';
//                   break;
//                 case 1:
//                   weekDay = 'Sunday';
//                   break;
//                 case 2:
//                   weekDay = 'Monday';
//                   break;
//                 case 3:
//                   weekDay = 'Tuesday';
//                   break;
//                 case 4:
//                   weekDay = 'Wednesday';
//                   break;
//                 case 5:
//                   weekDay = 'Thursday';
//                   break;
//                 case 6:
//                   weekDay = 'Friday';
//                   break;
//                 default:
//                   throw Error();
//               }
//               return BarTooltipItem(
//                 weekDay + '\n',
//                 TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//                 children: <TextSpan>[
//                   /// change rod by data from api
//                   TextSpan(
//                     text: (rod.y - 1).toString(),
//                     style: TextStyle(
//                       // color: Colors.yellow,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               );
//             }),
//         touchCallback: (FlTouchEvent event, barTouchResponse) {
//           setState(() {
//             if (!event.isInterestedForInteractions ||
//                 barTouchResponse == null ||
//                 barTouchResponse.spot == null) {
//               touchedIndex = -1;
//               return;
//             }
//             touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
//           });
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: SideTitles(showTitles: false),
//         topTitles: SideTitles(showTitles: false),
//         leftTitles: SideTitles(showTitles: false),
//         bottomTitles: SideTitles(
//           showTitles: true,
//           getTextStyles: (context, value) => const TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
//           margin: 16,
//           getTitles: (double value) {
//             switch (value.toInt()) {
//               case 0:
//                 return 'S';
//               case 1:
//                 return 'S';
//               case 2:
//                 return 'M';
//               case 3:
//                 return 'T';
//               case 4:
//                 return 'W';
//               case 5:
//                 return 'T';
//               case 6:
//                 return 'F';
//               default:
//                 return '';
//             }
//           },
//         ),
//       ),
//       borderData: FlBorderData(
//         show: false,
//       ),
//       barGroups: showingGroups(),
//       gridData: FlGridData(show: false),
//     );
//   }
// }
