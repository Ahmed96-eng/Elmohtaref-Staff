import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohtaref/controller/api_dio_helper/dio_helper.dart';
import 'package:mohtaref/controller/api_dio_helper/endpoint_dio.dart';
import 'package:mohtaref/controller/cached_helper/cached_helper.dart';
import 'package:mohtaref/controller/cached_helper/key_constant.dart';
import 'dart:async';

import 'package:mohtaref/controller/cubit_states/Auth_state.dart';
import 'package:mohtaref/model/auth_model.dart';
import 'package:mohtaref/model/services_model.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';

import '../../constant.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

  onInit() {}

  /// start show password

  bool showPassword = true;
  void changeshowPassword(BuildContext context) {
    showPassword = !showPassword;
    emit(ChangeShowPasswordState());
  }

  /// end show password
  ///
  ///
  /// start timer

  Timer? timer;
  int start = 6;
  bool isTimerStart = false;
  void _stopTimerCountDown() {
    timer!.cancel();
    print("STOP");
    emit(AppStopTimerCountDownState());
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    isTimerStart = !isTimerStart;
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          _stopTimerCountDown();
          exit(0);
        } else {
          start--;
          emit(AppStartTimerCountDownState());
        }
      },
    );
  }

  /// end timer
  ///
  ///
  /// start login

  AuthModelModel? authModel;
  Future<void> logIn({String? email, String? password}) async {
    try {
      emit(AuthLoginLoadingState());
      return await DioHelper.postData(endpoint: LOGIN, data: {
        "email": email,
        "password": password,
        "fcm_device_token": deviceToken,
      }).then(
        (value) {
          print('pppppppppppppppppp');
          print(value.data);
          print(value);
          authModel = AuthModelModel.fromJson(value.data);
          print(authModel!.data!.username);
          CachedHelper.setData(
              key: loginTokenId, value: authModel!.data!.token.toString());
          userToken = authModel!.data!.token;
          print('kkkkkkkkkkkkkk==> $userToken');
          CachedHelper.setData(
              key: mohtarefIdKey, value: authModel!.data!.id.toString());

          myEarningAmount = double.parse(authModel!.data!.balance!);
          CachedHelper.setData(
              key: myEarningKey,
              value: double.parse(authModel!.data!.balance!));

          emit(AutLoginSuccessState(authModel!));
        },
      );
    } on DioError catch (error) {
      if (error.response!.statusCode == 400) {
        print("ERROR2223333222");
        print(error.response!.statusCode.toString());
        print(error.response!.data["message"]);
        showFlutterToast(
            message: error.response!.data["message"],
            backgroundColor: redColor);
        emit(AuthLoginErrorState());
      }
    }
  }

  /// end login
  ///
  ///
  /// start register
  Future register({
    String? email,
    String? password,
    String? username,
    String? mobile,
    String? secondMobile,
    String? long,
    String? lat,
    String? location,
    String? nationality,
    String? service,
    String? job,
    File? profile,
    File? passport,
  }) async {
    try {
      CachedHelper.removeData(key: myEarningKey);
      myEarningAmount = 0.0;
      emit(AuthRegisterLoadingState());
      await DioHelper.postData(endpoint: REGISTER, data: {
        "email": email,
        "password": password,
        "username": username,
        "mobile": mobile,
        "mobile2": secondMobile,
        "long": long,
        "lat": lat,
        "location": location,
        "nationality": nationality,
        "service": service,
        "job": job,
        "device_token": deviceToken,
        "profile": await MultipartFile.fromFile(profile!.path,
            contentType: MediaType('image', 'png'),
            filename: profile.path.split('/').last),
        "passport": await MultipartFile.fromFile(passport!.path,
            contentType: MediaType('image', 'png'),
            filename: passport.path.split('/').last),
      }).then(
        (value) {
          print(value.data);
          // authModel = AuthModelModel.fromJson(value.data);
          // CachedHelper.setData(
          //     key: loginTokenId, value: authModel!.data!.token.toString());
          // userToken = authModel!.data!.token;
          emit(AuthRegisterSuccessState(authModel));
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(AuthRegisterErrorState());
    }
  }

  /// end register
  ///
  ///
  /// start get services

  ServicesModel? servicesModel;
  getServices() {
    try {
      emit(AuthServicesLoadingState());
      DioHelper.getData(
        endpoint: SERVICES,
      ).then(
        (value) {
          print(value.data);
          servicesModel = (ServicesModel.fromJson(value.data));
          print("00000000000000000000000000000000");
          print(value.data);

          emit(AutServicesSuccessState());
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(AuthServicesErrorState());
    }
  }

  /// end get services
  ///
  ///
  ///start get current address , location
  Position? currentPosition;
  String? currentAddress;
  Future<void> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    print(currentPosition!.latitude);
    print(currentPosition!.longitude);
  }

  Future<void> getAddressFromLatLng() async {
    try {
      print("start");
      List<Placemark> originPlacemarks = await placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);

      Placemark originPlace = originPlacemarks[0];

      print("start1");
      currentAddress =
          "${originPlace.street},${originPlace.subAdministrativeArea}, ${originPlace.administrativeArea}, ${originPlace.country}";
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx " + "$currentAddress");
    } catch (e) {
      print(e);
    }
  }

  ///end get current address , location
  ///
  ///
  /// start get profile image

  final picker = ImagePicker();
  File? profileImage;
  Future getProfileImageSource({required ImageSource imageSource}) async {
    final pickedFile =
        await picker.pickImage(source: imageSource, imageQuality: 50);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickedProfileImageSuccessState());
    } else {
      print('No image selected.');
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
                    'Picked Image From',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height! * 0.1,
                  ),
                  CommonButton(
                    text: "Camera",
                    textColor: mainColor,
                    containerColor: redColor,
                    height: height,
                    width: width!,
                    onTap: () {
                      getProfileImageSource(
                        imageSource: ImageSource.camera,
                      );
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: height * 0.15,
                  ),
                  CommonButton(
                    text: "Gallery",
                    textColor: mainColor,
                    containerColor: redColor,
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

  /// end profile image
  ///
  ///
  /// start get passport image

  File? passportImage;
  Future getPassportImageSource({required ImageSource imageSource}) async {
    final pickedFile =
        await picker.pickImage(source: imageSource, imageQuality: 50);

    if (pickedFile != null) {
      passportImage = File(pickedFile.path);
      emit(PickedPassportImageSuccessState());
    } else {
      print('No image selected.');
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
                    'Picked Image From',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height! * 0.1,
                  ),
                  CommonButton(
                    text: "Camera",
                    textColor: mainColor,
                    containerColor: redColor,
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
                    text: "Gallery",
                    textColor: mainColor,
                    containerColor: redColor,
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

  /// end passport image
  ///
  ///
  /// start sendSMSorEmail

  Future sendSMSorEmail(String method) async {
    try {
      emit(SendSMSorEmailLoadingState());
      await DioHelper.postData(endpoint: SENDSMSOREMAIL, data: {
        "method": method,
      }).then(
        (value) {
          print('SMSorEmail Success');
          print(value);
          emit(SendSMSorEmailSuccessState());
          // return value;
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(SendSMSorEmailErrorState());
    }
  }

  /// end sendSMSorEmail
  ///
  ///
  /// start send OTP

  Future sendOTP(String otp, String method) async {
    try {
      emit(SendOTPLoadingState());
      await DioHelper.postData(endpoint: SENDOTP, data: {
        "method": method,
        "otp": otp,
      }).then(
        (value) {
          print('OTP Success');
          print(value);
          emit(SendOTPSuccessState());
          // return value;
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(SendOTPErrorState());
    }
  }

  /// end send OTP
  ///
  ///
  /// start setNewPassword

  Future setNewPassword(String newPassword, String method) async {
    try {
      emit(SetNewPasswordLoadingState());
      await DioHelper.postData(endpoint: SETNEWPASSWORD, data: {
        "method": method,
        "password": newPassword,
      }).then(
        (value) {
          print('Set Success');
          print(value);
          emit(SetNewPasswordSuccessState());
          // return value;
        },
      );
    } on DioError catch (error) {
      print("ERROR2223333222");
      print(error.response!.statusCode.toString());
      print(error.response!.data["message"]);
      showFlutterToast(
          message: error.response!.data["message"], backgroundColor: redColor);
      emit(SetNewPasswordErrorState());
    }
  }

  /// end setNewPassword
  ///
}
