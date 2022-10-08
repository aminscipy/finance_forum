import 'package:finance_forum/controller.dart';
import 'package:finance_forum/screens/complete_profile.dart';
import 'package:finance_forum/screens/otp_verify.dart';
import 'package:finance_forum/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance_forum/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (context) => Controller(),
        builder: (context, child) => const MyApp())
  ]));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: Provider.of<Controller>(context).mode,
        debugShowCheckedModeBanner: false,
        home: const Welcome());
  }
}
