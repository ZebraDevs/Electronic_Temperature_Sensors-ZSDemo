import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zsdemo_app/common/constants/constants.dart';
import 'package:zsdemo_app/common/router/router.dart';
import 'package:zsdemo_app/common/styles/theme.dart';
import 'package:zsdemo_app/providers/service_providers.dart';

import 'generated/l10n.dart';

final navigatorKey = GlobalKey<NavigatorState>();
RouteObserver<ModalRoute<dynamic>> _rootObserver = RouteObserver<ModalRoute<dynamic>>();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ServiceProviders(
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        title: 'ZSDemo',
        themeMode: ThemeMode.light,
        theme: ZSTheme.lightTheme,
        localizationsDelegates: const [
          Loco.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: Loco.delegate.supportedLocales,
        navigatorObservers: [_rootObserver],
        navigatorKey: navigatorKey,
        onGenerateRoute: ZSRouter.onGenerateRoute,
      ),
    );
  }
}
