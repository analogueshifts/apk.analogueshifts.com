import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../utils/logger.dart';

final _db = getIt<DBService>();
class DioManager {
  late Dio _dio;
  late String? tokenProvider;
  BuildContext? context;

  DioManager(this.tokenProvider) {
    
    _dio = Dio(
        BaseOptions(
          //DEVELOPMENT
          baseUrl: 'https://developer.analogueshifts.com/api/',
          //PRODUCTION URL
          // baseUrl: 'https://api.analogueshifts.app/api/',
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenProvider',
            'Content-Type': 'application/json',
            'public_key': 'AS_PUBLIC_HtqFHcL1LLmqt',
            'secret_key': 'AS_SECRET_29MOHf8Ff2ImH',
            'slug': 'user_version_1.0_android',
            'user_type': 'user',
            'version': '1.0'
          },
        )
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Attach access token to headers
        final token = _db.getToken();
        final accessToken = token ?? tokenProvider;


        if (accessToken != null) {
          logger.d(accessToken);
          options.headers['Authorization'] = 'Bearer $accessToken';
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        logger.d('from manager $response');
        logger.d(response.statusCode);
        // Handle token refresh if needed
        if (response.statusCode == 401) {
          if (context != null) {
            if(context!.mounted) {
              _db.clear();

            }

          }
        }

        return handler.next(response);
      },
    ));
  }

  Dio get dio => _dio;
}