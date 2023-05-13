import 'package:firebase_auth/firebase_auth.dart';
import 'package:flixer/src/signIn/google_signIn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/constants.dart';
import 'home_page.dart';
import 'signUp_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  dynamic userData = {};

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appName,
          theme: AppTheme.dark,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(180, 0, 0, 1),
                  ),
                );
              } else if (snapshot.hasData) {
                return HomePage(
                  userData: userData,
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong!'),
                );
              } else {
                return SignUpPage(
                  setUserData: (data) {
                    setState(() {
                      userData = data;
                    });
                  },
                );
              }
            },
          )));
}
