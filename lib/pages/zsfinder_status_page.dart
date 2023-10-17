import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_redirect/store_redirect.dart';

import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/pages/pages.dart';
import 'package:zsdemo_app/pages/zsfinder_error_page.dart';
import 'package:zsdemo_app/states/static/zsfinder_state.dart';
import 'package:zsdemo_app/views/base_view.dart';

class ZSFinderStatusPage extends StatelessWidget {
  const ZSFinderStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ZSFinderState>(
      state: context.watch<ZSFinderState>(),
      onStateReady: (state) async {
        state.events.listen((event) {
          state.installed = false;
        });
        await state.checkZSFinderInstallation();
        await state.checkIsClientCompatible();
        await state.checkZSFinderPermissions();
      },
      onChangeAppLifecycleState: (state, lifecycleState) async {
        if (lifecycleState == AppLifecycleState.resumed) {
          await state.checkZSFinderInstallation();
          await state.checkIsClientCompatible();
          await state.checkZSFinderPermissions();
        }
      },
      builder: (context, state, child) {
        if (state.busy) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (!state.installed) {
          return ZSFinderErrorPage(
            errorTitle: Loco.of(context).zsfinderNotInstalled,
            errorDescription: Loco.of(context).zsfinderRequired,
            buttonText: Loco.of(context).downloadFromGooglePlay,
            onPress: () {
              StoreRedirect.redirect(androidAppId: 'com.zebra.zsfinder');
            },
          );
        } else if (!state.clientCompatible) {
          return ZSFinderErrorPage(
            errorTitle: Loco.of(context).zsfinderIncompatible,
            errorDescription: Loco.of(context).zsfinderUpdateRequired,
            buttonText: Loco.of(context).downloadFromGooglePlay,
            onPress: () {
              StoreRedirect.redirect(androidAppId: 'com.zebra.zsfinder');
            },
          );
        } else if (!state.permissionsGranted && !state.bindingFailure) {
          return ZSFinderErrorPage(
            errorTitle: Loco.of(context).zsfinderPermissionsDenied,
            errorDescription: Loco.of(context).zsfinderPermissionsRequired,
            buttonText: Loco.of(context).zsfinderGrantPermissions,
            onPress: () {
              DeviceApps.openApp('com.zebra.zsfinder');
            },
          );
        } else if (!state.serviceBound && state.bindingFailure) {
          return ZSFinderErrorPage(
            errorTitle: Loco.of(context).zsfinderBindFailed,
            errorDescription: Loco.of(context).zsfinderRebind,
            buttonText: Loco.of(context).zsfinderOpen,
            onPress: () {
              DeviceApps.openApp('com.zebra.zsfinder');
            },
          );
        } else {
          state.setClientAuthKey();
          return const HomePage();
        }
      },
    );
  }
}
