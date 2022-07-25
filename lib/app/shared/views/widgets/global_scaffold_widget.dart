import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core.export.dart';

typedef WillPop = Future<bool> Function()?;

class GlobalScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final WillPop? onWillPop;
  final TextDirection? textDirection;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const GlobalScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.backgroundColor = kBackgroundColor,
    this.resizeToAvoidBottomInset,
    this.onWillPop,
    this.textDirection,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop ??
          () async {
            return Navigator.of(context).userGestureInProgress ? false : true;
          },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: kBackgroundColor,
          systemNavigationBarColor:Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        child: buildDirection(),
      ),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      body: body,
      appBar: appBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  Widget buildDirection() {
    if (textDirection == null) {
      return buildScaffold();
    } else {
      return Directionality(
        textDirection: textDirection!,
        child: buildScaffold(),
      );
    }
  }
}
