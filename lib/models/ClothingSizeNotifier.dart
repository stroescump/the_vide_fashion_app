import 'package:flutter/cupertino.dart';

class ClothingSizeNotifier extends ChangeNotifier {
  List<bool> _isSizeSelected = [false, false, false, false];

  List<bool> get getIsSelected => _isSizeSelected;

  void setIsSelected(bool value, int index) {
    _isSizeSelected[index] = value;
    notifyListeners();
  }
}
