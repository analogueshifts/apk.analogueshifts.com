class AuthState {
  bool _isGenerating = false;

  bool get isGenerating => _isGenerating;





  void toggleGenerating() {
    _isGenerating = !_isGenerating;
  }
}