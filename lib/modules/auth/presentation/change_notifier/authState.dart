import 'package:analogue_shifts_mobile/modules/auth/data/models/login_response.model.dart';

class AuthState {
  bool _isGenerating = false;

  bool get isGenerating => _isGenerating;

  String? _deviceToken;

  String? get deviceToken => _deviceToken;

  void updateDeviceToken(String token){
    _deviceToken = token;
  }





  void toggleGenerating() {
    _isGenerating = !_isGenerating;
  }
}