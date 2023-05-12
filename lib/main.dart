import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/constant.dart';
import 'package:money_management/models/money.dart';
import 'package:money_management/screens/home.dart';
import 'package:money_management/screens/main.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoneyAdapter());
  await Hive.openBox<Money>('moneyBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static void getData() {
    HomeScreen.moneys.clear();
    Box<Money> hiveBox = Hive.box('moneyBox');
    for (var value in hiveBox.values) {
      HomeScreen.moneys.add(value);
    }
  }

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مدیریت تراکنش ها',
      theme: ThemeData(
        fontFamily: 'Aban',
        primaryColor: cIndigoColor,
        scaffoldBackgroundColor: Colors.grey.shade200,
      ),
      home: const MainScreen(),
    );
  }
}
