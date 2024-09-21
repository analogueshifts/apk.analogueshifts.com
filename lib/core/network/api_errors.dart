import 'dart:async';
import 'dart:io';
import 'package:analogue_shifts_mobile/app/app.dart';
import 'package:analogue_shifts_mobile/core/navigators/go_router.dart';
import 'package:analogue_shifts_mobile/core/navigators/navigation_service.dart';
import 'package:analogue_shifts_mobile/core/navigators/route_names.dart';
import 'package:analogue_shifts_mobile/core/services/db_service.dart';
import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:analogue_shifts_mobile/injection_container.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ErrorHandler  {

  /// Function to handle error messages from the server
  String handleError(dynamic e) {
    Logger().d(e);
    if(e.runtimeType == String){

    }
    if (e is HandshakeException || e.toString().contains('HandshakeException')) {
      return ("Error occurred, please try again");
    }
    else if(e is SocketException || e.toString().contains('SocketException')){
      return  ("No internet connection");
    }
    if(e is TimeoutException || e.toString().contains('TimeoutException')){
      return ("Request timeout, try again");
    }
    if(e is FormatException || e.toString().contains('FormatException')){
      return("Error occurred, please try again");
    }
    if (e is DioException) {
      logger.d(e);
      if (e.type == DioExceptionType.badResponse) {
        logger.e(e.response.toString());
        if (e.response.runtimeType == int) {
          return ("Server Error");
        }
        if(e.response?.statusCode == 401){
          logger.w(e.response?.statusCode);
          final nav =  getIt<NavigationService>();
          final _db = getIt<DBService>();
          if (nav.navigatorKey != null) {
            _db.clear();
            nav.navigateTo(Routes.authenticate);
          } else {
            nav.navigateTo(Routes.authenticate);
            return ("Session Expired! Unable to navigate to login.");
          }
          return (e.response?.data['message'] ?? "Session Expired!");
        }
        return (e.response?.data['message'] ?? e.response?.data['data']['message'] ?? e.message);
      }
      if (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.connectionTimeout) {
        return ("Error occurred, please try again");
      }
      return (e.response?.data['message'] ?? e.response?.data['error'] ?? e.message);
    }
    return ("Fail to process");

  }

}