import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/models/category.dart';
import 'package:carbon_counter/ui/form/widgets/category_type/category_type_styles.dart';
import 'package:flutter/material.dart';

class CategoryTypeWidget extends StatelessWidget {
  final Category category;
  final Function onSelect;

  CategoryTypeWidget({
    @required this.category,
    @required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(context) {
    Color color = Theme.of(context).scaffoldBackgroundColor;
    String image;

    switch (category.type) {
      case Measure.Transport:
        color = AppColors.red;
        image = AppImages.transport;
        break;
      case Measure.Travel:
        color = AppColors.blue;
        image = AppImages.travel;
        break;
      case Measure.Electricity:
        color = AppColors.yellow;
        image = AppImages.electricity;
        break;
    }

    return Container(
      decoration: decoration(color),
      margin: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
      ),
      child: InkWell(
        onTap: onSelect,
        child: Container(
              padding: EdgeInsets.all(iconPadding),
              child: Image.asset(image),
            ) ??
            Container(),
      ),
      width: categoryTypeWidgetSize,
      height: categoryTypeWidgetSize,
    );
  }

  BoxDecoration decoration(color) {
    return BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(borderRadius));
  }
}
