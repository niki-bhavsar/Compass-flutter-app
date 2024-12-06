import 'package:compass_software/utils/app_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import '../../shared_pref/session_pref.dart';

class AuthInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    Logger.root.info('REQUEST[${options.method}] => PATH: ${options.path}');
    options.headers['Accept'] = 'application/json';
    options.headers['appversion'] = await AppUtils.getAppVersion();

    final sessionPref = GetIt.instance.get<SessionPref>();
    if(sessionPref.isLoggedIn()){
      options.headers['authtoken'] = sessionPref.getAuthToken();
    }
    //Set distributor info in header
    final distributorInfo = sessionPref.getDistributorInfo();
    options.headers['webid'] = distributorInfo?.webId;
    options.headers['webdbsuffix'] = distributorInfo?.webDBSuffix;

    //Set distributor info in request parameter
    options.data ??= <String, dynamic>{};
    final optionData = options.data;
    if (optionData is Map<String, dynamic>) {
      optionData['webid'] = distributorInfo?.webId ?? "";
      optionData['webdbsuffix'] = distributorInfo?.webDBSuffix ?? "";
    }

    if (kDebugMode) {
      options.headers.forEach((key, value) {
        Logger.root.info('HEADERS[$key] => $value');
      });

      if (options.data != null) Logger.root.info('BODY => ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.root.info('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    Logger.root.info('RESPONSE => ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    Logger.root.info('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    Logger.root.info('ERROR => ${err.response?.data}');
    super.onError(err, handler);
  }
}
