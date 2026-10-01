import 'package:flutter/services.dart';

/// SMS permission state.
///
/// This goes through the app's own MethodChannel rather than a permission
/// plugin, which keeps the dependency list free of anything that might add the
/// INTERNET permission.
class PermissionService {
  PermissionService({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel('com.moneytrail.app/sms');

  final MethodChannel _channel;

  /// True when both READ_SMS and RECEIVE_SMS are granted.
  Future<bool> hasSmsPermission() => _invoke('hasSmsPermission');

  /// Shows the system prompt and resolves to the user's answer.
  Future<bool> requestSmsPermission() => _invoke('requestSmsPermission');

  Future<bool> _invoke(String method) async {
    try {
      return await _channel.invokeMethod<bool>(method) ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }
}
