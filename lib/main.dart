import 'package:finance_forum/controllers/auth_controller.dart';
import 'package:finance_forum/controllers/add_stock_controller.dart';
import 'package:finance_forum/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'controllers/profile_controller.dart';

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
