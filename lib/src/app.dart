import 'package:flutter/material.dart';

import 'core/constants/constants.dart';
import 'home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: AppTheme.dark,
      home: const HomePage(),
    );
  }
}
