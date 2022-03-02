import 'dart:async';
// import 'dart:convert' as convert;
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohtaref/controller/api_dio_helper/dio_helper.dart';
import 'package:mohtaref/controller/api_dio_helper/endpoint_dio.dart';
import 'package:mohtaref/controller/cached_helper/cached_helper.dart';
import 'package:mohtaref/controller/cached_helper/key_constant.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mohtaref/model/Weekly_wallet_model.dart';
import 'package:mohtaref/model/messsage_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mohtaref/model/profile_model.dart';
import 'package:mohtaref/model/statics_model.dart';
import 'package:mohtaref/model/statics_tasks_model.dart';
import 'package:mohtaref/model/stores_model.dart';
import 'package:mohtaref/model/task_details_model.dart';
import 'package:mohtaref/model/tasks_model.dart';
import 'package:mohtaref/model/today_summary_model.dart';
import 'package:mohtaref/model/today_wallet_model.dart';
import 'package:mohtaref/model/weekly_summary_model.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';
import 'package:get/get.dart' as getTranslat;
import 'package:path_provider/path_provider.dart';
import '../../constant.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  onInit() {
    CachedHelper.getData(key: loginTokenId);
  }

  /// start delete cached TemporaryDirectory

  Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
      print("deleteTemporaryDirectory true success");
    }
    // final appDir = await getApplicationSupportDirectory();
    // if (appDir.existsSync()) {
    //   appDir.deleteSync(recursive: true);
    //   print("deleteApplicationSupportDirectory true success");
    // }
  }

  /// end delete cached TemporaryDirectory
  ///
  ///
  /// start home expand functions

  // online expand
  bool onlineExpand = false;
  Future<void> changeOnlineExpand(BuildContext context) async {
    onlineExpand = !onlineExpand;
    emit(ChangeOnlineExpandState());
  }

  // go expand
  bool goExpand = false;
  Future<void> changeGoExpand(BuildContext context) async {
    goExpand = !goExpand;
    emit(ChangeGoExpandState());
  }

  // cancel task expand
  bool cancelTaskExpand = false;
  void changeCancelTaskExpand(BuildContext context) {
    cancelTaskExpand = !cancelTaskExpand;
    emit(ChangeCancelTaskExpandState());
  }

  /// end home expand functions
  ///
  ///
  /// start arrive expand functions

  // store expand
  bool storesExpand = false;
  void changeStoresExpand(BuildContext context) {
    storesExpand = !storesExpand;
    emit(ChangeStoresExpandState());
  }

  // payment expand
  bool paymentExpand = false;
  void changePaymentExpand(BuildContext context) {
    paymentExpand = !paymentExpand;
    emit(ChangePaymentExpandState());
  }

  // listTile expande
  String changeListTileValue = '';
  void changechangeListTileValue(
      BuildContext context, dynamic value, dynamic finalValue) {
    finalValue = value!;
    emit(ChangeListTileValueState());
  }

  // details expand
  bool moreDetails = false;
  Future<void> changeMoreDetails(BuildContext context) async {
    moreDetails = !moreDetails;
    emit(ChangeMoreDetailsState());
  }

  /// end arrive expand functions
  ///
  ///
  ///  START Map functions

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(29.9933611, 31.161301),
    zoom: 14.4746,
  );

  final Completer<GoogleMapController> mapController = Completer();
  GoogleMapController? googleMapController;
  // Position? currentPosition;
  // String? currentAddress;
  String? destinationAddress;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  // map create
  void onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
    mapController.complete(controller);
    mapController.future;
  }

  // get current position
  void getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngCameraPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngCameraPosition, zoom: 14);
    getCurrentAddressFromLatLng(
      curentLatitude: position.latitude,
      curentLongitude: position.longitude,
    );
    // _getAddressFromLatLng();
    print('mmmmmmmmmmmmmaaaaapppps');
    print(currentPosition);
    print(cameraPosition);
    googleMapController = await mapController.future;

    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  // _getAddressFromLatLng({double? destLatitude, double? destLongitude}) async {
  //   try {
  //     print("start");
  //     List<Placemark> originPlacemarks = await placemarkFromCoordinates(
  //         currentPosition!.latitude, currentPosition!.longitude);
  //     List<Placemark> destinationPlacemarks =
  //         await placemarkFromCoordinates(destLatitude!, destLongitude!);
  //     Placemark originPlace = originPlacemarks[0];
  //     Placemark destinationPlace = destinationPlacemarks[0];
  //     print("start1");
  //     currentAddress =
  //         "${originPlace.street},${originPlace.subAdministrativeArea}, ${originPlace.administrativeArea}, ${originPlace.country}";
  //     destinationAddress =
  //         "${destinationPlace.street},${destinationPlace.subAdministrativeArea}, ${destinationPlace.administrativeArea}, ${destinationPlace.country}";
  //     print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx " + "$currentAddress");
  //     print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx " + "$destinationAddress");
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // get current address
  getCurrentAddressFromLatLng(
      {double? curentLatitude, double? curentLongitude}) async {
    List<Placemark> originPlacemarks =
        await placemarkFromCoordinates(curentLatitude!, curentLongitude!);
    Placemark originPlace = originPlacemarks[0];

    currentAddress =
        "${originPlace.street},${originPlace.subAdministrativeArea}, ${originPlace.administrativeArea}, ${originPlace.country}";

    print("cccccccccccccccxxxxxxxxxx-->$currentAddress");
    addMarker(
      LatLng(curentLatitude, curentLongitude),
      "origin",
      BitmapDescriptor.defaultMarker,
      "Address",
      "${currentAddress!}",
    );
    emit(GetCurrentAddressFromLatLngSuccessState());
  }

  // get destination address
  getDestinationAddressFromLatLng(
      {double? destLatitude, double? destLongitude}) async {
    List<Placemark> destinationPlacemarks =
        await placemarkFromCoordinates(destLatitude!, destLongitude!);
    Placemark destinationPlace = destinationPlacemarks[0];

    destinationAddress =
        "${destinationPlace.street},${destinationPlace.subAdministrativeArea}, ${destinationPlace.administrativeArea}, ${destinationPlace.country}";

    print("cccccccccccccccxxxxxxxxxx-->$destinationAddress");

    emit(GetCurrentAddressFromLatLngSuccessState());
  }

  // reset polyline
  Future resetPolyline() async {
    polylineCoordinates.clear();
    markers.clear();
    polylines.clear();

    emit(ResetPolyLineState());
  }

  Future<void> zoomToFit(LatLngBounds bounds, LatLng centerBounds) async {
    bool keepZoomingOut = true;
    while (keepZoomingOut) {
      final LatLngBounds screenBounds =
          await googleMapController!.getVisibleRegion();
      if (fits(bounds, screenBounds)) {
        keepZoomingOut = false;
        final double zoomLevel =
            await googleMapController!.getZoomLevel() - 0.5;
        googleMapController!
            .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
        break;
      } else {
        // Zooming out by 0.1 zoom level per iteration
        final double zoomLevel =
            await googleMapController!.getZoomLevel() - 0.1;
        googleMapController!
            .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
      }
    }
  }

  bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
    final bool northEastLatitudeCheck =
        screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
    final bool northEastLongitudeCheck =
        screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

    final bool southWestLatitudeCheck =
        screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
    final bool southWestLongitudeCheck =
        screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

    return northEastLatitudeCheck &&
        northEastLongitudeCheck &&
        southWestLatitudeCheck &&
        southWestLongitudeCheck;
  }

  // double destLatitude = 30.9933500, destLongitude = 31.1613109;

  // add marker
  addMarker(LatLng position, String id, BitmapDescriptor descriptor,
      String title, String snipped) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
        markerId: markerId,
        icon: descriptor,
        position: position,
        infoWindow: InfoWindow(
          title: title,
          snippet: snipped,
        ));
    markers[markerId] = marker;
  }

  // pick image to map pin
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // origin marker
  orginMarker() async {
    final Uint8List markerIcon =
        await getBytesFromAsset("asset/images/origin_pin.png", 100);
    addMarker(
      LatLng(currentPosition!.latitude, currentPosition!.longitude),
      "origin",
      BitmapDescriptor.fromBytes(markerIcon),
      "origin",
      "${currentAddress!}",
    );
  }

  // distination marker
  destinationMarker({double? destLatitude, double? destLongitude}) async {
    final Uint8List markerIcon =
        await getBytesFromAsset("asset/images/destination_pin.png", 100);
    addMarker(
      LatLng(destLatitude!, destLongitude!),
      "destination",
      // BitmapDescriptor.defaultMarkerWithHue(90),
      BitmapDescriptor.fromBytes(markerIcon),
      "destination",
      "${destinationAddress!}",
    );
  }

  // double? getMarkerRotation() {
  //   dynamic rotation =toolKit. SphericalUtil.computeHeading(
  //  toolKit. LatLng(currentPosition!.latitude, currentPosition!.longitude),
  //   toolKit.  LatLng(destLatitude, destLongitude),
  //   );
  //   return rotation;
  // }

  // add polyline
  addPolyLine({double? destLatitude, double? destLongitude}) async {
    double originlat = currentPosition!.latitude;
    double originlng = currentPosition!.longitude;

    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        width: 5,
        consumeTapEvents: true,
        polylineId: id,
        color: redColor!,
        points: polylineCoordinates);
    polylines[id] = polyline;

    // zoom to current position
    LatLngBounds latLngBounds;
    LatLng destLatLng = LatLng(destLatitude!, destLongitude!);
    LatLng originLatLng = LatLng(originlat, originlng);
    if (originlat > destLatitude && originlng > destLongitude) {
      latLngBounds =
          LatLngBounds(southwest: destLatLng, northeast: originLatLng);
    } else if (originlat > destLatitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(destLatitude, originlng),
          northeast: LatLng(originlat, destLongitude));
    } else if (originlng > destLongitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(originlat, destLongitude),
          northeast: LatLng(destLatitude, originlng));
    } else {
      latLngBounds =
          LatLngBounds(southwest: originLatLng, northeast: destLatLng);
    }

