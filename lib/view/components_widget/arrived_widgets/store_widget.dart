import 'package:flutter/material.dart';
import 'package:mohtaref/controller/cubit/App_cubit.dart';
import 'package:mohtaref/view/components_widget/common_button.dart';
import 'package:get/get.dart';
import 'package:mohtaref/view/components_widget/no_data_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant.dart';
import '../style.dart';

class StoreWidget extends StatefulWidget {
  const StoreWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.homeCubit,
    this.onTap,
  }) : super(key: key);

  final double width;
  final double height;
  final AppCubit homeCubit;
  final VoidCallback? onTap;

  @override
  _StoreWidgetState createState() => _StoreWidgetState();
}

class _StoreWidgetState extends State<StoreWidget> {
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
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        width: widget.width,
        height: widget.height,
        color: Colors.grey.withOpacity(0.9),
        child: Column(
          children: [
            SizedBox(
              height: widget.height * 0.03,
            ),
            Expanded(
                child: SmartRefresher(
              controller: _refreshController!,
              enablePullUp: true,
              onRefresh: () async {
                final result = await widget.homeCubit.getStores();
                if (result != null) {
                  _refreshController!.refreshCompleted();
                } else {
                  _refreshController!.refreshFailed();
                }
              },
              onLoading: () async {
                final result = await widget.homeCubit.getStores();
                if (result != null) {
                  _refreshController!.loadComplete();
                } else {
                  _refreshController!.loadFailed();
                }
              },
              child: widget.homeCubit.storesList!.length != 0
                  ? ListView.separated(
                      padding: EdgeInsets.symmetric(
                          vertical: widget.height * 0.03,
                          horizontal: widget.width * 0.03),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          // margin: EdgeInsets.symmetric(
                          //     vertical: height * 0.03,
                          //     horizontal: width * 0.03),
                          width: widget.width,
                          height: widget.height * 0.18,
                          decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(widget.width * 0.1),
                              )),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                contentPadding:
                                    EdgeInsets.only(top: widget.height * 0.01),
                                leading: IconButton(
                                  icon: Icon(Icons.phone),
                                  onPressed: () async {
                                    String phoneNumber = widget
                                        .homeCubit.storesList![index].mobile!;
                                    // another solution
                                    // String phoneNumber = Uri.encodeComponent('0114919223');
                                    await canLaunch("tel:$phoneNumber")
                                        ? launch("tel:$phoneNumber")
                                        : showFlutterToast(
                                            message: "call_faild".tr);
                                  },
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("2 min"),
                                    CircleAvatar(
                                      radius: widget.width * 0.08,
                                    ),
                                    Text("0.5 mi"),
                                  ],
                                ),
                                // subtitle: Text("arrived_jone"),
                              ),
                              SizedBox(
                                height: widget.height * 0.015,
                              ),
                              Text(widget
                                  .homeCubit.storesList![index].storename!),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: widget.height * 0.05,
                      ),
                      itemCount: widget.homeCubit.storesList!.length,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "no_stores_found_yet".tr,
                          textAlign: TextAlign.center,
                          style: labelStyleMinBlack,
                        ),
                        NoDataWidget(
                            width: widget.width * 0.6,
                            height: widget.height * 0.2)
                      ],
                    ),
            )),
            SizedBox(
              height: widget.height * 0.03,
            ),
            CommonButton(
              width: widget.width * 0.85,
              height: widget.height * 0.08,
              containerColor: mainColor,
              borderColor: redColor,
              textColor: redColor,
              text: "back".tr,
              onTap: widget.onTap,
            ),
            SizedBox(
              height: widget.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
