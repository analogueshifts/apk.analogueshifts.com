import 'dart:async';
import 'dart:io';

import 'package:analogue_shifts_mobile/core/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ErrorHandler  {

  /// Function to handle error messages from the server
  String handleError(dynamic e) {
    Logger().d(e);
    print(e);
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
        logger.e(e.response);
        return (e.response?.data['message'] ?? e.message);
      }
      if (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.connectionTimeout) {
        return ("Error occurred, please try again");
      }
      return (e.response?.data['message'] ?? e.response?.data['error'] ?? e.message);
    }
    if (e['success'] != null && e['success'] == false) {
      return (e['message'] ?? e['error']);
    }
    return ('Error in requests, try again');

  }

}