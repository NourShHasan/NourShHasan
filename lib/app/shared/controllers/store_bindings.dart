import 'package:get/instance_manager.dart';
import 'package:gymmat/app/views/splash/controllers/splash_controller.dart';

///

class StoreBinding implements Bindings {

// default dependency
 @override
 void dependencies() {
   Get.lazyPut(SplashController.new);
 }
}