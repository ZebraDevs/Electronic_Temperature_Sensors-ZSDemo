import 'package:flutter/widgets.dart';
import 'package:zsdemo_app/services/zsdemo_api_service.dart';
import 'package:provider/provider.dart';

class APIServiceProvider extends Provider<ZSDemoAPIService> {
  APIServiceProvider({super.key, Widget? child})
      : super(
          create: (context) => ZSDemoAPIService(),
        );
}
