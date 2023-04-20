import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class MyNetwork extends GetxService{

  late StreamSubscription<ConnectivityResult> subscription;
  var isConnectedNotifier = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnectedNotifier.value = false;
      } else {
        isConnectedNotifier.value = true;
      }
    });

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    subscription.cancel();
  }

}