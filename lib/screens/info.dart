import 'package:flutter/material.dart';
import 'package:money_management/constant.dart';
import 'package:money_management/utils/calculate.dart';
import 'package:money_management/widgets/chart.dart';
import 'package:money_management/widgets/info/money_info.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'مدیریت تراکنش ها به تومان',
                    style: TextStyle(fontSize: 20, color: cIndigoColor),
                  ),
                  MoneyInfoWidget(
                    firstTitle: 'پرداختی امروز :',
                    firstPrice: Calculate.receiveToday().floor().toString(),
                    secondTitle: 'دریافتی امروز :',
                    secondPrice: Calculate.payToday().floor().toString(),
                  ),
                  MoneyInfoWidget(
                    firstTitle: 'پرداختی این ماه :',
                    firstPrice: Calculate.receiveMonth().floor().toString(),
                    secondTitle: 'دریافتی این ماه :',
                    secondPrice: Calculate.payMonth().floor().toString(),
                  ),
                  MoneyInfoWidget(
                    firstTitle: 'پرداختی این سال :',
                    firstPrice: Calculate.receiveYear().floor().toString(),
                    secondTitle: 'دریافتی سال :',
                    secondPrice: Calculate.payYear().floor().toString(),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 75, bottom: 50),
                      child: BarChartWidget(),
                    ),
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
