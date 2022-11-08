import 'package:flutter/material.dart';

class RefreshController extends ChangeNotifier {
  bool? refreshController;

  RefreshController() : super();

  void refresh({required bool refreshController}) {
    this.refreshController = refreshController;
    notifyListeners();
  }
}
