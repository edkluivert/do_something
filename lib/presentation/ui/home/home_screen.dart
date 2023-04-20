import 'package:do_something/presentation/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/constants/constants.dart';
import '../../../data/service/network/my_network.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final MyNetwork _myNetwork = Get.find();
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: kDouble20),
            const Text(
              'DO SOMETHING',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 40,
                letterSpacing: 4.0,
              ),
            ),
            const SizedBox(height: kDouble20),
            Obx(() {
              return Image.asset(
                _myNetwork.isConnectedNotifier.value
                    ? 'assets/images/globe.png'
                    : 'assets/images/no_wifi.png',
              );
            }),

            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(kDouble10),
                child: Column(
                  children: [
                    const SizedBox(height: kDouble20),
                    Text(
                      _controller.dataNotifier.value.activity,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: kDouble10),
                    Text(
                      'This is a ${_controller.dataNotifier.value
                          .type} type activity.',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    ListTile(
                      title: Text(_controller.dataNotifier.value.type),
                      leading: const Text('Participants'),
                    ),
                  ],
                ),
              );
            }),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              await _controller.reset();
            },
            icon: const Icon(Icons.add),
            label: const Text('New activity'),
          ),
          const SizedBox(height: kDouble10),
          TextButton(
            onPressed: () {
              _controller.logData();
            },
            child: const Text('Log data'),
          ),
          const SizedBox(height: kDouble20),
        ],
      ),
    );
  }
}