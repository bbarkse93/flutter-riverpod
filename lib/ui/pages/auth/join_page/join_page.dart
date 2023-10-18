import 'package:flutter/material.dart';
import 'package:flutter_blog/ui/pages/auth/join_page/widgets/join_body.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardDismissOnTap(
        dismissOnCapturedTaps: true,
        child: JoinBody(),
      ),
    );
  }
}
