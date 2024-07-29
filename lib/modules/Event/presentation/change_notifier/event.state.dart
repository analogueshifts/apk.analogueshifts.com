import 'package:analogue_shifts_mobile/core/utils/logger.dart';

class EventsState {
  bool _isGenerating = false;

  bool get isGenerating => _isGenerating;




  void toggleGenerating() {
    _isGenerating = !_isGenerating;
  }
}