import 'package:flutter/material.dart';
import 'package:zsdemo_app/pages/zsfinder_status_page.dart';
import 'package:zsdemo_app/states/static/eula_state.dart';
import 'package:zsdemo_app/views/base_view.dart';
import 'package:zsdemo_app/views/static/eula_view.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<EulaState>(
      state: context.watch<EulaState>(),
      onStateReady: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          state.checkEulaAccepted();
        });
      },
      builder: (context, state, child) {
        if (state.busy) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.accepted) {
          return const ZSFinderStatusPage();
        } else {
          return const EulaView();
        }
      },
    );
  }
}
