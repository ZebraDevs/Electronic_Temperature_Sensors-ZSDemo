import 'package:flutter/material.dart';
import 'package:zsdemo_app/providers/api_service_provider.dart';
import 'package:zsdemo_app/providers/bluetooth_service_provider.dart';
import 'package:zsdemo_app/providers/location_state_provider.dart';
import 'package:zsdemo_app/providers/static/eula_provider.dart';
import 'package:zsdemo_app/providers/links_provider.dart';
import 'package:zsdemo_app/providers/static/zsfinder_state_provider.dart';
import 'package:provider/provider.dart';

class ServiceProviders extends StatelessWidget {
  final Widget child;
  const ServiceProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        EulaProvider(),
        BluetoothServiceProvider(),
        APIServiceProvider(),
        ZsfinderStateProvider(),
        LocationStateProvider(),
        LinksProvider(),
      ],
      child: child,
    );
  }
}
