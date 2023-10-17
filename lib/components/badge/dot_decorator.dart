import 'package:flutter/material.dart';

const Size kDefaultSize = Size.square(12.0);
const EdgeInsets kDefaultSpacing = EdgeInsets.all(6.0);
const ShapeBorder kDefaultShape = CircleBorder();

class DotDecorator {
  final Color color;
  final Color activeColor;
  final Size size;
  final Size activeSize;
  final ShapeBorder shape;
  final ShapeBorder activeShape;

  const DotDecorator({
    this.color = Colors.grey,
    this.activeColor = Colors.green,
    this.size = kDefaultSize,
    this.activeSize = kDefaultSize,
    this.shape = kDefaultShape,
    this.activeShape = kDefaultShape,
  });
}
