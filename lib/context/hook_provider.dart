import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart' as p;

typedef HookWidgetBuilder<Handler> = Widget Function(
    BuildContext context, Handler store);

abstract class ContextProviderWidget<T> extends HookWidget {
  final Widget child;
  final HookWidgetBuilder<T> builder;

  ContextProviderWidget({this.child, this.builder});

  Widget provide(BuildContext context, T handler) {
    return p.MultiProvider(
      providers: [
        p.Provider.value(value: handler),
      ],
      child: builder != null ? builder(context, handler) : child,
    );
  }
}
