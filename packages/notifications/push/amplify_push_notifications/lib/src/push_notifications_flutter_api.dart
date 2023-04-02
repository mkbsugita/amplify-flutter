import 'dart:async';
import 'dart:ui';

import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_push_notifications/amplify_push_notifications.dart';
import 'package:amplify_push_notifications/src/native_push_notifications_plugin.g.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

final AmplifyLogger _logger = AmplifyLogger.category(Category.pushNotifications)
    .createChild('AmplifyPushNotification');

/// {@template amplify_push_notifications.amplify_push_notifications_flutter_api}
/// Internal Platform check exposed for testing purposes only.
/// {@endtemplate}
class AmplifyPushNotificationsFlutterApi
    implements PushNotificationsFlutterApi {
  /// {@macro amplify_push_notifications.amplify_push_notifications_flutter_api}
  AmplifyPushNotificationsFlutterApi() {
    PushNotificationsFlutterApi.setup(this);
  }

  final _eventQueue = <PushNotificationMessage>[];

  /// {@template amplify_push_notifications.event_queue}
  /// Internal eventQueue getter exposed for testing purposes only.
  /// {@endtemplate}
  @visibleForTesting
  List<PushNotificationMessage> get eventQueue => _eventQueue;

  final _onNotificationReceivedInBackgroundCallbacks =
      <OnRemoteMessageCallback>[];

  /// {@template amplify_push_notifications.on_notification_received_in_background_callbacks}
  /// Internal callbacks list getter exposed for testing purposes only.
  /// {@endtemplate}
  @visibleForTesting
  List<OnRemoteMessageCallback>
      get onNotificationReceivedInBackgroundCallbacks =>
          _onNotificationReceivedInBackgroundCallbacks;

  /// {@template amplify_push_notifications.register_on_received_In_background_callback}
  /// Used to register callback function on iOS.
  /// {@endtemplate}
  void registerOnReceivedInBackgroundCallback(
    OnRemoteMessageCallback callback,
  ) {
    _onNotificationReceivedInBackgroundCallbacks.add(callback);
  }

  ServiceProviderClient? _serviceProviderClient;

  set serviceProviderClient(ServiceProviderClient serviceProviderClient) {
    _serviceProviderClient = serviceProviderClient;
    // Flush when the service provider client is ready. Needed when Amplify is reconfigured from [amplifyBackgroundProcessing]
    // or when the app gets woken up in the background from a killed state on iOS and Amplify is configured.
    unawaited(_flushEvents());
  }

  Future<void> _dispatchToExternalHandle(
    PushNotificationMessage pushNotificationMessage,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final externalHandle = prefs.getInt(externalHandleKey);
    if (externalHandle == null) {
      _logger.debug(
        'Could not locate stored external handle',
      );
      return;
    }
    final externalCallback = PluginUtilities.getCallbackFromHandle(
      CallbackHandle.fromRawHandle(externalHandle),
    );
    if (externalCallback == null) {
      _logger.debug(
        'Could not locate external callback for the stored external handle',
      );
      return;
    }
    if (externalCallback is! OnRemoteMessageCallback) {
      throw PushNotificationException(
        'Invalid callback type: ${externalCallback.runtimeType}',
      );
    }
    externalCallback(pushNotificationMessage);
  }

  @override
  Future<void> onNotificationReceivedInBackground(
    Map<Object?, Object?> payload,
  ) async {
    final notification = PushNotificationMessage.fromJson(payload);

    // Queue when service client is not available without blocking invocation of external callback
    if (_serviceProviderClient != null) {
      await _flushEvents(withItem: notification);
    } else {
      _eventQueue.add(notification);
    }

    await _dispatchToExternalHandle(notification);
    await Future.wait(
      _onNotificationReceivedInBackgroundCallbacks.map(
        (callback) async {
          await callback(notification);
        },
      ),
    );
  }

  Future<void> _flushEvents({PushNotificationMessage? withItem}) async {
    for (final element
        in [..._eventQueue, withItem].whereType<PushNotificationMessage>()) {
      await _serviceProviderClient?.recordNotificationEvent(
        eventType: PinpointEventType.backgroundMessageReceived,
        notification: element,
      );
    }
    _eventQueue.clear();
  }
}