import 'package:codefactory_flutter_lv2/gen/fonts.gen.dart';
import 'package:codefactory_flutter_lv2/user/view/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    _App(),
  );
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: FontFamily.notoSans,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
