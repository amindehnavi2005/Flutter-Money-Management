import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../screens/home.dart';

// ignore: must_be_immutable
class HomeListTile extends StatelessWidget {
  int index;

  HomeListTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Card(
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    // color: HomeScreen.moneys[index].isReceived
                    //     ? cRedColor
                    //     : cGreenColor,
                    border: Border.all(
                        color: HomeScreen.moneys[index].isReceived
                            ? cRedColor
                            : cGreenColor,
                        width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    HomeScreen.moneys[index].isReceived
                        ? Icons.remove
                        : Icons.add,
                    color: HomeScreen.moneys[index].isReceived
                        ? cRedColor
                        : cGreenColor,
                    size: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    HomeScreen.moneys[index].title.length > 20
                        ? 'توضیحات طولانی'
                        : HomeScreen.moneys[index].title,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          HomeScreen.moneys[index].price.length > 10
                              ? 'مبلغ زیاد'
                              : HomeScreen.moneys[index].price,
                          style: const TextStyle(
                              fontSize: 20, color: cIndigoColor),
                        ),
                        Text(
                          HomeScreen.moneys[index].price.length > 10
                              ? ''
                              : 'تومان',
                          style: const TextStyle(
                              fontSize: 10, color: cIndigoColor),
                        ),
                      ],
                    ),
                    Text(HomeScreen.moneys[index].date),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
