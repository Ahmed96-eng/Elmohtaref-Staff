import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mohtaref/constant.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/controller/cubit_states/app_states.dart';
import 'package:mohtaref/features/responsive_setup/responsive_builder.dart';
import 'package:mohtaref/view/components_widget/app_bar_widget.dart';
import 'package:get/get.dart';
import 'package:mohtaref/view/components_widget/rating_widget.dart';
import 'package:mohtaref/view/components_widget/style.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Ratings extends StatefulWidget {
  final bool? isOrderOnly;

  const Ratings({this.isOrderOnly = false});
  @override
  _RatingsState createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  RefreshController? _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: true);
    super.initState();
  }

  @override
  void dispose() {
    _refreshController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var homeCubit = AppCubit.get(context);
            var staticsData = AppCubit.get(context).staticsModel!.data;
            return Scaffold(
              backgroundColor: thirdColor,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(height * 0.1),
                  child: AppBarWidgets(
                    title: "rating".tr,
                    width: width,
                    closeIcon: true,
                  )),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!widget.isOrderOnly!)
                    Container(
                      width: width,
                      height: height / 3,
                      color: mainColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(staticsData!.rate!, style: secondLineStyle),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              RatingMethodWidget(
                                  onRatingUpdate: (rate) {},
                                  // ignoreGestures: true,
                                  width: width,
                                  initialRating:
                                      double.parse(staticsData.rate!)),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text("total_task".tr, style: stylegrey),
                            ],
                          )),
                          Expanded(
                            child: CircularPercentIndicator(
                              radius: width * 0.4,
                              animation: true,
                              animationDuration: 1200,
                              lineWidth: width * 0.03,
                              percent: double.parse(staticsData.percentage!),
                              center: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(staticsData.noTasks!,
                                      style: thirdLineStyle),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Text("total_task".tr, style: stylegrey),
                                ],
                              ),
                              circularStrokeCap: CircularStrokeCap.butt,
                              backgroundColor: thirdColor!,
                              progressColor: Colors.red,
                              addAutomaticKeepAlive: true,
                              animateFromLastPercent: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03,
                      vertical: height * 0.02,
                    ),
                    child: Text(
                      "all_tasks".tr,
                      style: thirdLineStyle,
                    ),
                  ),
                  Expanded(
                    child: SmartRefresher(
                      controller: _refreshController!,
                      enablePullUp: true,
                      onRefresh: () async {
                        final result =
                            await homeCubit.getStaticsTasks(isRefresh: false);
                        if (result != null) {
                          _refreshController!.refreshCompleted();
                        } else {
                          _refreshController!.refreshFailed();
                        }
                      },
                      onLoading: () async {
                        final result =
                            await homeCubit.getStaticsTasks(isRefresh: false);
                        if (result != null) {
                          _refreshController!.loadComplete();
                        } else {
                          _refreshController!.loadFailed();
                        }
                      },
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: homeCubit.staticsTasksList!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title:
                                  Text(homeCubit.staticsTasksList![index].id!),
                              subtitle: Text(Jiffy(homeCubit
                                      .staticsTasksList![index].createdAt!)
                                  .format("yyyy/MM/dd")),
                              trailing: Text(Jiffy(homeCubit
                                      .staticsTasksList![index].createdAt!)
                                  .fromNow()),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    });
  }
}
