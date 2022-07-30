import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymmat/app/views/splash/controllers/splash_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///
class HomeView extends GetView<SplashController> {
  ///

  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.hello),
      ),
      body: Center(child: Text('hello'.tr)),
    );
  }
}
