import 'dart:developer';

import 'package:do_something/data/cache/cache_manager.dart';
import 'package:do_something/data/model/data_model.dart';
import 'package:do_something/data/service/network/my_network.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../core/mappers/data_mapper.dart';
import '../../data/service/api/api_call.dart';

class HomeController extends GetxController with CacheManager{

  final ApiCall _apiCall = ApiCall();
  final MyNetwork _myNetwork = Get.find();

  Map<String, dynamic> dataMapCurrent = {};
  Map<String, dynamic> dataMapInternal = {};
  Map<String, dynamic> dataMapExternal = {};


  final dataNotifier = DataModel(
    activity: 'Activity',
    type: 'Type',
    participants: 0,
    price: '0',
    link: 'Link',
    key: 'Key',
    accessibility: '0',
  ).obs;


  @override
  void onInit(){
    super.onInit();

    ///to start cache
    initStorage();

    ///data check
    setDataNotifier();


  }

  Future<Map<String, dynamic>> getInternalData() async
  {
    await getData();
    Map<String, dynamic> map = data;
    return map;
  }
  Future<Map<String, dynamic>> getExternalData() async {
    Map<String, dynamic> map = await _apiCall.getHttp();
    String jsonString = fromMapToString(map: map);
    await saveNewInternalData(externalDataString: jsonString);
    return map;
  }

  Future<void> saveNewInternalData({required String externalDataString}) async {
    saveInternalData(jsonString: externalDataString);
  }


  Future<void> setDataNotifier() async {
    if (_myNetwork.isConnectedNotifier.value) {
      dataMapExternal = await getExternalData();
      dataMapInternal = dataMapExternal;
      dataMapCurrent = dataMapExternal;
    } else {
      dataMapInternal = await getInternalData();
      dataMapCurrent = dataMapInternal;
    }
    if (dataMapCurrent.isNotEmpty) {

      dataNotifier.update((val) {
        val!.type = fromMaptoDataModel(map: dataMapCurrent).type;
        val.price = fromMaptoDataModel(map: dataMapCurrent).price;
        val.accessibility = fromMaptoDataModel(map: dataMapCurrent).accessibility;
        val.activity = fromMaptoDataModel(map: dataMapCurrent).activity;
        val.key = fromMaptoDataModel(map: dataMapCurrent).key;
        val.link = fromMaptoDataModel(map: dataMapCurrent).link;
        val.participants = fromMaptoDataModel(map: dataMapCurrent).participants;


      });

    }
  }

  Future<void> reset() async {
    await setDataNotifier();
  }

  void logData() {
    String current = fromMapToString(map: dataMapCurrent);
    String internal = fromMapToString(map: dataMapInternal);
    String external = fromMapToString(map: dataMapExternal);
    debugPrint('Current: $current');
    log('Internal: $internal');
    log('External: $external');
  }



}