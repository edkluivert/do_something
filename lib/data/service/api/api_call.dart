import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';


class ApiCall{

  final dio = Dio();

  Future<Map<String, dynamic>> getHttp() async {
    final Response<dynamic> response = await dio.get(
      boredApiUrl,
    );
    return response.data;
  }

}