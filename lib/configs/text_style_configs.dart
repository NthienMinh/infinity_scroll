

import 'package:flutter/cupertino.dart';
import 'package:infinity_scroll/utils/resizable_utils.dart';

import 'color_configs.dart';
class TextStyleConfigs {

  static TextStyle bigTextStyle(BuildContext context){
    return TextStyle(
        color: ColorConfigs.blackColor,
        fontSize: Resizable.font(context, 18),
        fontWeight: FontWeight.w900,
        height: 1.2,
        letterSpacing: 0
    );
  }

  static TextStyle smallTextStyle(BuildContext context){
    return TextStyle(
        color: ColorConfigs.blackColor,
        fontSize: Resizable.font(context, 14),
        fontWeight: FontWeight.w400,
        height: 1.2,
        letterSpacing: 0
    );
  }

}