import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_management/screens/home.dart';
import 'package:money_management/screens/info.dart';
import 'package:money_management/widgets/main/floating_action_button.dart';

import '../constant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  Widget body = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: body,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          height: 75,
          backgroundColor: cIndigoColor,
          inactiveColor: Colors.white54,
          activeColor: Colors.white,
          icons: const [Icons.home, Icons.insert_chart_rounded],
          iconSize: 30,
          activeIndex: currentIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          onTap: (index) {
            if (index == 0) {
              body = const HomeScreen();
            } else {
              body = const InfoScreen();
            }
            setState(() {
              currentIndex = index;
            });
          },
        ),
        floatingActionButton: const MainFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
    ;
  }
}
