import 'dart:async';
import 'dart:math';

import 'package:farm_fresh_shop_app/helpers/styles/app_color.dart';
import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:flutter/material.dart';

import 'verify_phone_helpers.dart';

List<T> parseList<T>(
  data,
  T Function(Map<String, dynamic>) fromJson,
) {
  final parsedData = (data as List?)?.cast<Map<String, dynamic>>();
  return parsedData?.map(fromJson).toList().cast<T>() ?? [];
}

Future<void> showToast(String message, {Color? color}) async {
  if (!AppNavigation.context.mounted) return;

  final navigator = Navigator.of(AppNavigation.context, rootNavigator: true);
  Future.delayed(const Duration(seconds: 2), () {
    if (AppNavigation.context.mounted && navigator.canPop()) {
      navigator.pop();
    }
  });

  await showDialog(
    context: AppNavigation.context,
    barrierColor: Colors.transparent,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        insetAnimationCurve: Curves.easeIn,
        insetAnimationDuration: const Duration(milliseconds: 500),
        elevation: 0,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
            decoration: BoxDecoration(
              color: color ?? AppColor.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    message.isEmpty
                        ? "Unknown Error Occured, We are working on it"
                        : message,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<bool> showConfirmationDialog(String title,
    {String? yesText,
    String? noText,
    VoidCallback? onYes,
    VoidCallback? onNo}) async {
  final context = AppNavigation.context;
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            actionsPadding: const EdgeInsets.all(0),
            backgroundColor: Colors.white,
            title: Text(title,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                )),
            actions: [
              TextButton(
                onPressed: () =>
                    onNo != null ? onNo() : Navigator.of(context).pop(false),
                child: Text(noText ?? 'No',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              TextButton(
                onPressed: () =>
                    onYes != null ? onYes() : Navigator.of(context).pop(true),
                child: Text(yesText ?? 'Yes',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          );
        },
      ) ??
      false;
}

Color get getRandomMangoColor => [
      AppColor.blue,
      AppColor.peach,
      AppColor.green,
      AppColor.lightYellow,
      AppColor.orange,
      AppColor.green,
    ][Random().nextInt(6)];

extension TimerExtension on VerifyPhoneHelper {
  void initializeTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
      } else {
        timer.cancel();
      }
    });
  }
}
