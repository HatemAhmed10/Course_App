import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:course_app/presentation/screens/1authentication/1welcome_Screen/welcome_view.dart';
import 'package:course_app/presentation/screens/2course_Screen/course_view.dart';
import 'package:course_app/shared/network/cache_helper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Widget widget;

  var UserUID = CacheHelper.getData(key: 'User_UID');

  if (UserUID == null) {
    widget = Welcome_View();
  } else {
    widget = course_view();
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: startWidget,
    );
  }
}
