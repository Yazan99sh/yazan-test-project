
import 'package:flutter/material.dart';
import 'package:flutter_test_project/presentation/core/widget/custom_dialog_widget.dart';

class CustomDialog {
  Future<dynamic> showCustomDialog(
    mainContext, {
    bool barrierDismissible = false,
    isBuilderChild = true,
    String? closeButtonName,
    required String title,
    required String message,
    required String buttonName,
    required OnButtonClick onButtonClick,
    
  }) async {
    return showDialog<dynamic>(
      context: mainContext,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return CustomDialogWidget(
          title: title,
          message: message,
          buttonName: buttonName,
          onButtonClick: onButtonClick,
          closeButtonName: closeButtonName,
        );
      },
    );
  }
}
