import 'package:carbon_counter/ui/auth/auth_styles.dart';
import 'package:carbon_counter/ui/auth/login.dart';
import 'package:carbon_counter/ui/auth/registration.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  PageController pageController;

  int currentPageIndex = 0;

  @override
  void initState() {
    pageController = PageController(
      initialPage: currentPageIndex,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        children: [
          LoginPage(moveToRegister: moveToRegister),
          RegistrationPage(moveToLogin: moveToLogin),
        ],
      ),
    );
  }

  void moveToLogin() async {
    currentPageIndex = 0;
    await pageController.animateToPage(
      currentPageIndex,
      duration: pageControllerAnimationDuration,
      curve: pageControllerAnimationCurve,
    );
  }

  void moveToRegister() async {
    currentPageIndex = 1;
    await pageController.animateToPage(
      currentPageIndex,
      duration: pageControllerAnimationDuration,
      curve: pageControllerAnimationCurve,
    );
  }
}
