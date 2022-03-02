import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref/controller/cubit/Auth_cubit.dart';
import 'package:mohtaref/controller/cubit_states/Auth_state.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref/view/components_widget/app_bar_widget.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';
import 'package:mohtaref/view/components_widget/navigator.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:mohtaref/view/components_widget/text_form_field_widget.dart';
import 'package:get/get.dart';
import '../../../constant.dart';

class ContinueSignUp extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String serviceId = "";
  final TextEditingController servicesController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final String? userName;
  final String? email;
  final String? mobile;
  final String? mobile2;
  final String? location;
  final String? password;

  ContinueSignUp(
      {this.userName,
      this.email,
      this.mobile,
      this.mobile2,
      this.location,
      this.password});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        if (state is AuthRegisterLoadingState)
          showFlutterToast(message: "loading".tr, backgroundColor: darkColor);
        if (state is AuthRegisterErrorState)
          showFlutterToast(message: "error".tr, backgroundColor: redColor);

        if (state is AuthRegisterSuccessState) {
          // goToAndFinish(context, SignIn());
          AuthCubit.get(context).startTimer();

          AuthCubit.get(context).profileImage = null;
          AuthCubit.get(context).passportImage = null;
        }
      }, builder: (context, state) {
        var authCubit = AuthCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(height * 0.1),
            child: AppBarWidgets(
              title: "personal_docs".tr,
              width: width,
            ),
          ),
          body: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(width * 0.03),
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02,
                          vertical: height * 0.03,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: servicesController,
                                enabled: false,
                                style: TextStyle(
                                  // color: Colors.white,
                                  color: secondColor,
                                ),
                                decoration: InputDecoration(
                                  hintText: "services".tr,
                                  labelText: "services".tr,
                                  hintStyle: TextStyle(
                                    color: secondColor,
                                  ),
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                size: width * 0.1,
                                // color: Colors.white,
                                color: secondColor,
                              ),
                              onSelected: (String value) {
                                serviceId = value;
                                authCubit.servicesModel!.data!
                                    .forEach((element) {
                                  if (element.id == value) {
                                    servicesController.text =
                                        element.seviceName!;
                                  }
                                  print(servicesController.text);
                                  print(element.seviceName!);
                                  print(value);
                                  print(serviceId);
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return authCubit.servicesModel!.data!
                                    .map<PopupMenuItem<String>>((value) {
                                  return PopupMenuItem(
                                      child: Text(value.seviceName!),
                                      value: value.id);
                                }).toList();
                              },
                            ),
                          ],
                        ),
                      ),
                      TextFormFieldWidget(
                        controller: jobController,
                        hint: "job_hint".tr,
                        // controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        valdiator: (value) {
                          if (value!.isEmpty) {
                            return "enter_this_field_please!".tr;
                          }
                          return null;
                        },
                      ),
                      TextFormFieldWidget(
                        controller: nationalityController,
                        hint: "nationality_hint".tr,
                        // controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        valdiator: (value) {
                          if (value!.isEmpty) {
                            return "enter_this_field_please!".tr;
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Expanded(child: Text('passport'.tr)),
                          if (authCubit.passportImage != null)
                            Expanded(
                                child: Image.file(
                              authCubit.passportImage!,
                              width: width * 0.2,
                              fit: BoxFit.fitHeight,
                              height: height * 0.2,
                            )),
                          Expanded(
                              child: CommonButton(
                                  text: "upload".tr,
                                  fontSize: width * 0.025,
                                  onTap: () {
                                    authCubit.getPassportImage(
                                      context,
                                      height: height * 0.08,
                                      width: width * 0.85,
                                    );
                                  })),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(child: Text('picture'.tr)),
                          if (authCubit.profileImage != null)
                            Expanded(
                                child: Image.file(
                              authCubit.profileImage!,
                              fit: BoxFit.fitHeight,
                              width: width * 0.2,
                              height: height * 0.2,
                            )),
                          Expanded(
                              child: CommonButton(
                                  text: "upload".tr,
                                  fontSize: width * 0.025,
                                  onTap: () {
                                    authCubit.getProfileImage(
                                      context,
                                      height: height * 0.08,
                                      width: width * 0.85,
                                    );
                                  })),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "confirm_terms".tr,
                        textAlign: TextAlign.center,
                        style: lineStyleSmallBlack,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CommonButton(
                        text: state is AuthRegisterLoadingState
                            ? "loading".tr
                            : "continue".tr,
                        fontSize: width * 0.04,
                        width: width * 0.85,
                        // height: height * 0.05,
                        containerColor: buttonColor,
                        textColor: buttonTextColor,
                        onTap: state is AuthRegisterLoadingState
                            ? () {
                                showFlutterToast(
                                    message: "loading".tr,
                                    backgroundColor: darkColor);
                              }
                            : () {
                                if (!_formKey.currentState!.validate() &&
                                    serviceId == "" &&
                                    authCubit.profileImage == null &&
                                    authCubit.passportImage == null) {
                                  return;
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("terms_title".tr),
                                      content: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Text("terms".tr)),
                                      actions: [
                                        CommonButton(
                                          text: "agree".tr,
                                          textColor: buttonColor,
                                          onTap: () {
                                            back(context);
                                            print(userName);
                                            print(email);
                                            print(password);
                                            print(mobile);
                                            print(mobile2);
                                            print(location);
                                            print(servicesController.text);
                                            print(serviceId);
                                            print(nationalityController.text);
                                            print(jobController.text);
                                            print(authCubit
                                                .currentPosition!.latitude);
                                            print(authCubit
                                                .currentPosition!.longitude);
                                            print(authCubit.profileImage);
                                            print(authCubit.passportImage);
                                            if (serviceId == "" ||
                                                authCubit.profileImage ==
                                                    null ||
                                                authCubit.passportImage ==
                                                    null) {
                                              showFlutterToast(
                                                  message: serviceId == ""
                                                      ? "select_service".tr
                                                      : authCubit.profileImage ==
                                                              null
                                                          ? "select_profileImage"
                                                              .tr
                                                          : "select_passportImage"
                                                              .tr,
                                                  backgroundColor: darkColor);
                                            } else {
                                              print(".kkkkkkkkkkkkkkkkkkk");
                                              authCubit.register(
                                                email: email,
                                                username: userName,
                                                password: password,
                                                mobile: mobile,
                                                secondMobile: mobile2,
                                                location: location,
                                                lat: (authCubit.currentPosition!
                                                        .latitude)
                                                    .toString(),
                                                long: (authCubit
                                                        .currentPosition!
                                                        .longitude)
                                                    .toString(),
                                                service: serviceId,
                                                job: jobController.text,
                                                nationality:
                                                    nationalityController.text,
                                                profile: authCubit.profileImage,
                                                passport:
                                                    authCubit.passportImage,
                                              );
                                            }
                                          },
                                        ),
                                        // CommonButton(
                                        //     text: "no".tr,
                                        //     textColor: buttonColor,
                                        //     onTap: () {
                                        //       back(context);
                                        //     }),
                                      ],
                                    ),
                                  );
                                }
                              },
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
              if (AuthCubit.get(context).isTimerStart == true)
                CustomExitAppAlert(width: width, height: height),
            ],
          ),
        );
      });
    });
  }
}

class CustomExitAppAlert extends StatelessWidget {
  const CustomExitAppAlert({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.withOpacity(0.5),
      child: Center(
        child: Container(
          width: width * 0.8,
          height: height * 0.4,
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.1),
            color: mainColor,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: MediaQuery.of(context).size.width * 0.2,
                  child: Image.asset(
                    "asset/images/main_logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: "app_exit_in".tr,
                      style: labelStyleMinBlack,
                    ),
                    TextSpan(
                        text: (AuthCubit.get(context).start).toString() +
                            " " +
                            "sec".tr,
                        style: fifthLineStyle),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
