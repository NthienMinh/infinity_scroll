import 'dart:math';

import 'package:flutter/cupertino.dart';

class Resizable {
  static double font(BuildContext context, double size) {
    return fontScaleRatioForTablet(context) * width(context) *size / standard(context);
  }
  static double padding(BuildContext context, double size) {
    return paddingScaleRatioForTablet(context) *
        size *
        ((width(context) + standard(context)) / (2 * standard(context)));
  }

  static double size(BuildContext context, double size) {
    return sizeScaleRatioForTablet(context) *
        size *
        ((width(context) + standard(context)) / (2 * standard(context)));
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double standard(BuildContext context) {
    return isTablet(context) ? 1366 : 428; //tablet: iPad Pro 12.9, mobile: iPhone 12 Pro Max
  }

  static double fontScaleRatioForTablet(BuildContext context) {
    return (Resizable.isLandscape(context) ? 0.7 : 1) *
        (isTablet(context) ? 1.5 : 1);
  }

  static double sizeScaleRatioForTablet(BuildContext context) {
    return (Resizable.isLandscape(context) ? 0.7 : 1) * (isTablet(context) ? 1.5 : 1);
  }

  static double barSizeScaleRatioForTablet(BuildContext context) {
    return (Resizable.isLandscape(context) ? 0.7 : 1) * (isTablet(context) ? 1.5 : 1);
  }

  static double borderPaddingScaleRatioForTablet(BuildContext context) {
    return (Resizable.isLandscape(context) ? 0.7 : 1) * ( isTablet(context) ? 3 : 1);
  }

  static double paddingScaleRatioForTablet(BuildContext context) {
    return (Resizable.isLandscape(context) ? 0.7 : 1) * (isTablet(context) ? 2 : 1);
  }

  static bool isTablet(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var diagonal =
    sqrt((size.width * size.width) + (size.height * size.height));
    var isTablet = diagonal > 1100.0;
    return isTablet;
  }

  static bool isLandscape(BuildContext context) {
    return (MediaQuery.of(context).orientation == Orientation.landscape &&
        Resizable.isTablet(context));
  }

  static fixWidth(BuildContext context) {
    return isLandscape(context) ? width(context) * 7 / 9 : width(context);
  }

}
