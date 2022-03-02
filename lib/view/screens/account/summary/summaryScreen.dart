import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref/view/components_widget/app_bar_widget.dart';
import 'package:get/get.dart';
import 'package:mohtaref/view/screens/account/summary/summary_today.dart';
import 'package:mohtaref/view/screens/account/summary/summary_weekly.dart';

class SummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            // var cubit = AppCubit.get(context);
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(height * 0.15),
                    child: AppBarWidgets(
                      title: "summary".tr,
                      width: width,
                      showTap: true,
                      tabs: [
                        Tab(
                          text: "today".tr,
                        ),
                        Tab(
                          text: "weekly".tr,
                        ),
                      ],
                    )),
                body: TabBarView(
                  children: [SummaryToday(), SummaryWeekly()],
                ),
              ),
            );
          });
    });
  }
}
