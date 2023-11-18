import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:simple_app/views/theme/app_theme.dart';
import 'package:simple_app/views/theme/constant.dart';

import '../controller/profile_controller.dart';
import '../helperFunction/HelperFunction.dart';
import 'login_screen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ThemeData theme;
  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = Get.put(ProfileController());

    proceedWithAllFunctions();

  }
  proceedWithAllFunctions() async {
    await controller.getAccountInformation();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HelperFunction.changeSystemUIColor(Colors.white, Colors.white);
    return Obx(() => Scaffold(
      body: Padding(
        padding: FxSpacing.fromLTRB(
          20,
          FxSpacing.safeAreaTop(context) + 20,
          20,
          20,
        ),
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
          children: [
            profile(),
            FxSpacing.height(20),
            statistics(),
            FxSpacing.height(32),
            Expanded(
              child: ListView(
                children: [
                  singleRow(FeatherIcons.map, "Address", controller.address.value),
                  singleRow(
                    FeatherIcons.mapPin,
                    "City & Country",
                    "${controller.city.value}, ${controller.country.value}",
                  ),
                  singleRow(FeatherIcons.navigation, "Zip Code", controller.zipCode.value),
                  singleRow(
                    Icons.call_made_sharp,
                    "Current Trades Count",
                    controller.currentTradesCount.value.toString(),
                  ),
                  singleRow(
                    Icons.call_made_sharp,
                    "Current Trades Volume",
                    controller.currentTradesVolume.value.toString(),
                  ),
                  singleRow(Icons.wallet_travel, "Equity", controller.equity.value.toString()),
                  singleRow(
                    Icons.call_made_sharp,
                    "Total Trades Count",
                    controller.totalTradesCount.value.toString(),
                  ),
                  singleRow(
                    Icons.call_made_sharp,
                    "Total Trades Volume",
                    controller.totalTradesVolume.value.toString(),
                  ),
                ],
              ),
            ),
            FxSpacing.height(8),
            FxContainer(
              color: theme.colorScheme.primary.withAlpha(28),
              borderRadiusAll: 4,
              child: FxText.bodyMedium(
                "© 2023 Designed & Developed by Tahmid",
                textAlign: TextAlign.center,
                fontWeight: 600,
                letterSpacing: 0.2,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        )
            : ListView(
          children: [
            profile(),
            FxSpacing.height(20),
            statistics(),
            FxSpacing.height(32),
            singleRow(FeatherIcons.map, "Address", controller.address.value),
            singleRow(
              FeatherIcons.mapPin,
              "City & Country",
              "${controller.city.value}, ${controller.country.value}",
            ),
            singleRow(FeatherIcons.navigation, "Zip Code", controller.zipCode.value),
            singleRow(
              Icons.call_made_sharp,
              "Current Trades Count",
              controller.currentTradesCount.value.toString(),
            ),
            singleRow(
              Icons.call_made_sharp,
              "Current Trades Volume",
              controller.currentTradesVolume.value.toString(),
            ),
            singleRow(Icons.wallet_travel, "Equity", controller.equity.value.toString()),
            singleRow(
              Icons.call_made_sharp,
              "Total Trades Count",
              controller.totalTradesCount.value.toString(),
            ),
            singleRow(
              Icons.call_made_sharp,
              "Total Trades Volume",
              controller.totalTradesVolume.value.toString(),
            ),
            FxSpacing.height(8),
            FxContainer(
              color: theme.colorScheme.primary.withAlpha(28),
              borderRadiusAll: 4,
              child: FxText.bodyMedium(
                "© 2023 Designed & Developed by Tahmid",
                textAlign: TextAlign.center,
                fontWeight: 600,
                letterSpacing: 0.2,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget profile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align children at both ends
      children: [
        FxContainer.rounded(
          height: 80,
          paddingAll: 0,
          child: Image(
            image: AssetImage("assets/images/profile.jpg"),
          ),
        ),
        FxSpacing.width(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FxText.titleMedium(
                controller.name.value,
                fontWeight: 700,
                //color: theme.colorScheme.onPrimary,
              ),
              FxSpacing.height(4),
              FxText.bodySmall(
                controller.phone.value,
                xMuted: true,
              ),
            ],
          ),
        ),
        FxButton.small(
          padding: FxSpacing.xy(16, 8),
          elevation: 0,
          onPressed: () async {
            //controller.goBack();
            const storage = FlutterSecureStorage();
            await storage.deleteAll();
            Get.offAll(const LoginScreen());
          },
          child: FxText.labelLarge(
            "Logout",
            fontWeight: 700,
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }

  Widget statistics() {
    return Row(
      children: [
        Expanded(
          child: FxContainer(
            padding: FxSpacing.xy(24, 16),
            color: theme.colorScheme.primaryContainer,
            borderRadiusAll: Constant.containerRadius.small,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.wallet,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                FxSpacing.height(8),
                FxText.headlineSmall(
                  controller.balance.value.toString(),
                  fontWeight: 700,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                FxText.bodySmall(
                  "Total Balance",
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ],
            ),
          ),
        ),
        FxSpacing.width(20),
        Expanded(
          child: FxContainer(
            padding: FxSpacing.xy(24, 16),
            color: theme.colorScheme.primaryContainer,
            borderRadiusAll: Constant.containerRadius.small,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.call_made_sharp,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                FxSpacing.height(8),
                FxText.headlineSmall(
                  controller.totalTradesCount.value.toString(),
                  fontWeight: 700,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                FxText.bodySmall(
                  "Total Trades",
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget singleRow(IconData icon, String title, [String? value]) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
            ),
            FxSpacing.width(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodyMedium(
                  title,
                  fontWeight: 600,
                ),
                value != null ? FxText.bodySmall(
                  value,
                  xMuted: true,
                ): Container(),
              ],
            ),
          ],
        ),

        FxSpacing.height(6),
        Divider(),
        FxSpacing.height(4),
      ],
    );
  }

  Widget logout() {
    return FxButton.small(
        padding: FxSpacing.xy(16, 8),
        elevation: 0,
        onPressed: () {
          //controller.goBack();
        },
        child: FxText.labelLarge(
          "Logout",
          fontWeight: 700,
          color: theme.colorScheme.onPrimary,
        ));
  }
}
