import 'dart:convert';

import 'package:carbon_counter/localization/localizations.dart';
import 'package:carbon_counter/management/management.dart';
import 'package:carbon_counter/models/plan/plan.dart';
import 'package:carbon_counter/ui/dialogs/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:zefyr/zefyr.dart';

import '../../base/themes.dart';

class PlanPage extends StatefulWidget {
  @override
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  AppLocalizations locals;
  AppModel model = AppModel();

  ZefyrController zefyrController;
  FocusNode contentFocusNode;
  FocusNode titleFocusNode;
  TextEditingController titleEdController;
  Plan widgetPlan;

  /// there is two modes for the Plan page :
  /// 1. edit existing plan
  /// 2. create new plan
  /// the defference of the page mode will show [isNewPlan] bool
  bool isNewPllan;

  /// Life Cycle
  @override
  void initState() {
    contentFocusNode = FocusNode();
    titleFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    locals = AppLocalizations.of(context);
    widgetPlan = ModalRoute.of(context).settings.arguments;
    titleEdController = TextEditingController();

    // init zefyr controller
    NotusDocument document = _loadDocument();
    zefyrController = ZefyrController(document);
    isNewPllan = widgetPlan == null;
    if (!isNewPllan) {
      titleEdController.text = widgetPlan.title;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: planContent(),
    );
  }

  /// Actions

  /// if it's a new Plan Item returns an empty Notus document otherwise loads it from the widgets plane item
  NotusDocument _loadDocument() {
    NotusDocument doc;
    if (widgetPlan != null) {
      doc = NotusDocument.fromJson(jsonDecode(widgetPlan.content));
    } else {
      doc = NotusDocument();
    }
    return doc;
  }

  /// checks weather there is a
  Future<void> savePlan() async {
    Dialogs.showLoading();

    if (isNewPllan) {
      String id = Uuid().v4();
      await model.plans.add(
        Plan(
            planId: id,
            title: titleEdController.text.trim(),
            content: jsonEncode(zefyrController.document)),
      );
    } else {
      await model.plans.update(
        Plan(
            planId: widgetPlan.planId,
            title: titleEdController.text.trim(),
            content: jsonEncode(zefyrController.document)),
      );
    }
    Dialogs.hideDialog(context);
    Navigator.of(context).pop();
  }

  /// Widgets
  Widget _appBar() {
    return AppBar(
      centerTitle: true,
      leading: BackButton(color: Theme.of(context).scaffoldBackgroundColor),
      title: title(),
      actions: <Widget>[saveBtn()],
    );
  }

  Widget saveBtn() {
    return FlatButton(
        child: Text(locals.save,
            style: Theme.of(context).primaryTextTheme.headline5.copyWith(
                fontSize: 20,
                color: Theme.of(context).scaffoldBackgroundColor,
                fontFamily: AppThemes.secondaryFontFamily)),
        onPressed: savePlan);
  }

  Widget planContent() {
    return ZefyrScaffold(
      child: ZefyrEditor(
        controller: zefyrController,
        focusNode: contentFocusNode,
        autofocus: !isNewPllan,
      ),
    );
  }

  Widget title() {
    return TextField(
      controller: titleEdController,
      focusNode: titleFocusNode,
      autofocus: isNewPllan,
      expands: false,
      textAlign: TextAlign.center,
      style: Theme.of(context).primaryTextTheme.headline3.copyWith(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
    );
  }
}
