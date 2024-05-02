import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:analogue_shifts_mobile/modules/auth/presentation/change_notifier/user_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';

import '../utils/logger.dart';

final _db = getIt<DBService>();
class DioManager {
  late Dio _dio;
  late String? tokenProvider;
  BuildContext? context;

  DioManager(this.tokenProvider) {
    _dio = Dio(
        BaseOptions(
          baseUrl: 'https://api.analogueshifts.com/api/',
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenProvider',
            'Content-Type': 'application/json', },
        )
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Attach access token to headers
        final token = _db.getToken();
        final accessToken = token ?? tokenProvider;
        logger.d(accessToken);

        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        logger.d('from manager $response');
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