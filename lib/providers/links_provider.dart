import 'package:zsdemo_app/states/links_state.dart';
import 'package:provider/provider.dart';

class LinksProvider extends ChangeNotifierProvider<LinksState> {
  LinksProvider({super.key}) : super(create: (_) => LinksState(), lazy: false);
}
