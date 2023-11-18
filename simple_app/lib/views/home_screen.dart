import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_app/helperFunction/HelperFunction.dart';
import 'package:simple_app/views/theme/app_theme.dart';
import 'package:simple_app/views/theme/constant.dart';

import '../controller/home_controller.dart';
import '../models/OpenTrades.dart';
import 'Dialogue.dart';
//import '../controller/test_home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ThemeData theme;
  late HomeController controller;
  late OutlineInputBorder outlineInputBorder;
  final RefreshController _refreshControllerForForms = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = Get.put(HomeController());

    outlineInputBorder = OutlineInputBorder(
      borderRadius:
      BorderRadius.all(Radius.circular(Constant.containerRadius.medium)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
    proceedWithAllFunctions();

  }

  @override
  void dispose() {
    super.dispose();
    _refreshControllerForForms.dispose();
    controller.dispose();
  }

  proceedWithAllFunctions() async {
    // HelperFunction.changeSystemUIColor(
    //     Colors.transparent, Colors.transparent);
    //
    // Dialogue.showLoadingDialog();
    await controller.getData(true);
    //Dialogue.dismissLoadingDialog();

  }

  //Form Lists  Page
  void _onRefreshFormLists() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    await controller.getData();
    _refreshControllerForForms.refreshCompleted();


  }
  void _onLoadingFormLIsts() async{
    await Future.delayed(Duration(milliseconds: 1000));
    await controller.getData();
    _refreshControllerForForms.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    HelperFunction.changeSystemUIColor(Colors.white, Colors.white);
    return Obx(() =>
      Scaffold(
        body: Padding(
          padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
          child: Column(
              children: [
                title(),
                FxSpacing.height(20),

            Expanded (
              child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropMaterialHeader(
                    backgroundColor: theme.colorScheme.primary,
                  ),
                  controller: _refreshControllerForForms,
                  onRefresh: _onRefreshFormLists,
                  onLoading: _onLoadingFormLIsts,
                  child: ListView(
                    //controller: _scrollController,
                    padding: FxSpacing.fromLTRB(24, 8, 24, 24),
                    children: [
                      FxSpacing.height(16),
                      Column(
                        children: buildServerEventList(),
                      ),
                    ],
                  ),
                ),
          ),
              ],
            ),
          ),
        ),

    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FxBuilder<HomeController>(
  //       controller: controller,
  //       theme: theme,
  //       builder: (controller) {
  //         return Scaffold(
  //           body: Padding(
  //             padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 children: [
  //                   title(),
  //                   FxSpacing.height(20),
  //                   select(),
  //                   FxSpacing.height(20),
  //                   brand(),
  //                   FxSpacing.height(20),
  //                   categories(),
  //
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }

  Widget title() {
    return Padding(
      padding: FxSpacing.x(20),
      child: Row(
        children: [
          FxContainer(
            paddingAll: 8,
            borderRadiusAll: Constant.containerRadius.medium,
            child: Icon(
              Icons.call_made_sharp,
              size: 20,
            ),
          ),
          FxSpacing.width(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodySmall(
                  "Total profit",
                  xMuted: true,
                ),
                FxText.bodyMedium(
                  controller.totalProfit.toString(),
                  fontWeight: 700,
                ),
              ],
            ),
          ),
          FxContainer.rounded(
            paddingAll: 0,
            height: 40,
            width: 40,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(
                  "assets/images/profile.jpg"),
            ),
          ),
        ],
      ),
    );
  }



  List<Widget> buildServerEventList() {
    List<Widget> list = [];

    for (int i = 0; i < controller.tradeArray.length; i++) {
      list.add(buildServerSingleEvent(controller.tradeArray[i]));

      if (i + 1 < controller.tradeArray.length) list.add(FxSpacing.height(16));
    }
    return list;
  }

  Widget buildServerSingleEvent(OpenTrades openTrades, {bool old = false}) {
    return FxContainer.bordered(
        paddingAll: 16,
        borderRadiusAll: 16,
        child: InkWell(
          onTap: () {

          },
          child: Row(
            children: [
              FxContainer(
                paddingAll: 0,
                borderRadiusAll: 8,
                child: Container(
                  width: 30,
                  height: 30,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Image.asset("assets/images/stock.png",
                      width: 5,
                  ),
                ),
              ),

              FxSpacing.width(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FxText.bodySmall(
                          "Current Price : ",
                          fontWeight: 600
                        ),
                        FxText.bodySmall(
                          openTrades.currentPrice.toString(),
                          xMuted: true,
                        ),
                      ],
                    ),

                    FxSpacing.height(4),
                    Row(
                      children: [
                        FxText.bodySmall(
                            "Open Price : ",
                            fontWeight: 600
                        ),
                        FxText.bodySmall(
                          openTrades.openPrice.toString(),
                          xMuted: true,
                        ),
                      ],
                    ),
                    FxSpacing.height(4),
                    Row(
                      children: [
                        FxText.bodySmall(
                            "Profit : ",
                            fontWeight: 600
                        ),
                        FxText.bodySmall(
                          openTrades.profit.toString(),
                          xMuted: true,
                        ),
                      ],
                    ),
                    FxSpacing.height(4),
                    FxText.bodySmall(
                      HelperFunction.formatDate(DateTime.parse(openTrades.openTime!.toString())),
                      fontSize: 10,
                    ),
                  ],
                ),
              ),
              FxSpacing.width(16),
              // FxContainer.rounded(
              //   paddingAll: 4,
              //   color: customTheme.card,
              //   child: Icon(
              //     old ? Icons.save_outlined : Icons.cloud_done,
              //     size: 16,
              //     color: theme.colorScheme.onBackground,
              //   ),
              // ),
            ],
          ),

        )

    );
  }


}

