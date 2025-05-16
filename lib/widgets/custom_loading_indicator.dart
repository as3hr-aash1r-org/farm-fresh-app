import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final String? message;
  final bool isFullScreen;

  const CustomLoadingIndicator({
    Key? key,
    this.message,
    this.isFullScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadingWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
        ),
        if (message != null) ...[  
          const SizedBox(height: 16),
          Text(
            message!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppConstants.textColor,
            ),
          ),
        ],
      ],
    );

    if (isFullScreen) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: loadingWidget),
      );
    }

    return Center(child: loadingWidget);
  }
}

// Overlay loading indicator that blocks user interaction
class OverlayLoadingIndicator extends StatelessWidget {
  final String? message;

  const OverlayLoadingIndicator({Key? key, this.message}) : super(key: key);

  // Show the loading overlay
  static Future<void> show(BuildContext context, {String? message}) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return OverlayLoadingIndicator(message: message);
      },
    );
  }

  // Hide the loading overlay
  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevent back button from dismissing
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
              ),
              if (message != null) ...[  
                const SizedBox(height: 16),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppConstants.textColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
