import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref/constant.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref/model/tasks_model.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';
import 'package:mohtaref/view/components_widget/navigator.dart';
import 'package:mohtaref/view/components_widget/rating_widget.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:get/get.dart';
import 'package:mohtaref/view/screens/home_polyline_map/details_screen.dart';

class RatingUser extends StatelessWidget {
  final CustomerData? customerData;

  RatingUser({this.customerData});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var homeCubit = AppCubit.get(context);
            return Scaffold(
              body: Column(
                children: [
                  Expanded(
                      child: Container(
                    width: width,
                    height: height,
                    color: greyColor,
                    child: Image.asset(
                      "asset/images/main_logo.png",
                      fit: BoxFit.fill,
                    ),
                  )),
                  Container(
                    height: height * 0.3,
                    width: width,
                    color: mainColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "how_was_your_client".tr,
                          style: thirdLineStyle,
                        ),
                        Text(
                          customerData!.username!,
                          style: secondLineStyle,
                        ),
                        RatingMethodWidget(
                          width: width,
                          initialRating: double.parse(customerData!.rate!),
                          ignoreGestures: false,
                          onRatingUpdate: (rate) {
                            homeCubit.swapRate(rate);
                          },
                        ),
                        CommonButton(
                            width: width * 0.85,
                            height: height * 0.08,
                            containerColor: redColor,
                            textColor: mainColor,
                            fontSize: width * 0.04,
                            text: "rate_client".tr,
                            onTap: () {
                              print("tttttttttttttttttt${homeCubit.rateValue}");
                              print("tttttttttttttttttt${customerData!.rate}");
                              homeCubit.rateValue == 0
                                  ? goTo(context, DetailsScreen())
                                  : homeCubit
                                      .rateCustomer(
                                      customerId: customerData!.id,
                                      rate: homeCubit.rateValue,
                                    )
                                      .then((value) {
                                      homeCubit.getProfile();
                                      goTo(context, DetailsScreen());
                                      homeCubit.rateValue = 0;
                                    });
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}
