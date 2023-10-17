import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zsdemo_app/common/styles/colors.dart';
import 'package:zsdemo_app/common/styles/icons.dart';
import 'package:zsdemo_app/generated/l10n.dart';
import 'package:zsdemo_app/pages/sensor_page.dart';
import 'package:zsdemo_app/pages/static/about_page.dart';
import 'package:zsdemo_app/states/links_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final linkState = context.watch<LinksState>();

    if (linkState.isUrlAvailable) {
      scheduleMicrotask(
        () {
          Navigator.of(context).pushNamed(SensorPage.routeName);
        },
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                Loco.current.homePageLabel,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: Text(Loco.current.scanSensorLabel),
              onPressed: () async {
                Navigator.of(context).pushNamed(SensorPage.routeName);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(ZSIcons.help),
        label: Text(Loco.current.menuAbout),
        backgroundColor: ZSColors.primary,
        foregroundColor: ZSColors.neutralLight00,
        onPressed: () {
          Navigator.of(context).pushNamed(AboutPage.routeName);
        },
      ),
    );
  }
}
