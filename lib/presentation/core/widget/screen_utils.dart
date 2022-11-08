
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test_project/domain/core/entities/failures.dart';
import 'package:flutter_test_project/domain/core/utils/constants.dart';

mixin ScreenUtils<T extends StatefulWidget> on State<T> {
  // ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? handleError(
  //     {Failure? failure,
  //     String? customMessage,
  //     Map<ServerErrorCode, String>? customMessages,
  //     bool isFloating = false}) {
  //   return showError(
  //       failure: failure,
  //       customMessage: customMessage,
  //       customMessages: customMessages,
  //       isFloating: isFloating);
  // }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showError(
      {Failure? failure,
      String? customMessage,
      Map<ServerErrorCode, String>? customMessages,
      bool isFloating = false}) {
    String message = customMessage ?? 'error_message'.tr();

    if (failure != null && failure is ServerFailure) {
      if (failure.errorCode == ServerErrorCode.noInternetConnection) {
        message = 'no_internet_connection_message'.tr();
      } else if (failure.errorCode == ServerErrorCode.forbidden) {
        message = 'access_denied_message'.tr();
      } else if (failure.errorCode == ServerErrorCode.unauthenticated) {
        message = 'unauthenticated_message'.tr();
      } else if (failure.message.isNotEmpty) {
        message = failure.message;
      } else if (customMessages != null && customMessages.isNotEmpty) {
        message = customMessages[failure.errorCode] ?? 'error_message'.tr();
      }
    }  else if (failure != null && failure is AppAccessDeniedFailure) {
      message = 'unsupported_company_type'.tr();
    }

    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).errorColor,
      behavior: isFloating ? SnackBarBehavior.floating : null,
    ));
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccess(
      {String? customMessage, bool isFloating = false}) {
    String message = customMessage ?? 'success'.tr();
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).primaryColor,
      behavior: isFloating ? SnackBarBehavior.floating : null,
    ));
  }
}
