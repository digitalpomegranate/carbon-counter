import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/localization/localizations.dart';
import 'package:carbon_counter/management/management.dart';
import 'package:carbon_counter/models/calculation.dart';
import 'package:carbon_counter/models/category.dart';
import 'package:carbon_counter/ui/dialogs/dialogs.dart';
import 'package:carbon_counter/ui/flare/flare.dart';
import 'package:carbon_counter/ui/form/form_page_styles.dart';
import 'package:carbon_counter/ui/form/widgets/category_type/category_type_widget.dart';
import 'package:carbon_counter/ui/form/widgets/custom_dropdown.dart';
import 'package:carbon_counter/ui/form/widgets/dropdown_header.dart';
import 'package:carbon_counter/ui/form/widgets/input_field/input_field.dart';
import 'package:carbon_counter/ui/form/widgets/measure_type.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool dropdownState;
  Category selectedCategory;
  String selectedCategoryType;
  String message;
  GlobalKey headerGlobalKey;
  double dropdownPrreferedHeight;
  TextEditingController textEditingController;
  CalculationAnimationType animationType;
  FlareControls flareController;
  bool animate;

  @override
  void initState() {
    getCategories();
    dropdownState = false;
    headerGlobalKey = GlobalKey();
    textEditingController = TextEditingController();
    animate = false;
    animationType = CalculationAnimationType.Good;
    flareController = FlareControls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      appBar: appBar(),
      body: Column(children: [
        categoriesWidget(),
        Expanded(
          child: Stack(
            children: [

              
              animationWidget(),
              
              messageWidget(),
              inputField(),
              calculateButton(),
              dropdownChildren(),
            ],
          ),
        ),
      ]),
    );
  }

  Widget animationWidget() {
    return Align(
      alignment: Alignment.center,
      child: FlareAnimation(
        flareController: flareController,
        animate: animate,
        animationType: animationType,
      ),
    );
  }

  Widget messageWidget() {
    if(MediaQuery.of(context).viewInsets.bottom > 0) return Container();
    return Align(
      alignment: Alignment(0, 0.5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: AnimatedDefaultTextStyle(
          child: Text(message ?? ''),
          style: Theme.of(context).primaryTextTheme.subtitle1.copyWith(
            fontWeight: AppThemes.FONTWEIGHT_BOLD,
          ),
          duration: animationDuration,
        ),
      ),
    );
  }

  Widget calculateButton() {
    return Align(
      alignment: Alignment(0, 0.95),
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        margin: EdgeInsets.only(top: buttonMarginTop),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context)
                .primaryColor
                .withOpacity(AppThemes.OPACITY_MIDDLE),
            Theme.of(context).primaryColor,
          ]),
          borderRadius: BorderRadius.all(
            Radius.circular(buttonBorderRadius),
          ),
        ),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(
            AppLocalizations().calculate,
            style: Theme.of(context).primaryTextTheme.headline6.copyWith(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontWeight: AppThemes.FONTWEIGHT_BOLD,
                ),
          ),
          onPressed: () async {
            if (textEditingController.text.isNotEmpty &&
                selectedCategoryType != null) {
              Dialogs.showLoading();
              Calculation calculation = await AppModel().calculations.calculate(
                    category: selectedCategory.id,
                    formulaName: selectedCategoryType,
                    distance: textEditingController.text,
                    kw: textEditingController.text,
                  );
              Dialogs.hideDialog(context);

              if (calculation != null) {
                animationType = calculation.animationType;
                message = calculation.message;
              }

              Future.delayed(Duration(milliseconds: 500), () {
                setState(() {
                  animate = true;
                  flareController.play(enumToString(calculation.animationType));
                });
              });
            }
          },
        ),
      ),
    );
  }

  Widget categoriesWidget() {
    return Container(
      height: categoriesSectionHeight,
      margin: EdgeInsets.only(top: categoriesSectionMarginTop),
      child: StreamBuilder(
        stream: AppModel().categories.categoriesStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
          Widget child = Container();

          if (snapshot?.hasData ?? false) {
            selectedCategory ??= snapshot.data.first;
            child = ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return CategoryTypeWidget(
                  category: snapshot.data[index],
                  onSelect: () {
                    if (mounted) {
                      setState(() {
                        selectedCategory = snapshot.data[index];
                        selectedCategoryType = null;
                      });
                    }
                  },
                );
              },
            );
          }
          return child;
        },
      ),
    );
  }

  Widget inputField() {
    return Align(
      alignment: Alignment(0, 0.7),
      child: InputField(
        obscureText: false,
        hintText: AppLocalizations().distance,
        keyboardType: TextInputType.number,
        textEditingController: textEditingController,
      ),
    );
  }

  Widget dropdown({
    @required List<Widget> children,
  }) {
    getScreenBottomHeight();
    return Container(
      padding: EdgeInsets.all(dropdownPaddingAll),
      margin: EdgeInsets.symmetric(vertical: dropdownMarginVertical),
      child: CustomDropdown(
        kExpand: animationDuration,
        initiallyExpanded: dropdownState,
        onExpansionChanged: (bool value) {
          if (mounted)
            setState(() {
              dropdownState = value;
            });
        },
        childOnTap: () {},
        dropdownPrreferedHeight: dropdownPrreferedHeight,
        header: Container(
          key: headerGlobalKey,
          child: DropdownHeader(
            category: selectedCategory,
            selectedType: selectedCategoryType,
            isExpanded: dropdownState,
            animationDuration: animationDuration,
          ),
        ),
        children: children,
      ),
    );
  }

  void getScreenBottomHeight() {
    if (dropdownPrreferedHeight == null) {
      Future.delayed(Duration(milliseconds: 300), () {
        if (headerGlobalKey?.currentContext == null) return;
        RenderBox box = headerGlobalKey.currentContext.findRenderObject();

        Offset _offset = box.localToGlobal(Offset.zero);
        dropdownPrreferedHeight = MediaQuery.of(context).size.height -
            _offset.dy -
            65 -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom;
        if (mounted) setState(() {});
      });
    }
  }

  Widget dropdownChildren() {
    List<Widget> children = List.generate(
      selectedCategory?.types?.length ?? 0,
      (index) => MeasureTypeWidget(
        categoryType: selectedCategory.types[index],
        onSelect: () {
          if (mounted)
            setState(() {
              selectedCategoryType = selectedCategory.types[index];
              dropdownState = false;
            });
        },
      ),
    );

    return Positioned(
      top: positiontop,
      left: positionLeft,
      right: positionRight,
      child: dropdown(children: children),
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text(
        selectedCategory?.id ?? '',
        style: Theme.of(context).primaryTextTheme.headline3.copyWith(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
      ),
      centerTitle: true,
      leading: BackButton(color: Theme.of(context).scaffoldBackgroundColor),
    );
  }

  Future getCategories() async {
    await AppModel().categories.getCategories();
  }
}
