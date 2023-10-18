import 'package:flutter/material.dart';
import 'package:flutter_blog/ui/pages/auth/login_page/widgets/login_body.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardDismissOnTap(
        dismissOnCapturedTaps: true,
        child: LoginBody(),
      ),
    );
  }
}
