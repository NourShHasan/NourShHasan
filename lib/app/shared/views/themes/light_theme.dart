import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core.export.dart';

/// Light Theme
final ThemeData lightTheme = ThemeData(
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: kBackgroundColor,
  appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Cairo',
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: kPrimarySecondColor,
    primary: kPrimaryColor,
  ),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: kPrimaryColor),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
  }),
);

/// System Overlay Style
SystemUiOverlayStyle get systemUiOverlayStyle {
  return const SystemUiOverlayStyle(
    statusBarColor: kBackgroundColor,
    systemNavigationBarColor: kBackgroundColor,
    statusBarIconBrightness: Brightness.dark,
  );
}

/// Global AppBar
class GlobalAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Color backgroundColor;
  final Color titleColor;
  final bool showBackButton;

  const GlobalAppBar({
    Key? key,
    this.title,
    this.backgroundColor = Colors.white,
    this.titleColor = Colors.black,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Container(
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: showBackButton
              ? const Icon(Icons.arrow_back_rounded)
              : const SizedBox.shrink(),
        ),
      ),
      elevation: 0,
      backgroundColor: backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title ?? "", style: TextStyle(color: titleColor)),
        ],
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class AppScrollBehavior extends ScrollBehavior {
  const AppScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
