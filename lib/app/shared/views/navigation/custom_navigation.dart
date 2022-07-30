import 'package:flutter/material.dart';
import 'package:gymmat/app/shared/views/navigation/navigator.dart';
import 'package:gymmat/app/views/home/splash_view.dart';
import 'package:gymmat/app/views/splash/splash_view.dart';

final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Route<dynamic> onCreateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.HOME_SCREEN:
      return MaterialPageRoute(builder: (_) => const HomeView());
    default:
      {
        return MaterialPageRoute(builder: (_) => const SplashView());
      }
  }
}

void popView({dynamic result}) {
  if (navigatorState.currentState!.canPop()) {
    navigatorState.currentState!.pop(result);
  }
}

// track navigation of user
Future<NavigatorState?> pushView(
  String routeName, {
  dynamic arguments,
  bool replace = false,
  bool clean = false,
}) {
  if (clean) {
    return navigatorState.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (_) => false,
      arguments: arguments,
    );
  } else if (replace) {
    return navigatorState.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  } else {
    return navigatorState.currentState!
        .pushNamed(routeName, arguments: arguments);
  }
}
