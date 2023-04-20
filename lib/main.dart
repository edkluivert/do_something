import 'dart:developer';

import 'package:do_something/core/di/app_binding.dart';
import 'package:do_something/presentation/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.teal,
      ),
      home: FutureBuilder(
        future: initializeSettings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return HomeScreen();
          }
        },
      ),
    );
  }

  Future<void> initializeSettings() async {

    log('Hello just checking for nothing');

    //Simulate other services for 3 seconds
    await Future.delayed(const Duration(seconds: 3));
  }

}

