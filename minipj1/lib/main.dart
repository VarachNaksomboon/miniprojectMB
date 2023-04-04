import 'package:flutter/material.dart';
import 'package:minipj1/login.dart';
import 'package:minipj1/orders.dart';
import 'package:minipj1/register.dart';
import 'package:minipj1/homepage.dart';
import 'package:minipj1/food.dart';
import 'package:minipj1/appetizers.dart';
import 'package:minipj1/desserts.dart';
import 'package:minipj1/beverages.dart';
import 'package:minipj1/orders.dart';
import 'package:minipj1/reviewpage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp();
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/homepage': (context) => Homepage(),
        '/login': (context) => LoginPage(),
        '/food': (context) => FoodPage(),
        '/appetizers': (context) => AppetizerPage(),
        '/desserts': (context) => DessertPage(),
        '/beverages': (context) => BeveragePage(),
        '/orders': (context) => OrderPage(),
        '/reviewpage': (context) => ReviewPage(),
      },
    );
  }
}
