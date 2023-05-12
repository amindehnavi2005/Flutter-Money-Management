import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/constant.dart';
import 'package:money_management/main.dart';
import 'package:money_management/models/money.dart';
import 'package:money_management/screens/home.dart';
import 'package:money_management/utils/calculate.dart';
import 'package:money_management/widgets/new_transactions/radio_button.dart';
import 'package:money_management/widgets/new_transactions/text_button.dart';
import 'package:money_management/widgets/new_transactions/text_field.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class NewTransActionScreen extends StatefulWidget {
  static int groupId = 0;
  static int id = 0;
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static bool isEditing = false;
  static String date = 'تاریخ';

  const NewTransActionScreen({super.key});

  @override
  State<NewTransActionScreen> createState() => _NewTransActionScreenState();
}

class _NewTransActionScreenState extends State<NewTransActionScreen> {
  Box<Money> hiveBox = Hive.box('moneyBox');

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        NewTransActionScreen.isEditing
                            ? 'ویرایش تراکنش'
                            : 'تراکنش جدید',
                        style:
                            const TextStyle(fontSize: 20, color: cIndigoColor),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          textDirection: TextDirection.ltr,
                          color: cIndigoColor,
                        ),
                      ),
                    ],
                  ),
                  TransactionTextField(
                    hint: 'توضیحات "حداکثر 20 کارکتر"',
                    type: TextInputType.text,
                    controller: NewTransActionScreen.descriptionController,
                  ),
                  TransactionTextField(
                    hint: 'مبلغ "حداکثر 9,999,999,999"',
                    type: TextInputType.number,
                    controller: NewTransActionScreen.priceController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            var pickedDate = await showPersianDatePicker(
                              context: context,
                              initialDate: Jalali.now(),
                              firstDate: Jalali(1401),
                              lastDate: Jalali(1420),
                            );
                            setState(() {
                              String year = pickedDate!.year.toString();
                              String month =
                                  pickedDate.month.toString().length == 1
                                      ? '0${pickedDate.month.toString()}'
                                      : pickedDate.month.toString();
                              String day = pickedDate.day.toString().length == 1
                                  ? '0${pickedDate.day.toString()}'
                                  : pickedDate.day.toString();
                              NewTransActionScreen.date = '$year/$month/$day';
                            });
                          },
                          child: Text(
                            NewTransActionScreen.date,
                            style: const TextStyle(
                                color: cIndigoColor, fontSize: 17.5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TransactionRadioButton(
                          label: 'پرداختی',
                          value: 1,
                          groupValue: NewTransActionScreen.groupId,
                          onChanged: (value) {
                            setState(() {
                              NewTransActionScreen.groupId = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: TransactionRadioButton(
                          label: 'دریافتی',
                          value: 2,
                          groupValue: NewTransActionScreen.groupId,
                          onChanged: (value) {
                            setState(() {
                              NewTransActionScreen.groupId = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: NewTransActionScreen.date != 'تاریخ',
                    child: TransactionTextButton(
                        text: NewTransActionScreen.isEditing
                            ? 'ویرایش کردن'
                            : 'اضافه کردن',
                        onPressed: () {
                          Money item = Money(
                            id: DateTime.now().microsecondsSinceEpoch,
                            title: NewTransActionScreen
                                    .descriptionController.text.isNotEmpty
                                ? NewTransActionScreen
                                    .descriptionController.text
                                : 'بدون توضیحات',
                            price: NewTransActionScreen
                                    .priceController.text.isNotEmpty
                                ? NewTransActionScreen.priceController.text
                                : '0',
                            date: NewTransActionScreen.date.isNotEmpty
                                ? NewTransActionScreen.date
                                : Jalali.now().toString(),
                            isReceived: NewTransActionScreen.groupId == 1
                                ? true
                                : false,
                          );
                          if (NewTransActionScreen.isEditing) {
                            int index = 0;
                            MyApp.getData();
                            for (int i = 0; i < hiveBox.values.length; i++) {
                              if (hiveBox.values.elementAt(i).id ==
                                  NewTransActionScreen.id) {
                                index = i;
                              }
                            }
                            hiveBox.putAt(index, item);
                          } else {
                            hiveBox.add(item);
                          }
                          Navigator.pop(context);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
