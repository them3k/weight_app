import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProxyBaseWidget<T extends ChangeNotifier, R extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(
      BuildContext context, T model, Widget? child) builder;
  final T Function(
    BuildContext context,
    R parentModel,
    T model,
  ) update;
  final T model;
  final Function(T)? onModelReady;
  final Widget? child;

  ProxyBaseWidget(
      {required this.builder,
      required this.update,
      required this.model,
      this.onModelReady,
      this.child});

  @override
  State<ProxyBaseWidget<T, R>> createState() => _ProxyBaseWidgetState<T, R>();
}

class _ProxyBaseWidgetState<T extends ChangeNotifier, R extends ChangeNotifier>
    extends State<ProxyBaseWidget<T, R>> {
  late T model;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<R, T>(
      create: (context) => model,
      lazy: false,
      update: (context, T, R) => widget.update(context, T, R!),
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
