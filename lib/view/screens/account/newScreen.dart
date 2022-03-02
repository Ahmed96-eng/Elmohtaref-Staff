// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mohtaref/controller/cubit/App_cubit.dart';
// import 'package:mohtaref/controller/cubit_states/app_states.dart';
// import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';

// class NewScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveBuilder(builder: (context, sizeConfig) {
//       final height = sizeConfig.screenHeight!;
//       final width = sizeConfig.screenWidth!;
//       return BlocConsumer<AppCubit, AppState>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             // var cubit = AppCubit.get(context);
//             return Scaffold(
//               body: Padding(
//                 padding: const EdgeInsets.all(30.0),
//                 child: ListView(
//                   children: [
//                     ClipPath(
//                       child: Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: 200,
//                         color: Colors.blue,
//                       ),
//                       clipper: CustomClipPath(),
//                     ),
//                     ClipPath(
//                       child: Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: 200,
//                         color: Colors.blue,
//                       ),
//                       clipper: CustomClipPath(),
//                     ),
//                     ClipPath(
//                       child: Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: 200,
//                         color: Colors.blue,
//                       ),
//                       clipper: CustomClipPath(),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           });
//     });
//   }
// }

// class CustomClipPath extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();

//     path.lineTo(0, size.height);

//     // path.quadraticBezierTo(
//     //     size.width / 2, size.height, size.width / 7, size.height);
//     // path.quadraticBezierTo(
//     //     size.width - 100, size.height / 2, size.width + 100, size.height - 100);
//     path.cubicTo(150, 100, 70, 90, 20, 10);
//     path.lineTo(size.width, 0);

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mohtaref/constant.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';

class AnimateCamera extends StatefulWidget {
  const AnimateCamera();
  @override
  State createState() => AnimateCameraState();
}

class AnimateCameraState extends State<AnimateCamera> {
  GoogleMapController? mapController;
  @override
  void initState() {
    AppCubit.get(context).getCurrentPosition();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(target: LatLng(0.0, 0.0)),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    mapController?.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          bearing: 270.0,
                          target: LatLng(currentPosition!.latitude,
                              currentPosition!.longitude),
                          tilt: 30.0,
                          zoom: 17.0,
                        ),
                      ),
                    );
                  },
                  child: const Text('newCameraPosition'),
                ),
                TextButton(
                  onPressed: () {
                    mapController?.animateCamera(
                      CameraUpdate.newLatLng(
                        const LatLng(56.1725505, 10.1850512),
                      ),
                    );
                  },
                  child: const Text('newLatLng'),
                ),
                TextButton(
                  onPressed: () {
                    mapController?.animateCamera(
                      CameraUpdate.newLatLngBounds(
                        LatLngBounds(
                          southwest: LatLng(currentPosition!.latitude,
                              currentPosition!.longitude),
                          northeast: LatLng(currentPosition!.latitude + 1,
                              currentPosition!.longitude + 1),
                        ),
                        10.0,
                      ),
                    );
                  },
                  child: const Text('newLatLngBounds'),
                ),
                TextButton(
                  onPressed: () {
                    mapController?.animateCamera(
                      CameraUpdate.newLatLngZoom(
                        LatLng(currentPosition!.latitude,
                            currentPosition!.longitude),
                        11.0,
                      ),
                    );
                  },
                  child: const Text('newLatLngZoom'),
                ),
                TextButton(
                  onPressed: () {
                    mapController?.animateCamera(
                      CameraUpdate.scrollBy(150.0, -225.0),
                    );
                  },
                  child: const Text('scrollBy'),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    mapController?.animateCamera(
                      CameraUpdate.zoomBy(
                        -0.5,
                        const Offset(30.0, 20.0),
                      ),
                    );
                  },
                  child: const Text('zoomBy with focus'),
                ),
                TextButton(
                  onPressed: () {
                    mapController?.animateCamera(
                      CameraUpdate.zoomBy(-0.5),
                    );
                  },
                  child: const Text('zoomBy'),
                ),
                TextButton(
                  onPressed: () {
                    mapController?.animateCamera(
                      CameraUpdate.zoomIn(),
                    );
                  },
                  child: const Text('zoomIn'),
                ),
                TextButton(
                  onPressed: () {
                    mapController?.animateCamera(
                      CameraUpdate.zoomOut(),
                    );
                  },
                  child: const Text('zoomOut'),
                ),
                TextButton(
                  onPressed: () {
                    mapController?.animateCamera(
                      CameraUpdate.zoomTo(16.0),
                    );
                  },
                  child: const Text('zoomTo'),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
