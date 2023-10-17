import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

typedef OnState<T> = void Function(T);
typedef OnAppState<T> = void Function(T, AppLifecycleState);

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T state, Widget? child) builder;
  final T state;
  final Widget? child;
  final OnState<T>? onStateReady;
  final OnState<T>? onDispose;
  final OnAppState<T>? onChangeAppLifecycleState;

  const BaseWidget({
    Key? key,
    required this.builder,
    required this.state,
    this.child,
    this.onStateReady,
    this.onDispose,
    this.onChangeAppLifecycleState,
  }) : super(key: key);

  @override
  State<BaseWidget> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>>
    with WidgetsBindingObserver {
  T get state => widget.state;

  @override
  void initState() {
    super.initState();
    widget.onStateReady?.call(state);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.onDispose?.call(state);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appState) async {
    widget.onChangeAppLifecycleState?.call(state, appState);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: widget.builder,
      child: widget.child,
    );
  }
}

// regular base widget accepts state argument, but does a context watch anyway
// this just listens to whatever u pass
class ProperBaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T state, Widget? child) builder;
  final T state;
  final Widget? child;
  final OnState<T>? onStateReady;
  final OnState<T>? onDispose;
  final OnAppState<T>? onChangeAppLifecycleState;

  const ProperBaseWidget({
    Key? key,
    required this.builder,
    required this.state,
    this.child,
    this.onStateReady,
    this.onDispose,
    this.onChangeAppLifecycleState,
  }) : super(key: key);

  @override
  State<ProperBaseWidget> createState() => _ProperBaseWidget<T>();
}

class _ProperBaseWidget<T extends ChangeNotifier>
    extends State<ProperBaseWidget<T>> with WidgetsBindingObserver {
  T get state => widget.state;

  @override
  void initState() {
    super.initState();
    state.addListener(listener);
    widget.onStateReady?.call(state);
    WidgetsBinding.instance.addObserver(this);
  }

  void listener() {
    debugPrint('updating state');
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.onDispose?.call(state);
    state.removeListener(listener);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ProperBaseWidget<T> oldWidget) {
    oldWidget.state.removeListener(listener);
    state.addListener(listener);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) async {
    widget.onChangeAppLifecycleState?.call(state, appLifecycleState);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      state,
      widget.child,
    );
  }
}
