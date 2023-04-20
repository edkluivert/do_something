import 'package:do_something/data/service/network/my_network.dart';
import 'package:do_something/presentation/controller/home_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MyNetwork(),permanent: true);
    Get.put(HomeController());
  }

}