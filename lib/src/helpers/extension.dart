import 'package:flutter/material.dart';

extension WidgetsPadding on Widget {
  Widget pOnly({double? top, double? bottom, double? left, double? right}) =>
      Padding(
        padding: EdgeInsets.only(
            top: top ?? 0,
            bottom: bottom ?? 0,
            left: left ?? 0,
            right: right ?? 0),
        child: this,
      );
  Widget pSymmetric({double? vertical, double? horizontal}) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontal ?? 0, vertical: vertical ?? 0),
        child: this,
      );
}
