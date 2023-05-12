import 'package:flutter/material.dart';

import '../../constant.dart';

class HomeEmptyWidget extends StatelessWidget {
  const HomeEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Spacer(),
        Icon(
          Icons.layers_clear_outlined,
          size: 150,
          color: cIndigoColor,
        ),
        Text(
          'تراکنشی موجود نیست!',
          style: TextStyle(color: cIndigoColor, fontSize: 20),
        ),
        Spacer(),
      ],
    );
  }
}
