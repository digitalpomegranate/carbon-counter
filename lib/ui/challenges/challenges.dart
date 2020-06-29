import 'package:carbon_counter/localization/localizations.dart';
import 'package:carbon_counter/management/management.dart';
import 'package:carbon_counter/ui/challenges/widgets/challenge.dart';
import 'package:flutter/material.dart';

class ChallengesPage extends StatefulWidget {
  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  AppLocalizations locals;
  ThemeData theme;

  @override
  void initState() {
    AppModel().challenges.getChallenges();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    locals = AppLocalizations.of(context);
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  Widget appBar() {
    return AppBar(
      title: Text(
        locals.challenges,
        style: theme.primaryTextTheme.headline3.copyWith(
          color: theme.scaffoldBackgroundColor,
        ),
      ),
      centerTitle: true,
      leading: BackButton(color: theme.scaffoldBackgroundColor),
    );
  }

  Widget body() {
    return StreamBuilder(
      stream: AppModel().challenges.challenges.stream,
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: AppModel().challenges?.challenges?.stream?.value?.toList()?.length ??  0,
          itemBuilder: (BuildContext context, int index) {
            return ChallengeItem(
              challenge: AppModel().challenges.challenges.stream.value[index],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }
}
