import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_app/helperFunction/HelperFunction.dart';
import 'package:simple_app/views/theme/app_theme.dart';
import 'package:simple_app/views/theme/constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/home_controller.dart';
import '../controller/promo_controller.dart';
import '../models/OpenTrades.dart';
import '../models/Promo.dart';
import 'Dialogue.dart';
//import '../controller/test_home_controller.dart';

class PromoScreen extends StatefulWidget {
  const PromoScreen({Key? key}) : super(key: key);

  @override
  _PromoScreenState createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  late ThemeData theme;
  late PromoController controller;
  late OutlineInputBorder outlineInputBorder;
  final RefreshController _refreshControllerForForms = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = Get.put(PromoController());

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
    await controller.fetchData(true);
  }

  //Form Lists  Page
  void _onRefreshFormLists() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    await controller.fetchData();
    _refreshControllerForForms.refreshCompleted();


  }
  void _onLoadingFormLIsts() async{
    await Future.delayed(Duration(milliseconds: 1000));
    await controller.fetchData();
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
                          children: buildPromoList(),
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


  List<Widget> buildPromoList() {
    List<Widget> list = [];

    for (int i = 0; i < controller.promoArray.length; i++) {
      list.add(buildServerSingleEvent(controller.promoArray[i]));

      if (i + 1 < controller.promoArray.length) list.add(FxSpacing.height(16));
    }
    return list;
  }

  Widget buildServerSingleEvent(Promo promo) {
    return FxContainer.bordered(
        paddingAll: 16,
        borderRadiusAll: 16,
        child: InkWell(
          onTap: () async {
            final Uri url = Uri.parse(promo.link!);
            if (!await canLaunchUrl(url)) {
              Fluttertoast.showToast(
                  msg: "Could not launch $url",
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
            await launchUrl(url);
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
                  child: CachedNetworkImage(
                    imageUrl: promo.image!,
                    placeholder: (context, url) => CircularProgressIndicator(),
                  ),
                ),
              ),

              FxSpacing.width(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText.bodySmall(
                        promo.key!,
                        fontWeight: 600
                    ),

                    FxSpacing.height(4),
                    FxText.bodySmall(
                        promo.text!,
                    ),
                  ],
                ),
              ),
              //FxSpacing.width(16),
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