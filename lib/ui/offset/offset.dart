import 'package:carbon_counter/localization/localizations.dart';
import 'package:flutter/material.dart';

class OffsetPage extends StatefulWidget {
  @override
  _OffsetPageState createState() => _OffsetPageState();
}

class _OffsetPageState extends State<OffsetPage> {
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
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text(
        locals.offset,
        style: Theme.of(context).primaryTextTheme.headline3.copyWith(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
      ),
      centerTitle: true,
      leading: BackButton(color: Theme.of(context).scaffoldBackgroundColor),
    );
  }
}
