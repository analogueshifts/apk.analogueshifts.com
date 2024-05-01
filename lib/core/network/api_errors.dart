import 'dart:async';
import 'dart:io';

import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ErrorHandler  {

  /// Function to handle error messages from the server
  String handleError(dynamic e) {
    Logger().d(e);
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
      if (e.type == DioExceptionType.badResponse) {
        logger.e(e.response.toString());
        if (e.response.runtimeType == int) {
          return ("Server Error");
        }
        return (e.response?.data['message'] ?? e.response?.data['data']['message'] ?? e.message);
      }
      if (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.connectionTimeout) {
        return ("Error occurred, please try again");
      }
      return (e.response?.data['message'] ?? e.response?.data['error'] ?? e.message);
    }
    return (e.toString());

  }

}