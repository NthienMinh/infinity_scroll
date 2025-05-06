import 'package:flutter/material.dart';
import 'package:infinity_scroll/resource/texts/texts.dart';

class WarningWidget extends StatelessWidget {
  const WarningWidget({super.key, required this.text, required this.onPressed});

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          TextButton(
            onPressed: onPressed,
            child: Text(Texts.productsText.reload),
          ),
        ],
      ),
    );
  }
}
