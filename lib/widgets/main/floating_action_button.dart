import 'package:flutter/material.dart';
import 'package:money_management/screens/home.dart';
import 'package:money_management/screens/main.dart';
import 'package:money_management/screens/new_transactions.dart';
import '../../constant.dart';
import '../../main.dart';

class MainFloatingActionButton extends StatefulWidget {
  const MainFloatingActionButton({Key? key}) : super(key: key);

  @override
  State<MainFloatingActionButton> createState() =>
      _MainFloatingActionButtonState();
}

class _MainFloatingActionButtonState extends State<MainFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      splashColor: Colors.black12,
      child: const Icon(Icons.add, color: cIndigoColor),
      onPressed: () {
        NewTransActionScreen.descriptionController.text = '';
        NewTransActionScreen.priceController.text = '';
        NewTransActionScreen.date = 'تاریخ';
        NewTransActionScreen.groupId = 0;
        NewTransActionScreen.isEditing = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewTransActionScreen(),
          ),
        ).then((value) {
          MyApp.getData();
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          });
        });
      },
    );
  }
}
