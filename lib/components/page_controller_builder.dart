import 'package:flutter/material.dart';

typedef PageControllerBuilder = Widget Function(BuildContext, PageController);

class ZSPageControllerBuilder extends StatefulWidget {
  final PageControllerBuilder builder;
  const ZSPageControllerBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  ZSPageControllerBuilderState createState() => ZSPageControllerBuilderState();
}

class ZSPageControllerBuilderState extends State<ZSPageControllerBuilder> {
  late PageController controller;
  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, controller);
  }
}

extension PageExctension on PageController {
  double get safePage => hasClients ? page ?? 0 : 0;
}

class ZSPageControllerRebuilder extends StatefulWidget {
  final PageController controller;
  final Widget Function(BuildContext, double) builder;
  const ZSPageControllerRebuilder({Key? key, required this.controller, required this.builder}) : super(key: key);

  @override
  State<ZSPageControllerRebuilder> createState() => _ZSPageControllerRebuilderState();
}

class _ZSPageControllerRebuilderState extends State<ZSPageControllerRebuilder> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }

  void listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.controller.safePage);
  }
}
