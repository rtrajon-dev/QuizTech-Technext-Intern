import 'package:flutter/material.dart';

class SoundProvider with ChangeNotifier {
  bool _soundOn = true;

  bool get soundOn => _soundOn;

  void toggleSound(bool value) {
    _soundOn = value;
    notifyListeners();
  }
}
