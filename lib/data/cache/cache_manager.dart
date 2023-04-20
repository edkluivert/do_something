import 'package:get_storage/get_storage.dart';

import '../../core/constants/constants.dart';
import '../../core/mappers/data_mapper.dart';

mixin CacheManager {
  final box = GetStorage();
  late Map<String, dynamic> data;

  Future<void> initStorage() async {

    await getData();
  }

  Future<void> getData() async {
    final String jsonString = box.read(CacheManagerKey.keyInternalData.toString()) ?? await saveInternalData();
    Map<String, dynamic> map = fromStringToMap(value: jsonString);
    data = map;
  }

  Future<String> saveInternalData({
    String jsonString = jsonStringEmpty,
  }) async {
    String jsonStringInitValue = jsonString;
    await box.write(CacheManagerKey.keyInternalData.toString(), jsonStringInitValue);
    return jsonStringInitValue;
  }
}


enum CacheManagerKey {keyInternalData}