import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'src/app.dart';

// void main() => runApp(const App());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(

      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => const App(), // Wrap your app
      // ),
      const App());
}
