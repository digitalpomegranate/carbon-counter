import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/ui/form/widgets/input_field/input_field_styles.dart';
import 'package:flutter/material.dart';
import 'input_field_styles.dart';

class InputField extends StatefulWidget {
  /// Because there are no other title fields
  /// [hintText] is playing a role of input field title.
  final String hintText;

  /// Not all the fields should have suffix icon,
  /// [obscureText] controls whether field has one
  /// this field should be true for password fields.
  final bool obscureText;

  /// Creates a controller for an editable text field.
  final TextEditingController textEditingController;

  /// The type of information for which to optimize the text input control.
  /// For example it provides better keyboard layout for email fields.
  final TextInputType keyboardType;

  /// If the user enters valid text, the TextField appears normally without any warnings to the user.
  /// If the user enters invalid text, the error message returned from the validator function is
  /// displayed in dark red underneath the input.
  final String Function() validator;

  const InputField({
    Key key,
    @required this.hintText,
    @required this.obscureText,
    @required this.textEditingController,
    @required this.keyboardType,
    this.validator,
  }) : super(key: key);
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  /// Controls the hiding of inputed text in the password fields.
  bool obscureText;

  /// Horizontal padding changes to correspond the selected mode.
  double horizontalPaddingValue;

  /// ThemeData object
  ThemeData theme;

  /// MediaQuery data.
  MediaQueryData mediaQuery;

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    mediaQuery = MediaQuery.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget?.textEditingController?.clear();
    super.dispose();
  }

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaQuery.size.width * inputFiledWidthFactor,
      margin: EdgeInsets.only(
        top: marginHorizontal,
        bottom: marginHorizontal,
      ),
      child: TextFormField(
        controller: widget.textEditingController,
        obscureText: obscureText,
        style: theme.primaryTextTheme.headline6.copyWith(
          color: Theme.of(context).accentColor,
          fontFamily: AppThemes.secondaryFontFamily,
          fontWeight: AppThemes.FONTWEIGHT_LIGHT,
        ),
        validator: (String value) {
          if (widget?.validator != null) {
            return widget.validator();
          }
          return null;
        },
        cursorColor: Theme.of(context).primaryColor,
        cursorWidth: cursorWidth,
        enableSuggestions: true,
        autocorrect: false,
        decoration: inputDecoration(),
      ),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      contentPadding:
          EdgeInsets.only(left: contentPaddingLeft, right: contentPaddingRight),
      filled: true,
      focusColor: Theme.of(context).primaryColor,
      hintText: widget.hintText,
      hintStyle: theme.primaryTextTheme.headline6.copyWith(
        color: Theme.of(context).accentColor,
      ),
      suffixIcon: widget.obscureText ? suffix() : null,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.all(inputFiledCircleBorderRaius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(inputFiledCircleBorderRaius),
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.all(inputFiledCircleBorderRaius),
      ),
    );
  }

  Widget suffix() {
    return GestureDetector(
      onTap: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
      child: Icon(
        obscureText ? Icons.visibility : Icons.visibility_off,
        size: iconSize,
        color: theme.primaryColor,
      ),
    );
  }
}
