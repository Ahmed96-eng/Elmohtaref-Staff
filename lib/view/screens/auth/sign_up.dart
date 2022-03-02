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
import 'continue_sign_up.dart';

class SignUp extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController firstphoneController = TextEditingController();
  final TextEditingController secondphoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizeConfig) {
        final height = sizeConfig.screenHeight!;
        final width = sizeConfig.screenWidth!;
        return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          // if (state is AuthRegisterErrorState) back(context);
        }, builder: (context, state) {
          addressController.text = AuthCubit.get(context).currentAddress!;
          return Scaffold(
            backgroundColor: Colors.white,
            // appBar: AppBar(),
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(height * 0.1),
                child: AppBarWidgets(
                  title: "",
                  width: width,
                )),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(width * 0.03),
                child: ListView(
                  children: [
                    Text(
                      "sign_up".tr,
                      style: secondLineStyle,
                    ),
                    TextFormFieldWidget(
                      hint: "name_hint".tr,
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      valdiator: (value) {
                        if (value!.isEmpty) {
                          return "enter_this_field_please!".tr;
                        }
                        return null;
                      },
                    ),
                    TextFormFieldWidget(
                      hint: "email_hint".tr,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      valdiator: (value) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.text);
                        if (value!.isEmpty) {
                          return "enter_this_field_please!".tr;
                        } else if (!value.contains('@')) {
                          return "enter_the_correct_email_please!".tr;
                        } else if (!emailValid) {
                          return "enter_the_correct_email_please!".tr;
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: height * 0.15,
                      child: Row(
                        children: [
                          Image.asset(
                            "asset/images/saudi_flag.png",
                            fit: BoxFit.fill,
                            width: width * 0.15,
                            height: height * 0.1,
                          ),
                          Expanded(
                            child: TextFormFieldWidget(
                              hint: "phone_hint_1".tr,
                              controller: firstphoneController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              // isPhone: true,
                              valdiator: (value) {
                                String pattern =
                                    r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$';
                                RegExp regex = new RegExp(pattern);
                                if (value!.length == 0) {
                                  return "enter_the_phone_number_please!".tr;
                                  // } else if (!regex.hasMatch(value)) {
                                  //   return "enter_the_correct_phone_number_please!"
                                  //       .tr;
                                } else if (value.isEmpty) {
                                  return "enter_this_field_please!".tr;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.15,
                      child: Row(
                        children: [
                          Image.asset(
                            "asset/images/saudi_flag.png",
                            fit: BoxFit.fill,
                            width: width * 0.15,
                            height: height * 0.1,
                          ),
                          Expanded(
                            child: TextFormFieldWidget(
                              hint: "phone_hint_2".tr,
                              controller: secondphoneController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              // isPhone: true,
                              valdiator: (value) {
                                String pattern =
                                    r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$';
                                RegExp regex = new RegExp(pattern);

                                //  if (!regex.hasMatch(value)) {
                                //   return "enter_the_correct_phone_number_please!"
                                //       .tr;
                                // }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormFieldWidget(
                      hint: "address_hint".tr,
                      controller: addressController,
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
                      hint: "password_hint".tr,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      iconData: AuthCubit.get(context).showPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      onTap: () =>
                          AuthCubit.get(context).changeshowPassword(context),
                      obscurePassword: AuthCubit.get(context).showPassword,
                      valdiator: (value) {
                        if (value!.isEmpty) {
                          return "enter_this_field_please!".tr;
                        } else if (value.length < 6) {
                          return "enter_the_correct_password_please!".tr;
                        }
                        return null;
                      },
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
                      text: (state is AuthRegisterLoadingState)
                          ? "loading".tr
                          : "continue".tr,

                      fontSize: width * 0.04,
                      width: width * 0.85,
                      // height: height * 0.05,
                      containerColor: buttonColor,
                      textColor: buttonTextColor,
                      onTap: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        } else {
                          goTo(
                              context,
                              ContinueSignUp(
                                email: emailController.text,
                                userName: nameController.text,
                                password: passwordController.text,
                                mobile: firstphoneController.text,
                                mobile2: secondphoneController.text,
                                location: addressController.text,
                              ));
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
          );
        });
      },
    );
  }
}
