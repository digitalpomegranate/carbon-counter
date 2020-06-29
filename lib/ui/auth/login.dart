import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/base/images.dart';
import 'package:carbon_counter/base/routes.dart';
import 'package:carbon_counter/localization/localizations.dart';
import 'package:carbon_counter/management/management.dart';
import 'package:carbon_counter/ui/auth/auth_styles.dart';
import 'package:carbon_counter/ui/dialogs/dialogs.dart';
import 'package:carbon_counter/ui/form/widgets/input_field/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth_styles.dart';

class LoginPage extends StatefulWidget {
  final Function moveToRegister;

  const LoginPage({@required this.moveToRegister});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<LoginPage> {
  ThemeData theme;
  AppLocalizations locals;

  TextEditingController emailController;
  TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  AppModel _appModel = AppModel();

  @override
  void initState() {
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
      body: body(),
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
                loginButton(),
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
      child: Image.asset(AppImages.logo),
    );
  }

  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: titleMarginBottom),
      child: Text(
        locals.login,
        style: theme.primaryTextTheme.headline4,
      ),
    );
  }

  Widget inputFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          InputField(
            hintText: locals.email,
            obscureText: false,
            textEditingController: emailController,
            keyboardType: TextInputType.number,
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

  Widget loginButton() {
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
          locals.login,
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
          _actionSignIn();
        },
      ),
    );
  }

  Future _actionSignIn() async {
    Dialogs.showLoading();
    String errorMessage = await _appModel.users.signIn(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
    Dialogs.hideDialog(context);

    if (errorMessage == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
    } else {
      print(errorMessage);

      Dialogs(locals.errorDuringSignIn, errorMessage).show();
    }
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
        onPressed: widget.moveToRegister,
      ),
    );
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
}
