import 'package:flutter/material.dart';
import 'package:zsdemo_app/components/badge/dot_decorator.dart';

enum ScvlDotIndicatorSize { small, normal, big }

class DotIndicator extends StatelessWidget {
  final DotDecorator decorator;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;

  const DotIndicator({
    Key? key,
    this.decorator = const DotDecorator(),
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  Widget _buildDot() {
    final size = decorator.activeSize;
    final color = decorator.activeColor;
    final shape = decorator.activeShape;

    return Container(
      width: size.width,
      height: size.height,
      decoration: ShapeDecoration(
        color: color,
        shape: shape,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDot();
  }

  factory DotIndicator.fromColor(Color color, [ScvlDotIndicatorSize size = ScvlDotIndicatorSize.normal]) {
    return DotIndicator(
      decorator: DotDecorator(
        activeColor: color,
        size: Size.square(_getSize(size)),
        activeSize: Size.square(_getSize(size)),
      ),
    );
  }

  static double _getSize(ScvlDotIndicatorSize size) {
    switch (size) {
      case ScvlDotIndicatorSize.small:
        return 8;
      case ScvlDotIndicatorSize.normal:
        return 12;
      case ScvlDotIndicatorSize.big:
        return 16;
    }
  }
}
