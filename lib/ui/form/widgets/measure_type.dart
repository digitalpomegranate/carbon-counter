import 'package:carbon_counter/base/base.dart';
import 'package:flutter/material.dart';

class MeasureTypeWidget extends StatelessWidget {
  final Function() onSelect;
  final String categoryType;

  MeasureTypeWidget({
    @required this.onSelect,
    @required this.categoryType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListTile(
        onTap: onSelect,
        title: Text(
          categoryType ?? '',
          style: Theme.of(context).primaryTextTheme.headline5.copyWith(
              color: Theme.of(context).scaffoldBackgroundColor,
              fontWeight: AppThemes.FONTWEIGHT_BOLD),
        ),
      ),
    );
  }
}
