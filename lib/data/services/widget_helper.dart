import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class WidgetHelper {
  static const MethodChannel _channel = MethodChannel(
    'com.example.tasky/update_widget',
  );

  /// Updates the Android home widget by invoking the native method channel
  static Future<void> updateWidget() async {
    try {
      await _channel.invokeMethod('updateWidget');
    } catch (e) {
      // Silently handle errors - widget update is not critical for app functionality
      // Log error in debug mode if needed
      if (kDebugMode) {
        print('Error updating widget: $e');
      }
    }
  }
}
