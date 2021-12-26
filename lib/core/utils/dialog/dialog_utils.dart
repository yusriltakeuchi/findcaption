import 'package:animations/animations.dart';
import 'package:findcaption/core/utils/navigation/navigation_utils.dart';
import 'package:findcaption/ui/widgets/dialog/info_dialog.dart';
import 'package:findcaption/ui/widgets/dialog/loading_dialog.dart';
import 'package:flutter/material.dart';

class DialogShow {
  static var inputController = TextEditingController();

  static void showInfo(
    String message,
    String title,
    String buttonText, {
    Function? onClick,
    Widget? contentTextWidget,
    bool dismiss = false,
  }) {
    showModal(
      context: navigate.navigatorKey.currentContext!,
      configuration: FadeScaleTransitionConfiguration(
        barrierDismissible: dismiss,
      ),
      builder: (context) {
        return InfoDialog(
          text: message,
          onClickOK: () => onClick != null ? onClick() : navigate.pop(),
          clickText: buttonText,
          title: title,
          contentTextWidget: contentTextWidget,
        );
      },
    );
  }

  static void showChoose(
    String message,
    String title,
    String buttonText, {
    Function? onClick,
    Widget? contentTextWidget,
    String? cancelText,
    Function? onClickCancel,
  }) {
    showModal(
      context: navigate.navigatorKey.currentContext!,
      configuration: const FadeScaleTransitionConfiguration(
        barrierDismissible: false,
      ),
      builder: (context) {
        return InfoDialog(
          text: message,
          onClickOK: () => onClick != null ? onClick() : navigate.pop(),
          onClickCancel: () =>
              onClickCancel != null ? onClickCancel() : navigate.pop(),
          clickText: buttonText,
          contentTextWidget: contentTextWidget,
          title: title,
          cancelText: cancelText,
        );
      },
    );
  }

  static void showLoading(String message) {
    showModal(
      context: navigate.navigatorKey.currentContext!,
      configuration: const FadeScaleTransitionConfiguration(
        barrierDismissible: false,
      ),
      builder: (context) {
        return LoadingDialog(
          text: message,
        );
      },
    );
  }
}
