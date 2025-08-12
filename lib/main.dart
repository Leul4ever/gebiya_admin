import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gebiya_web_admin/views/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // The OR operator in Dart is ||
  await Firebase.initializeApp(
    options: kIsWeb
        ? const FirebaseOptions(
            apiKey: "AIzaSyBJoSE8RjuIzfyR9fSNELgIHKiq1Ny0VxA",
            appId: "1:602464933285:web:d56635d44a21afef6e044c",
            messagingSenderId: "602464933285",
            projectId: "job-connect-d8fa7",
            storageBucket: "job-connect-d8fa7.appspot.com",
          )
        : null,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       primarySwatch: Colors.blue
      ),
      home: const MainScreen(),
    );
  }
}

