import 'package:flutter/material.dart';
import 'package:zsdemo_app/states/static/eula_state.dart';
import 'package:provider/provider.dart';

class EulaProvider extends ChangeNotifierProvider<EulaState> {
  EulaProvider({Key? key, Widget? child})
      : super(
          create: (_) => EulaState(),
          child: child,
          key: key,
        );
}
