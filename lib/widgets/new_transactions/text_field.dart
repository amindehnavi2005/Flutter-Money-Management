import 'package:flutter/material.dart';
import 'package:money_management/constant.dart';

class TransactionTextField extends StatelessWidget {
  final String hint;
  final TextInputType type;
  final TextEditingController controller;

  const TransactionTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: TextField(
        controller: controller,
        keyboardType: type,
        cursorColor: cIndigoColor,
        decoration: InputDecoration(
          hintText: hint,
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: cIndigoColor),
          ),
        ),
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }
}
