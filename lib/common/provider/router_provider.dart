import 'package:codefactory_flutter_lv2/common/view/splash_screen.dart';
import 'package:codefactory_flutter_lv2/user/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    final provider = ref.read(authProvider);

    return GoRouter(
      routes: provider.routes,
      initialLocation: '/${SplashScreen.routeName}',
      redirect: provider.redirectLogic,
      refreshListenable: provider,
    );
  },
);
