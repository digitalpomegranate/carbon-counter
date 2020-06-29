import 'dart:async';

import 'package:carbon_counter/management/management.dart';
import 'package:carbon_counter/models/plan/plan.dart';
import 'package:carbon_counter/ui/plans/styles.dart';
import 'package:carbon_counter/ui/plans/widgets/plan_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base/routes.dart';
import '../../localization/localizations.dart';

class PlansSummaryPage extends StatefulWidget {
  @override
  _PlansSummaryPageState createState() => _PlansSummaryPageState();
}

class _PlansSummaryPageState extends State<PlansSummaryPage> {
  AppLocalizations locals;
  ThemeData theme;
  AppModel model = AppModel();
  StreamSubscription planDataSubscription;
  List<Plan> planData;

  /// Life Cycle

  @override
  void initState() {
    model.plans.getPlans();
    planDataSubscription =
        model.plans.planList.stream.listen(handlePlanDataChange);
    super.initState();
  }

  @override
  void dispose() {
    planDataSubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    locals = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Dialogs.hideDialog(context);
    return Scaffold(
      appBar: _appBar(),
      body: plansSummaryBody(),
      floatingActionButton: addBtn(),
    );
  }

  /// Stream listeners
  void handlePlanDataChange(List<Plan> newData) {
    setState(() {
      planData = newData;
    });
  }

  /// Actions

  /// Widgets

  Widget _appBar() {
    return AppBar(
      centerTitle: true,
      leading: BackButton(color: theme.scaffoldBackgroundColor),
      title: Text(
        locals.plans,
        style: theme.primaryTextTheme.headline3.copyWith(
          color: theme.scaffoldBackgroundColor,
        ),
      ),
    );
  }

  Widget plansSummaryBody() {
    return planData == null
        ? Container()
        : planData.isEmpty
            ? Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Text(
                 locals.noPlansText,
                  style: Theme.of(context).primaryTextTheme.headline4,
                  textAlign: TextAlign.center,
                ))
            : Container(
                height: screenHeight,
                width: screenWidth,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: planData.length,
                  itemBuilder: (context, index) {
                    return PlanItem(
                      plan: planData[index],
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.plan,
                            arguments: planData[index]);
                      },
                    );
                  },
                ),
              );
  }

  Widget addBtn() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.plan);
      },
      backgroundColor: theme.primaryColor,
    );
  }
}
