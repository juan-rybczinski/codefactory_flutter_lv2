import 'package:codefactory_flutter_lv2/common/provider/router_provider.dart';
import 'package:codefactory_flutter_lv2/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(child: _App()),
  );
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: FontFamily.notoSans,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
