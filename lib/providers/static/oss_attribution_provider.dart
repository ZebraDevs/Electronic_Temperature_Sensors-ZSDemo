import 'package:flutter/material.dart';
import 'package:zsdemo_app/states/static/oss_attribution_state.dart';
import 'package:provider/provider.dart';

class OSSAttributionProvider extends ChangeNotifierProvider<OSSAttributionState> {
  OSSAttributionProvider({Key? key, Widget? child})
      : super(
          create: (_) => OSSAttributionState(),
          child: child,
          key: key,
        );
}