// calculating centre of the bounds
    LatLng centerBounds = LatLng(
        (latLngBounds.northeast.latitude + latLngBounds.southwest.latitude) / 2,
        (latLngBounds.northeast.longitude + latLngBounds.southwest.longitude) /
            2);

// setting map position to centre to start with
    // cubit.googleMapController!
    //     .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //   target: centerBounds,
    //   zoom: 17,
    // )));
    zoomToFit(latLngBounds, centerBounds);
    emit(AddPolyLineState());
  }

  // get polyline
  getPolyline({double? destLatitude, double? destLongitude}) async {
    double originlat = currentPosition!.latitude;
    double originlng = currentPosition!.longitude;
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      mapKey,
      PointLatLng(originlat, originlng),
      PointLatLng(destLatitude!, destLongitude!),
      travelMode: TravelMode.driving,
      avoidFerries: true,
      avoidHighways: true,
      avoidTolls: true,
      optimizeWaypoints: true,
      wayPoints: [
        // PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria"),
      ],
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    addPolyLine(destLatitude: destLatitude, destLongitude: destLongitude);
  }

  ///  END Map functions
  ///
  ///
  /// start timer

  Duration duration = Duration();
  Timer? timer;

  // stop timer
  void stopTimer() {
    duration = Duration();
    timer!.cancel();
    emit(TimerCancelState());
  }

  // end timer
  void startTimer() {
    final addSecond = 1;
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      final seconds = duration.inSeconds + addSecond;
      duration = Duration(seconds: seconds);
      emit(TimerIncressState());
    });

    // const oneSec = const Duration(seconds: 1);
    // Timer timer = Timer.periodic(
    //   oneSec,
    //   (Timer timer) {
    //     // if (start != 0) {
    //     start++;
    //     emit(TimerIncressState());
    //     // } else {
    //     //   timer.cancel();
    //     //   emit(TimerCancelState());
    //     // }
    //   },
    // );
  }

  /// end timer
  ///
  ///
  /// start Notification

  bool notificationToggle = true;
  void changenotificationToggle(
      BuildContext context, bool notificationValue, String topicValue) {
    notificationToggle = notificationValue;
    if (notificationToggle) {
      FirebaseMessaging.instance.subscribeToTopic(topicValue);
      print("subscribeToTopic");
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic(topicValue);
      print("UNsubscribeToTopic");
    }
    emit(ChangeNotificationToggleState());
  }

  /// end NotifiCation
  ///
  ///
  /// START GET PROFILE DATA

  ProfilModel? profilModel;
  Future getProfile() async {
    try {
      emit(GetProfileLoadingState());
      await DioHelper.postData(endpoint: PROFILE, data: {
        "id": mohtarefId,
      }).then(
        (value) {
          // print('11111111111111');
          // print(value.data);
          // print(value);
          // print('22222222222223');
          profilModel = (ProfilModel.fromJson(value.data));
          myEarningAmount = double.parse(value.data["data"]["balance"]);
          CachedHelper.setData(
              key: myEarningKey,
              value: double.parse(value.data["data"]["balance"]));
          emit(GetProfileSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetProfileErrorState());
    }
  }

  /// END GET PROFILE DATA
  ///
  ///
  ///START UPDATE PROFILE

  Future updateProfile({
    String? phone,
    String? secondPhone,
    String? location,
    String? languages,
    File? profileFile,
    File? passportFile,
  }) async {
    try {
      emit(UpdateProfileLoadingState());
      await DioHelper.postData(endpoint: UPDATEPROFILE, data: {
        "id": mohtarefId,
        "mobile": phone,
        "mobile2": secondPhone,
        "location": location,
        "languages": languages,
        "profile": profileFile != null
            ? await MultipartFile.fromFile(profileFile.path,
                contentType: MediaType('image', 'png'),
                filename: profileFile.path.split('/').last)
            : profilModel!.data!.profile,
        "passport": passportFile != null
            ? await MultipartFile.fromFile(passportFile.path,
                contentType: MediaType('image', 'png'),
                filename: passportFile.path.split('/').last)
            : profilModel!.data!.passport,
      }).then(
        (value) {
          print('start updating');
          print(value.data);
          print(value);

          print('end updating');

          // profilModel = (ProfilModel.fromJson(value.data));

          emit(UpdateProfileSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(UpdateProfileErrorState());
    }
  }

  ///END UPDATE PROFILE
  ///
  ///
  /// Start DELETE ACCOUNT

  Future deleteAccount() async {
    try {
      emit(DeleteAccountLoadingState());
      await DioHelper.postData(endpoint: DELETEACCOUNT, data: {
        "id": mohtarefId,
      }).then(
        (value) {
          print('start DELETE ACCOUNT');

          emit(DeleteAccountSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(DeleteAccountErrorState());
    }
  }

  /// End DELETE ACCOUNT
  ///
  ///
  /// START ONLINE , OFFLINE

  Future<void> onlineStatus(
      {String? stauts, servicesId, String? lat, String? long}) async {
    try {
      emit(OnlineStaustLoadingState());
      await DioHelper.postData(endpoint: ONLINE, data: {
        "staff_id": mohtarefId,
        "status": stauts,
        "service_id": servicesId,
        "long": long,
        "lat": lat,
      }).then(
        (value) {
          print('lllllllllllllllll');
          print(value);
          print(currentPosition!.longitude);
          print(currentPosition!.latitude);
          emit(OnlineStaustSuccessState());
          // return value;
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(OnlineStaustErrorState());
    }
  }

  /// END ONLINE , OFFLINE
  ///
  ///
  /// START Cancel Task

  Future cancelTask({String? customerId, String? taskId}) async {
    try {
      emit(CancelTaskLoadingState());

      await DioHelper.postData(endpoint: CANCELTASK, data: {
        "task_id": taskId,
        "customer_id": customerId,
        "state": '',
      }).then(
        (value) {
          print('lllllllllllllllll CANCEL SUCCESS');
          print(value);

          emit(CancelTaskSuccessState());
          // return value;
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(CancelTaskErrorState());
    }
  }

  /// END Cancel Task
  ///
  ///
  /// START CHAT

  // send message
  void sendMassage({
    String? recevierId,
    String? recevierName,
    String? recevierImage,
    String? message,
  }) {
    MessageModel messageModel = MessageModel(
      message: message,
      recevierId: recevierId,
      recevierName: recevierName,
      recevierImage: recevierImage,
      senderId: profilModel!.data!.id ?? mohtarefId,
      senderName: profilModel!.data!.username,
      senderImage: profilModel!.data!.profile,
      timeDate: DateTime.now().toString(),
    );

    FirebaseFirestore.instance
        .collection("chat")
        .doc(profilModel!.data!.id ?? mohtarefId)
        .collection("messages")
        .add(messageModel.toMap())
        .then((value) {
      emit(SendSenderMessageSuccessState());
    }).catchError((error) {
      print('start error');
      print(error);
      print('finish error');
      emit(SendSenderMessageErrorState());
    });

    /// send message to firebase
    FirebaseFirestore.instance
        .collection("chat")
        .doc(recevierId!)
        .collection("messages")
        .add(messageModel.toMap())
        .then((value) async {
      /// send message to backend
      await DioHelper.postData(endpoint: CHAT, data: {
        "from": profilModel!.data!.id ?? mohtarefId,
        "to": recevierId,
        "message": message,
      });
      // getSenderMessages();
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print('start error');
      print(error);
      print('finish error');
      emit(SendMessageErrorState());
    });
  }

  // Get Messages
  List<MessageModel> messages = [];
  void getMessages(String recevierId) {
    FirebaseFirestore.instance
        .collection('chat')
        .doc(recevierId)
        .collection("messages")
        .orderBy('timeDate')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        print("77777777777777");

        // print(element.data());
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessagesSuccessState());
    });
  }

  Future getSenderMessages() async {
    FirebaseFirestore.instance
        .collection('chat')
        .doc(profilModel!.data!.id)
        .collection("messages")
        .orderBy('timeDate')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        print("77777777777777");
        // print(element.data());
        messages.add(MessageModel.fromJson(element.data()));
        emit(GetSenderMessagesSuccessState());
      });
    });
  }

  // Delete chat
  void deleteMessages(String recevierId) async {
    try {
      var collection = FirebaseFirestore.instance
          .collection('chat')
          .doc(recevierId)
          .collection("messages");
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        print("vvvvvvvvvvv${snapshots.docs}");
        await doc.reference.delete();
      }
      emit(DeleteMessagesSuccessState());
    } catch (error) {
      print(error);
      emit(DeleteMessagesErrorState());
    }
  }

  /// END CHAT
  ///
  ///
  /// start change passport image

  final picker = ImagePicker();
  File? passportImage;
  Future getPassportImageSource({required ImageSource imageSource}) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      passportImage = File(pickedFile.path);
      emit(PickedPassportImageSuccessState());
    } else {
      print('no_image_selected'.tr);
      emit(PickedPassportImageErrorState());
    }
  }

  Future getPassportImage(BuildContext context,
      {double? height, double? width}) async {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'picked_image_from'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height! * 0.1,
                  ),
                  CommonButton(
                    text: "camera".tr,
                    textColor: buttonTextColor,
                    containerColor: buttonColor,
                    height: height,
                    width: width!,
                    onTap: () {
                      getPassportImageSource(imageSource: ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: height * 0.15,
                  ),
                  CommonButton(
                    text: "gallery".tr,
                    textColor: buttonTextColor,
                    containerColor: buttonColor,
                    height: height,
                    width: width,
                    onTap: () {
                      getPassportImageSource(imageSource: ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// end change passport image
  ///
  ///
  /// start change profile image

  File? profileImage;
  Future getProfileImageSource({required ImageSource imageSource}) async {
    final pickedFile =
        await picker.pickImage(source: imageSource, imageQuality: 50);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickedProfileImageSuccessState());
    } else {
      print('no_image_selected'.tr);
      emit(PickedProfileImageErrorState());
    }
  }

  Future getProfileImage(BuildContext context,
      {double? height, double? width}) async {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'picked_image_from'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height! * 0.1,
                  ),
                  CommonButton(
                    text: "camera".tr,
                    textColor: buttonTextColor,
                    containerColor: buttonColor,
                    height: height,
                    width: width!,
                    onTap: () {
                      getProfileImageSource(imageSource: ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: height * 0.15,
                  ),
                  CommonButton(
                    text: "gallery".tr,
                    textColor: buttonTextColor,
                    containerColor: buttonColor,
                    height: height,
                    width: width,
                    onTap: () {
                      getProfileImageSource(imageSource: ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// end change profile image
  ///
  ///
  /// Start Get Tasks

  // getTasks() {
  //   try {
  //     emit(GetTasksLoadingState());
  //     DioHelper.postData(endpoint: TASKS, data: {
  //       "lat": 30.0833000,
  //       "long": 31.1213015,
  //       // "offset": 5,
  //     }).then(
  //       (value) {
  //         print('11111111111111---<${value.data}');
  //         // print(value.data);
  //         // print(value);
  //         print('22222222222223---> $value');
  //         tasksModel = (TasksModel.fromJson(value.data));
  //         print('33333333333333---> $tasksModel');
  //         emit(GetTasksSuccessState());
  //       },
  //     ).catchError((error) {
  //       print("ERROR");
  //       print(error.toString());
  //       emit(GetTasksErrorState());
  //     });
  //   } catch (e) {
  //     print(e);
  //     emit(GetTasksErrorState());
  //   }
  // }

  // get tasks with pagination
  TasksModel? tasksModel;
  int currentPage = 1;
  List<TaskDetails>? taskDetails = [];
  List<CustomerData>? taskCustomerData = [];

  Future getTasksPagination(
      {double? lat,
      double? long,
      String? serviceId,
      bool isRefresh = false}) async {
    try {
      emit(GetTasksPaginationLoadingState());
      DioHelper.postData(endpoint: TASKS, data: {
        "lat": lat ?? currentPosition!.latitude,
        "long": long ?? currentPosition!.longitude,
        "service_id": serviceId,
        // "page": currentPage,
      }).then(
        (value) {
          taskCustomerData!.length = 0;
          taskDetails!.length = 0;
          // if (isRefresh) {
          //   print("zzzzzzzzzzzzzzz$isRefresh");
          //   currentPage = 1;
          // }
          print("dddddddddddddd------>$value");

          tasksModel = (TasksModel.fromJson(value.data));

          if (isRefresh) {
            // if (taskCustomerData!.length ==
            //     tasksModel!.tasks!.tasksData!.customerData!.length)
            //   taskCustomerData = [];
            // if (taskDetails![0].id ==
            //     tasksModel!.tasks!.tasksData!.taskDetails![0].id)
            //   taskDetails = [];

            taskDetails =
                tasksModel!.tasks!.tasksData!.taskDetails!.toSet().toList();

            taskCustomerData =
                tasksModel!.tasks!.tasksData!.customerData!.toSet().toList();

            print("TASKSCustomer------>${taskCustomerData!.length}");
            print("TASKSData------>${taskDetails!.length}");
          } else {
            tasksModel!.tasks!.tasksData!.taskDetails!
                .toSet()
                .toList()
                .forEach((element) {
              // if (taskDetails![0].id == element.id) taskDetails = [];
              taskDetails!.add(element);
            });

            // taskDetails!.addAll(
            //     tasksModel!.tasks!.tasksData!.taskDetails!.toSet().toList());

            print("TASKSData------>${taskDetails!.length}");

            tasksModel!.tasks!.tasksData!.customerData!
                .toSet()
                .toList()
                .forEach((element) {
              // if (taskCustomerData![0].id == element.id) taskCustomerData = [];

              taskCustomerData!.add(element);
            });
            // taskCustomerData!.addAll(
            //     tasksModel!.tasks!.tasksData!.customerData!.toSet().toList());

            print("TASKSCustomer------>${taskCustomerData!.length}");
            currentPage++;
          }
          emit(GetTasksPaginationSuccessState());
        },
      );
      return true;
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetTasksPaginationErrorState());
    }
  }

  /// End Get Tasks
  ///
  ///
  /// Start Arrive Notification to Customer

  Future arriveNotificationToCustomer({String? customerId}) async {
    try {
      emit(ArriveNotificationLoadingState());
      await DioHelper.postData(endpoint: ARRIVE, data: {
        "customer_id": customerId,
      }).then(
        (value) {
          print('start Arrive Notification to Customer');

          emit(ArriveNotificationSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(ArriveNotificationErrorState());
    }
  }

  /// End Arrive Notification to Customer
  ///
  ///
  /// start Get Stores

  List<StoresData>? storesList = [];
  StoresModel? storesModel;
  int storeCurrentPage = 1;

  Future getStores({
    bool isRefresh = false,
  }) async {
    try {
      storesList!.length = 0;
      storeCurrentPage = 1;
      emit(GetStoresLoadingState());
      await DioHelper.postData(endpoint: STORES, data: {
        "page": storeCurrentPage,
      }).then(
        (value) {
          if (isRefresh) {
            storeCurrentPage = 1;
          }
          // providersList = [];
          print('11111111111111---<${value.data}');
          // print(value.data);
          // print(value);
          print('22222222222223---> $value');
          storesModel = (StoresModel.fromJson(value.data));
          print('33333333333333---> $storesModel');
          if (isRefresh) {
            storesList = storesModel!.data!;
          } else {
            storesModel!.data!.forEach((element) {
              storesList!.add(element);
            });
            storeCurrentPage++;
          }

          print("wwwwwwwwwwwwwwww-->${storesList!.length}");

          print("wwwwwwwwwwwwwwww-->$storeCurrentPage");
          emit(GetStoresSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetStoresErrorState());
    }
  }

  /// end Get Stores
  ///
  ///
  /// start CancelPayments

  Future customerRefusePayment({
    required String taskId,
    required String due,
  }) async {
    try {
      emit(CustomerRefusePayLoadingState());

      await DioHelper.postData(endpoint: CANCELPAYMENT, data: {
        "task_id": taskId,
        "due": due,
        "customer_id": mohtarefId,
      }).then(
        (value) {
          print(value.data);

          print("000000000000000000000--> CANCELPAYMENT");

          emit(CustomerRefusePaySuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(CustomerRefusePayErrorState());
    }
  }

  /// end CancelPayments
  ///
  ///
  /// Start Rate Customer

  double rateValue = 0;
  swapRate(double rate) {
    rateValue = rate;
    emit(RateCustomerSwapState());
  }

  Future rateCustomer({String? customerId, double? rate}) async {
    try {
      emit(RateCustomerLoadingState());
      await DioHelper.postData(endpoint: RATECUSTOMER, data: {
        "customer_id": customerId,
        "rate": rate,
      }).then(
        (value) {
          print('start Rate Customer');

          emit(RateCustomerSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(RateCustomerErrorState());
    }
  }

  /// End Rate Customer
  ///
  ///
  /// START GET Statics DATA

  StaticsModel? staticsModel;
  Future getStatics() async {
    try {
      emit(GetStaticsLoadingState());
      await DioHelper.postData(endpoint: STATICS, data: {
        "id": mohtarefId,
      }).then(
        (value) {
          staticsModel = (StaticsModel.fromJson(value.data));
          print('33333333333');
          print(staticsModel!.data);
          emit(GetStaticsSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetStaticsErrorState());
    }
  }

  /// END GET Statics DATA
  ///
  ///
  /// start Get Statics Tasks

  List<StaticsTasksData>? staticsTasksList = [];
  StaticsTasksModel? staticsTasksModel;
  int staticsTasksCurrentPage = 1;

  Future getStaticsTasks({
    bool isRefresh = false,
  }) async {
    try {
      emit(GetStaticsTasksLoadingState());
      await DioHelper.postData(endpoint: STATICSTASKS, data: {
        "id": mohtarefId,
        "page": staticsTasksCurrentPage,
      }).then(
        (value) {
          if (isRefresh) {
            staticsTasksCurrentPage = 1;
          }
          // providersList = [];
          print('11111111111111---<${value.data}');
          // print(value.data);
          // print(value);
          print('22222222222223---> $value');
          staticsTasksModel = (StaticsTasksModel.fromJson(value.data));

          if (isRefresh) {
            staticsTasksList = staticsTasksModel!.data!;
          } else {
            staticsTasksModel!.data!.forEach((element) {
              staticsTasksList!.add(element);
            });
            staticsTasksCurrentPage++;
          }

          print("wwwwwwwwwwwwwwww-->${staticsTasksList!.length}");
          print("wwwwwwwwwwwwwwww-->${staticsTasksList![0].id}");
          print("wwwwwwwwwwwwwwww-->$staticsTasksCurrentPage");
          emit(GetStaticsTasksSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetStaticsTasksErrorState());
    }
  }

  /// end Get Statics Tasks
  ///
  ///
  /// start weekly summary

  WeeklySummaryModel? weeklySummaryModel;
  Future<void> getWeeklySummary() async {
    try {
      emit(GetWeeklySummaryLoadingState());
      await DioHelper.postData(endpoint: WEEKLYSUMMARY, data: {
        "staff_id": mohtarefId,
      }).then((value) {
        print("aaaaaaaaaaaaaaaaa--> ${value.data}");
        weeklySummaryModel = WeeklySummaryModel.fromJson(value.data);
        // print("aaaaaaaaaaaaaaaaa--> $weeklySummary");

        emit(GetWeeklySummarySuccessState());
      });
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetWeeklySummaryErrorState());
    }
  }

  /// end weekly summary
  ///
  ///
  /// start today summary

  TodaySummaryModel? todaySummaryModel;
  Future<void> getTodaySummary() async {
    try {
      emit(GetTodaySummaryLoadingState());
      await DioHelper.postData(endpoint: TODAYSUMMARY, data: {
        "staff_id": mohtarefId,
      }).then((value) {
        // print("aaaaaaaaaaaaaaaaa--> ${value.data}");
        todaySummaryModel = TodaySummaryModel.fromJson(value.data);

        emit(GetTodaySummarySuccessState());
      });
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetTodaySummaryErrorState());
    }
  }

  /// end today summary
  ///
  ///
  /// start today wallet

  TodayWalletModel? todayWalletModel;
  Future<void> getTodayWallet() async {
    try {
      emit(GetTodayWalletLoadingState());
      await DioHelper.postData(endpoint: TODAYWALLET, data: {
        "staff_id": mohtarefId,
      }).then((value) {
        print("wwwwwwwwwwwwaaaaaaaaaaaaaaaaa--> ${value.data}");
        todayWalletModel = TodayWalletModel.fromJson(value.data);
        print("wwwwwwwwwwwwaaaaaaaaaaaaaaaaa000000000--> $todayWalletModel");
        emit(GetTodayWalletSuccessState());
      });
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetTodayWalletErrorState());
    }
  }

  /// end today Wallet
  ///
  ///
  /// start weekly wallet

  WeeklyWalletModel? weeklyWalletModel;
  Future<void> getWeeklyWallet() async {
    try {
      emit(GetWeeklyWalletLoadingState());
      await DioHelper.postData(endpoint: WEEKLYWALLET, data: {
        "staff_id": mohtarefId,
      }).then((value) {
        print("aaaaaaaaaaaaaaaaa--> ${value.data}");
        weeklyWalletModel = WeeklyWalletModel.fromJson(value.data);
        // print("aaaaaaaaaaaaaaaaa--> $weeklyWallet");

        emit(GetWeeklyWalletSuccessState());
      });
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetWeeklyWalletErrorState());
    }
  }

  /// end weekly wallet
  ///
  ///
  /// start ConfirmPay

  Future<void> confirmPay(
      {String? taskId, String? fees, String? spares}) async {
    try {
      emit(ConfirmPayLoadingState());
      await DioHelper.postData(endpoint: CONFIRMPAY, data: {
        "task_id": taskId,
        "fees": fees,
        "spares": spares,
      }).then((value) {
        print("aaaaaaaaaaaaaaaaa--> ${value.data}");

        emit(ConfirmPaySuccessState());
      });
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(ConfirmPayErrorState());
    }
  }

  /// end ConfirmPay
  ///
  ///
  /// start confirmPaymentBody

  // String confirmPaymentNotificationBody = "";
  // confirmPaymentNotification() {
  //   // confirmPaymentNotificationBody = newvalue;
  //   emit(ConfirmPaymentBodyState());
  // }

  /// end confirmPaymentBody
  ///
  ///
  /// START GET TaskDetails Data

  TaskDetailsModel? taskDetailsModel;
  Future getTaskDetails(String? taskId) async {
    try {
      emit(GetTaskDetailsDataLoadingState());
      await DioHelper.postData(endpoint: TASKSDETAILS, data: {
        "task_id": taskId,
      }).then(
        (value) {
          print('11111111111bbbbbbbb--> ');
          print(value.data);
          print(value);

          taskDetailsModel = (TaskDetailsModel.fromJson(value.data));
          print('222222222222bb--> ${taskDetailsModel!.data!.serviceAmount}');
          emit(GetTaskDetailsDataSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(GetTaskDetailsDataErrorState());
    }
  }

  /// END GET TaskDetails Data
  ///
  ///
  /// Start staffOfferToCustomer

  Future staffOfferToCustomer({String? taskId}) async {
    try {
      emit(StaffOfferToCustomerLoadingState());
      await DioHelper.postData(endpoint: OFFER, data: {
        "staff_id": mohtarefId,
        "task_id": taskId,
      }).then(
        (value) {
          print('start Staff Offer To Customer');

          emit(StaffOfferToCustomerSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(StaffOfferToCustomerErrorState());
    }
  }

  /// End staffOfferToCustomer
  ///
  ///
  /// start cancelReason

  Future cancelReason({
    required String taskId,
    String? reason,
    String? note,
  }) async {
    try {
      emit(CancelReasonLoadingState());

      await DioHelper.postData(endpoint: CANCELREASON, data: {
        "task_id": taskId,
        "reason": reason,
        "note": note,
        "cancelled_by": "staff",
      }).then(
        (value) {
          print(value.data);
          print("000000000000000000000--> CANCELREASON");
          emit(CancelReasonSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(CancelReasonErrorState());
    }
  }

  /// end cancelReason
  ///
  ///
  /// start SendComplaint

  Future sendComplaint({
    required String? title,
    required String? description,
  }) async {
    try {
      emit(SendComplaintLoadingState());

      await DioHelper.postData(endpoint: SENDCOMPLAINT, data: {
        "id": mohtarefId,
        "title": title,
        "description": description,
        "created_by": "staff",
      }).then(
        (value) {
          print(value.data);
          print("000000000000000000000--> SendComplaint");
          emit(SendComplaintSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222 message");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(SendComplaintErrorState());
    }
  }

  /// end SendComplaint
}
