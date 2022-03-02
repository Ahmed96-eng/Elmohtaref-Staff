import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref/constant.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:mohtaref/view/components_widget/account_widgets/account_widget.dart';
import 'package:mohtaref/view/components_widget/account_widgets/profile_info_widget.dart';
import 'package:mohtaref/view/components_widget/cached_network_Image_widget.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';
import 'package:mohtaref/view/components_widget/icon_button_widget.dart';
import 'package:mohtaref/view/components_widget/navigator.dart';
import 'package:mohtaref/view/components_widget/style.dart';

class ProfileScreen extends StatelessWidget {
  final phoneController = TextEditingController();
  final phone2Controller = TextEditingController();
  final locationController = TextEditingController();
  final languageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var profileData = AppCubit.get(context).profilModel!.data;
            var appCubit = AppCubit.get(context);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey[200],
              body: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width,
                        height: height * 0.35,
                        color: darkColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.13,
                          left: width * 0.06,
                          right: width * 0.06,
                          bottom: height * 0.02,
                        ),
                        child: Text(
                          "personal_info".tr,
                          style: labelStyleMinBlack,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: mainColor,
                          width: width,
                          height: height * 0.45,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            children: [
                              AccountWidget(
                                width: width,
                                height: height,
                                title: profileData!.mobile,
                                iconData: Icons.phone,
                                showUpdateIcon: true,
                                updateIcon: Icons.change_circle,
                                onIconPressed: () {
                                  updateAlertDailog(
                                    context: context,
                                    hint: profileData.mobile!,
                                    height: height,
                                    width: width,
                                    controller: phoneController,
                                    onTap: () {
                                      appCubit
                                          .updateProfile(
                                        phone: phoneController.text,
                                      )
                                          .then((value) {
                                        Future.delayed(Duration(seconds: 1))
                                            .then((value) {
                                          appCubit.getProfile();
                                          back(context);
                                        });
                                      });

                                      phoneController.clear();
                                    },
                                  );
                                },
                              ),
                              AccountWidget(
                                width: width,
                                height: height,
                                title: profileData.secondMobile,
                                iconData: Icons.phone,
                                showUpdateIcon: true,
                                updateIcon: Icons.change_circle,
                                onIconPressed: () {
                                  updateAlertDailog(
                                    context: context,
                                    hint: profileData.secondMobile!,
                                    height: height,
                                    width: width,
                                    controller: phone2Controller,
                                    onTap: () {
                                      appCubit
                                          .updateProfile(
                                        secondPhone: phone2Controller.text,
                                      )
                                          .then((value) {
                                        Future.delayed(Duration(seconds: 1))
                                            .then((value) {
                                          appCubit.getProfile();
                                          back(context);
                                        });
                                      });

                                      phone2Controller.clear();
                                    },
                                  );
                                },
                              ),
                              AccountWidget(
                                width: width,
                                height: height,
                                title: profileData.email,
                                iconData: Icons.email,
                              ),
                              AccountWidget(
                                width: width,
                                height: height,
                                title: profileData.languages,
                                iconData: Icons.language,
                                showUpdateIcon: true,
                                updateIcon: Icons.change_circle,
                                onIconPressed: () {
                                  updateAlertDailog(
                                    context: context,
                                    hint: profileData.languages!,
                                    height: height,
                                    width: width,
                                    controller: languageController,
                                    onTap: () {
                                      appCubit
                                          .updateProfile(
                                        languages: languageController.text,
                                      )
                                          .then((value) {
                                        Future.delayed(Duration(seconds: 1))
                                            .then((value) {
                                          appCubit.getProfile();
                                          back(context);
                                        });
                                      });

                                      languageController.clear();
                                    },
                                  );
                                },
                              ),
                              AccountWidget(
                                width: width,
                                height: height,
                                title: profileData.location,
                                iconData: Icons.location_on,
                                showUpdateIcon: true,
                                updateIcon: Icons.change_circle,
                                onIconPressed: () {
                                  updateAlertDailog(
                                    context: context,
                                    hint: profileData.location!,
                                    height: height,
                                    width: width,
                                    controller: locationController,
                                    onTap: () {
                                      appCubit
                                          .updateProfile(
                                        location: locationController.text,
                                      )
                                          .then((value) {
                                        Future.delayed(Duration(seconds: 1))
                                            .then((value) {
                                          appCubit.getProfile();
                                          back(context);
                                        });
                                      });

                                      locationController.clear();
                                    },
                                  );
                                },
                              ),
                              Row(
                                children: [
                                  appCubit.passportImage != null
                                      ? AccountWidget(
                                          title: "update".tr,
                                          width: width,
                                          height: height,
                                          iconData: Icons.upload,
                                          showImage: true,
                                          onTap: () {
                                            appCubit
                                                .updateProfile(
                                              passportFile:
                                                  appCubit.passportImage,
                                            )
                                                .then((value) {
                                              appCubit.passportImage = null;
                                              Future.delayed(
                                                      Duration(seconds: 1))
                                                  .then((value) {
                                                appCubit.getProfile();
                                                back(context);
                                              });
                                            });
                                          },
                                        )
                                      : AccountWidget(
                                          title: "change_passport".tr,
                                          showCircleIcon: true,
                                          iconData: Icons.change_circle,

                                          height: height * 0.2,
                                          width: width * 0.6,
                                          // showImage: true,
                                          onTap: () {
                                            appCubit.getPassportImage(
                                              context,
                                              height: height * 0.08,
                                              width: width * 0.5,
                                            );
                                          },
                                        ),
                                  Container(
                                    width: width * 0.3,
                                    height: height * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(width * .02),
                                    ),
                                    child: (AppCubit.get(context)
                                                .passportImage !=
                                            null)
                                        ? Image.file(
                                            appCubit.passportImage!,
                                            width: width * 0.5,
                                            fit: BoxFit.fitHeight,
                                            height: height * 0.2,
                                          )
                                        : CachedNetworkImageWidget(
                                            // width: width * 0.3,
                                            borderRadius: BorderRadius.circular(
                                                width * .02),
                                            image: profileData.passport,
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  /// head segment
                  ///
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: height * 0.05),
                    child: InkWell(
                      onTap: () {
                        back(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: mainColor,
                      ),
                    ),
                  ),

                  Positioned(
                    top: height * 0.09,
                    left: 0, right: 0,
                    // alignment: AlignmentDirectional.center,
                    child: Container(
                      width: width,
                      height: height * 0.4,
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: Container(
                              width: width,
                              height: height * 0.3,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.05,
                                  vertical: height * 0.02),
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius:
                                    BorderRadius.circular(width * 0.05),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: height * 0.2),
                                child: Row(
                                  children: [
                                    ProfileInfoWidget(
                                      showIcon: true,
                                      icon: Icons.star,
                                      value: profileData.rate,
                                      title: "rating".tr,
                                      width: width,
                                      height: height,
                                    ),
                                    ProfileInfoWidget(
                                      value: profileData.numberTasks,
                                      title: "alltasks".tr,
                                      width: width,
                                      height: height,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // CircleAvatar(
                          //   radius: width * 0.15,
                          // ),

                          // Align(
                          //   alignment: AlignmentDirectional.topCenter,
                          //   child: Container(
                          //     margin: EdgeInsets.only(top: height * 0.13),
                          //     height: height * 0.05,
                          //     width: width * 0.15,
                          //     color: mainColor,
                          //     child: Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceAround,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         Text('4.5'),
                          //         Icon(
                          //           Icons.star,
                          //           color: Colors.amber,
                          //           size: width * 0.05,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          ///  image profile

                          appCubit.profileImage == null
                              ? ClipOval(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: CachedNetworkImageWidget(
                                    width: width * 0.27,
                                    height: height * 0.15,
                                    borderRadius:
                                        BorderRadius.circular(width * .02),
                                    image: profileData.profile,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: width * 0.14,
                                  backgroundImage: FileImage(
                                    appCubit.profileImage!,
                                  ),
                                ),

                          /// change image profile button
                          Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.1, left: width * 0.2),
                            child: IconButtonWidget(
                              icon: appCubit.profileImage == null
                                  ? Icons.change_circle
                                  : Icons.upload,
                              circleAvatarColor: thirdColor,
                              iconColor: redColor,
                              size: appCubit.profileImage == null
                                  ? width * 0.09
                                  : width * 0.05,
                              onpressed: () {
                                appCubit.profileImage == null
                                    ? appCubit.getProfileImage(
                                        context,
                                        height: height * 0.08,
                                        width: width * 0.5,
                                      )
                                    : appCubit
                                        .updateProfile(
                                            profileFile: appCubit.profileImage)
                                        .then((value) {
                                        appCubit.profileImage = null;
                                        Future.delayed(Duration(seconds: 1))
                                            .then((value) =>
                                                appCubit.getProfile());
                                      });
                              },
                            ),
                          ),

                          /// profile name
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.2),
                            child: Text(
                              profileData.username!,
                              style: labelStyleMinBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   left: 0,
                  //   right: 0,
                  //   child: Container(
                  //     color: Colors.amber,
                  //     width: width,
                  //     height: height * 0.45,
                  //   ),
                  // )
                ],
              ),
            );
          });
    });
  }

  updateAlertDailog({
    BuildContext? context,
    String? hint,
    double? height,
    double? width,
    TextEditingController? controller,
    VoidCallback? onTap,
  }) {
    showAlertDailog(
        context: context,
        contentWidget: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(hintText: hint),
              ),
              SizedBox(
                height: height! * 0.04,
              ),
              CommonButton(
                  text: "upload".tr,
                  height: height * 0.08,
                  width: width! * 0.5,
                  fontSize: width * 0.04,
                  containerColor: redColor,
                  textColor: Colors.white,
                  onTap: onTap),
            ],
          ),
        ),
        onPressNo: () {},
        onPressYes: () {});
  }
}
