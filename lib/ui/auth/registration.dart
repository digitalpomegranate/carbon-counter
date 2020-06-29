import 'package:carbon_counter/base/images.dart';
import 'package:carbon_counter/base/routes.dart';
import 'package:carbon_counter/base/themes.dart';
import 'package:carbon_counter/base/validators.dart';
import 'package:carbon_counter/localization/localizations.dart';
import 'package:carbon_counter/management/management.dart';
import 'package:carbon_counter/ui/auth/auth_styles.dart';
import 'package:carbon_counter/ui/dialogs/dialogs.dart';
import 'package:carbon_counter/ui/form/widgets/input_field/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  final Function moveToLogin;
  const RegistrationPage({@required this.moveToLogin});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  ThemeData theme;
  AppLocalizations locals;
  TextEditingController companyNameController;
  TextEditingController fullNameController;
  TextEditingController roleController;
  TextEditingController emailController;
  TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  AppModel _appModel = AppModel();
  @override
  void initState() {
    companyNameController = TextEditingController();
    fullNameController = TextEditingController();
    roleController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    locals = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          backButton(),
          body(),
        ],
      ),
    );
  }

  Widget body() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          logo(),
          pageTitle(),
          Expanded(
            child: Column(
              children: <Widget>[
                inputFields(),
                registerButton(),
              ],
            ),
          ),
          footer()
        ],
      ),
    );
  }

  Widget logo() {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + logoMarginTop,
        bottom: logoMarginBottom,
      ),
      child: Image.asset( AppImages.logo),
    );
  }

  Widget pageTitle() {
    return Text(
      locals.register,
      style: theme.primaryTextTheme.headline4,
    );
  }

  Widget inputFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          InputField(
            hintText: locals.companyName,
            obscureText: false,
            textEditingController: companyNameController,
            keyboardType: TextInputType.text,
            validator: () {
              return InputValidators()
                  .isNotEmpty(text: companyNameController.text);
            },
          ),
          InputField(
            hintText: locals.fullName,
            obscureText: false,
            textEditingController: fullNameController,
            keyboardType: TextInputType.text,
            validator: () {
              return InputValidators()
                  .isNotEmpty(text: fullNameController.text);
            },
          ),
          InputField(
              hintText: locals.role,
              obscureText: false,
              textEditingController: roleController,
              keyboardType: TextInputType.text,
              validator: () {
                return InputValidators().isNotEmpty(text: roleController.text);
              }),
          InputField(
            hintText: locals.email,
            obscureText: false,
            textEditingController: emailController,
            keyboardType: TextInputType.text,
            validator: () {
              return InputValidators().email(email: emailController.text);
            },
          ),
          InputField(
            hintText: locals.password,
            obscureText: true,
            textEditingController: passwordController,
            keyboardType: TextInputType.text,
            validator: () {
              return InputValidators()
                  .password(password: passwordController.text);
            },
          ),
        ],
      ),
    );
  }

  Widget registerButton() {
    return Container(
      height: buttonHeight,
      width: buttonWidth,
      margin: EdgeInsets.only(top: buttonMarginTop),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          theme.primaryColor.withOpacity(AppThemes.OPACITY_MIDDLE),
          theme.primaryColor,
        ]),
        borderRadius: BorderRadius.all(
          Radius.circular(buttonBorderRadius),
        ),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Text(
          locals.register,
          style: theme.primaryTextTheme.headline6.copyWith(
            color: theme.scaffoldBackgroundColor,
            fontWeight: AppThemes.FONTWEIGHT_BOLD,
          ),
        ),
        onPressed: () {
          // Check form validity.
          bool _formIsValid = _formKey.currentState.validate();

          // If form is not valid, break function.
          if (!_formIsValid) return;

          _actionSignUP();
        },
      ),
    );
  }

  Future _actionSignUP() async {
    Dialogs.showLoading();
    String errorMessage = await _appModel.users.createUser(
      email: emailController.text.trim(),
      password: passwordController.text,
      role: roleController.text.trim(),
      companyName: companyNameController.text.trim(),
      fullname: fullNameController.text.trim(),
    );
    Dialogs.hideDialog(context);
    if (errorMessage == null) {
      await Dialogs(locals.attention, locals.verifyEmail).show();
      Navigator.of(context).pushNamed(AppRoutes.auth);
    } else {
      Dialogs(locals.errorDuringSignUp, errorMessage).show();
    }
  }

  Widget footer() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + footerMarginBottom),
      child: Image.asset(
        AppImages.hack20,
        width: hack20width,
        height: hack20height,
      ),
    );
  }

  ///
  /// Builds back Button at the top left side of the device.
  /// Has static position from left, and dynamic position
  /// from top depending on device's status bar and the notch's size(if present).
  ///
  Widget backButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + backButtonPadding,
      left: backButtonPadding,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.moveToLogin,
          child: Container(
            padding: EdgeInsets.all(backButtonPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  color: theme.primaryColor,
                  size: backIconSize,
                ),
                Text(
                  locals.back,
                  style: theme.primaryTextTheme.headline5.copyWith(
                      color: theme.primaryColor,
                      fontWeight: AppThemes.FONTWEIGHT_BOLD),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
