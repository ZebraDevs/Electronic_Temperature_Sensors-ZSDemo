import 'package:zsdemo_app/states/mixins/location_mixin.dart';
import 'package:provider/provider.dart';

class LocationStateProvider extends ChangeNotifierProvider<LocationState> {
  LocationStateProvider({super.key})
      : super(
          create: (_) => LocationState(),
        );
}
