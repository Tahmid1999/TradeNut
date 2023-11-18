import 'package:flutter/material.dart';
import 'package:flutx/core/state_management/builder.dart';
import 'package:flutx/core/state_management/controller_store.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/tab_indicator/tab_indicator.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:simple_app/views/profile_screen.dart';
import 'package:simple_app/views/promo_screen.dart';
import 'package:simple_app/views/theme/app_theme.dart';

import '../controller/full_app_controller.dart';
import '../helperFunction/HelperFunction.dart';
import 'home_screen.dart';

class PeanutFullApp extends StatefulWidget {
  const PeanutFullApp({Key? key}) : super(key: key);

  @override
  _PeanutFullAppState createState() => _PeanutFullAppState();
}

class _PeanutFullAppState extends State<PeanutFullApp>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late FullAppController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = FxControllerStore.putOrFind(FullAppController(this));
  }

  List<Widget> buildTab() {
    List<Widget> tabs = [];

    for (int i = 0; i < controller.navItems.length; i++) {
      bool selected = controller.currentIndex == i;
      tabs.add(Column(children: [
        Icon(controller.navItems[i].iconData, size: selected?18:20,
          color: selected ? theme.colorScheme.primary : theme.colorScheme
              .onBackground,),
        FxSpacing.height(selected ? 8 : 0),
        selected ? FxText.bodySmall(controller.navItems[i].title, fontSize: 10,
            color: theme.colorScheme.primary) : Container(),
      ],));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    HelperFunction.changeSystemUIColor(Colors.white, Colors.white);

    return FxBuilder<FullAppController>(
        controller: controller, theme: theme, builder: (controller) {
      return Scaffold(body: Column(children: [
        Expanded(child: TabBarView(controller: controller.tabController,
          children: const <Widget>[
            HomeScreen(),
            PromoScreen(),
            ProfileScreen(),
          ],),),
        FxContainer(
          bordered: true,
          enableBorderRadius: false,
          border: Border(top: BorderSide(
              color: theme.dividerColor, width: 1, style: BorderStyle.solid)),
          padding: FxSpacing.xy(12, 8),
          color: theme.scaffoldBackgroundColor,
          child: TabBar(
            controller: controller.tabController,
            indicator: FxTabIndicator(indicatorColor: theme.colorScheme.primary,
                indicatorHeight: 3,
                radius: 3,
                indicatorStyle: FxTabIndicatorStyle.rectangle,
                yOffset: -10),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: theme.colorScheme.primary,
            tabs: buildTab(),),)
      ],),);
    });
  }
}
