import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/constant.dart';
import 'package:money_management/main.dart';
import 'package:money_management/models/money.dart';
import 'package:money_management/screens/main.dart';
import 'package:money_management/screens/new_transactions.dart';
import 'package:money_management/widgets/home/empty.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

import '../widgets/home/list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static List<Money> moneys = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static TextEditingController searchBarController = TextEditingController();
  Box<Money> hiveBox = Hive.box('moneyBox');

  @override
  void initState() {
    MyApp.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(right: 20, top: 10, left: 20),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  headerWidget(),
                  // const Expanded(child: HomeEmptyWidget()),
                  Expanded(
                    child: HomeScreen.moneys.isEmpty
                        ? const HomeEmptyWidget()
                        : ListView.builder(
                            itemCount: HomeScreen.moneys.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: HomeListTile(index: index),
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      actionsAlignment:
                                          MainAxisAlignment.spaceAround,
                                      title: const Text(
                                        "آیا از حذف مطمئن هستید؟",
                                        style: TextStyle(color: cRedColor),
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              hiveBox.deleteAt(index);
                                              MyApp.getData();
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: const Text(
                                            'بله',
                                            style:
                                                TextStyle(color: cIndigoColor),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'خیر',
                                            style:
                                                TextStyle(color: cIndigoColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                onTap: () {
                                  NewTransActionScreen.id =
                                      HomeScreen.moneys[index].id;
                                  NewTransActionScreen.descriptionController
                                      .text = HomeScreen.moneys[index].title;
                                  NewTransActionScreen.priceController.text =
                                      HomeScreen.moneys[index].price;
                                  NewTransActionScreen.date =
                                      HomeScreen.moneys[index].date;
                                  NewTransActionScreen.groupId =
                                      HomeScreen.moneys[index].isReceived
                                          ? 1
                                          : 2;
                                  NewTransActionScreen.isEditing = true;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NewTransActionScreen(),
                                    ),
                                  ).then((value) {
                                    MyApp.getData();
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MainScreen(),
                                        ),
                                      );
                                    });
                                  });
                                },
                              );
                            },
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget headerWidget() {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'تراکنش ها',
              style: TextStyle(fontSize: 17.5, color: cIndigoColor),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SearchBarAnimation(
                textEditingController: searchBarController,
                hintText: 'جستجو کنید...',
                enableButtonShadow: false,
                isOriginalAnimation: false,
                buttonShadowColour: Colors.black26,
                buttonBorderColour: Colors.black26,
                trailingWidget: const Text(''),
                secondaryButtonWidget: const Icon(
                  Icons.clear,
                  color: cIndigoColor,
                ),
                cursorColour: cIndigoColor,
                enteredTextStyle: const TextStyle(color: cIndigoColor),
                buttonWidget: const Icon(Icons.search, color: cIndigoColor),
                onFieldSubmitted: (String text) {
                  List<Money> result = hiveBox.values
                      .where(
                        (value) =>
                            value.title.contains(text) ||
                            value.date.contains(text),
                      )
                      .toList();
                  HomeScreen.moneys.clear();

                  setState(() {
                    for (var value in result) {
                      HomeScreen.moneys.add(value);
                    }
                  });
                },
                onCollapseComplete: () {
                  MyApp.getData();
                  searchBarController.text = '';
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
