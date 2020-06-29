import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/base/colors.dart';
import 'package:carbon_counter/ui/dialogs/dialogs.dart';
import 'package:carbon_counter/ui/home/home_page_styles.dart';
import 'package:carbon_counter/ui/home/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import './widgets/menu_item.dart';
import '../../localization/localizations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppLocalizations locals;
  ThemeData theme;

  @override
  void didChangeDependencies() {
    locals = AppLocalizations.of(context);
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: menu(),
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text(
        locals.carbonCounter,
        style: Theme.of(context).primaryTextTheme.headline3.copyWith(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
      ),
      centerTitle: true,
    );
  }

  Widget menu() {
    return Container(
      margin: EdgeInsets.only(
        top: topMargin,
        left: gridMarginHorizontal,
        right: gridMarginHorizontal,
      ),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        children: <Widget>[
          MenuItem(
            color: AppColors.verdunGreen,
            image: AppImages.measure,
            title: locals.measure,
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.measure);
            },
          ),
          MenuItem(
            color: AppColors.cornflower,
            image: AppImages.plan,
            title: locals.plan,
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.plansSummary);
            },
          ),
          MenuItem(
            color: AppColors.supernova,
            image: AppImages.reduce,
            title: locals.reduce,
            onTap: () {
              Dialogs.showCommingSoonDialog();
            },
          ),
          MenuItem(
            color: AppColors.zest,
            image: AppImages.play,
            title: locals.play,
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.play);
            },
          ),
          MenuItem(
            color: AppColors.carnation,
            image: AppImages.offset,
            title: locals.offset,
            onTap: () {
              Dialogs.showCommingSoonDialog();
            },
          ),
          MenuItem(
            color: AppColors.easternBlue,
            image: AppImages.comply,
            title: locals.comply,
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.comply);
            },
          ),
        ],
      ),
    );
  }
}
