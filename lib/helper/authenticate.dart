import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/sign_up_general.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ? LoginScreen(toggleView) : SignUpGeneral(toggleView);
  }
}