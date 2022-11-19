// ignore_for_file: avoid_print

import 'package:finance_forum/controllers/auth_controller.dart';
import 'package:finance_forum/controllers/add_stock_controller.dart';
import 'package:finance_forum/controllers/post_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'controllers/profile_controller.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthController>(
      create: (context) => AuthController(),
    ),
    ChangeNotifierProvider<ProfileController>(
      create: (context) => ProfileController(),
    ),
    ChangeNotifierProvider<AddStockController>(
        create: (context) => AddStockController()),
    ChangeNotifierProvider<PostController>(
        create: (context) => PostController())
  ], builder: (context, child) => const MyApp()));
  print(await FirebaseInstallations.instance.getId());
  print(await FirebaseMessaging.instance.getToken());
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId('d2170fac-5b53-4027-b364-bb0fd026fa49');

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData.light().copyWith(primaryColor: Colors.blueGrey),
        darkTheme: ThemeData.dark(),
        themeMode: Provider.of<AuthController>(context).mode,
        debugShowCheckedModeBanner: false,
        home: statePersist());
  }
}
