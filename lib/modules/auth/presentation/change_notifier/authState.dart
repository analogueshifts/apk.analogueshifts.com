

import 'package:analogue_shifts_mobile/modules/auth/domain/entities/login_response_entity.dart';

class AuthState {
  bool _isGenerating = false;

  bool get isGenerating => _isGenerating;

  String? _deviceToken;

  String? get deviceToken => _deviceToken;

  User? _user;

  User? get user => _user;

  void updateUser(User value){
    _user = value;
  }

  void updateDeviceToken(String token){
    _deviceToken = token;
  }





  void toggleGenerating() {
    _isGenerating = !_isGenerating;
  }
}