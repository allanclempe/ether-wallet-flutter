import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

typedef HookWidgetBuilder<Handler> = Widget Function(
    BuildContext context, Handler store);

abstract class ContextProviderWidget<T> extends HookWidget {
  const ContextProviderWidget({this.child, this.builder, Key? key})
      : super(key: key);

  final Widget? child;
  final HookWidgetBuilder<T>? builder;

  Widget provide(BuildContext context, T handler) {
    return MultiProvider(
      providers: [
        Provider.value(value: handler),
      ],
      child: builder != null ? builder!(context, handler) : child,
    );
  }
}
