// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

part of amplify_interface;

class PushNotificationsCategory
    extends AmplifyCategory<PushNotificationsPluginInterface> {
  @override
  @nonVirtual
  Category get category => Category.pushNotifications;

  /// {@template amplify_core.amplify_push_notifications_category.get_permission_status}
  /// The current Push Notificaiton permission state.
  ///
  /// The status can be one of the following:
  /// 1. notRequested - Android only status to indicate push permissions dialogue has not been requested
  /// 2. shouldRequestWithRationale - show a rationale message on why the app needs to send push notifications
  /// 3. granted - end user has granted the request for the app to send push notifications
  /// 4. denied - end user has denied the request for the app to send push notifications
  /// {@endtemplate}
  Future<PushNotificationPermissionStatus> getPermissionStatus() =>
      defaultPlugin.getPermissionStatus();

  /// {@template amplify_core.amplify_push_notifications_category.request_permissions}
  /// Request push notifications permissions with options.
  ///
  /// On iOS, these control the
  /// [granular permissions](https://developer.apple.com/documentation/usernotifications/unauthorizationoptions)
  /// On Android, it has no effect
  /// It returns true if granted or false if denied.
  /// {@endtemplate}
  Future<bool> requestPermissions({
    bool alert = true,
    bool badge = true,
    bool sound = true,
  }) =>
      defaultPlugin.requestPermissions(
        alert: alert,
        badge: badge,
        sound: sound,
      );

  /// {@template amplify_core.amplify_push_notifications_category.on_token_received}
  /// Listen to new Device tokens generated by FCM and APNS
  ///
  /// Device token is a unique string that identifies the device with FCM or APNS depending on the platform.
  /// This method will check for a new device token on every app start and emit an event with the device token to every
  /// listener.
  /// {@endtemplate}
  Stream<String> get onTokenReceived => defaultPlugin.onTokenReceived;

  /// {@template amplify_core.amplify_push_notifications_category.on_foreground_notification_received}
  /// Will emit a [PushNotificationMessage] as the device receives them when the App is in the foreground.
  ///
  /// The following mutually exclusive methods are to be used in order to listen to all incoming
  /// Push Notifications and user tap events,
  /// 1. [onNotificationReceivedInForeground] to receive updates on new push notifications when the app is in foreground.
  /// 2. [onNotificationReceivedInBackground] to receive updated on new push notifications when the app is in background.
  /// 3. [onNotificationOpened] to receive updates when app opens as a result of user tapping on it.
  /// {@endtemplate}
  Stream<PushNotificationMessage> get onNotificationReceivedInForeground =>
      defaultPlugin.onNotificationReceivedInForeground;

  /// {@template amplify_core.amplify_push_notifications_category.on_background_notification_received}
  /// Register an [OnRemoteMessageCallback] to be called when the device receives push notification
  /// and the App is in the background.
  /// {@endtemplate}
  void onNotificationReceivedInBackground(OnRemoteMessageCallback callback) =>
      defaultPlugin.onNotificationReceivedInBackground(callback);

  /// {@template amplify_core.amplify_push_notifications_category.on_notification_opened}
  /// Will emit the [PushNotificationMessage] that an end user has tapped on to open the App.
  /// {@endtemplate}
  Stream<PushNotificationMessage> get onNotificationOpened =>
      defaultPlugin.onNotificationOpened;

  /// {@template amplify_core.amplify_push_notifications_category.get_launch_notification}
  /// Returns a [PushNotificationMessage] or null depending on what action launched the app.
  ///
  /// It either returns the notification that has been tapped by an end user to launch the
  /// App, or else returns null if the app was launched by any other means.
  /// {@endtemplate}
  PushNotificationMessage? get launchNotification =>
      defaultPlugin.launchNotification;

  /// {@template amplify_core.amplify_push_notifications_category.identify_user}
  /// Associate the given user information with the current device.
  ///
  /// Useful for targeting user centric push notification campaigns.
  /// {@endtemplate}
  Future<void> identifyUser({
    required String userId,
    required AnalyticsUserProfile userProfile,
  }) =>
      defaultPlugin.identifyUser(
        userId: userId,
        userProfile: userProfile,
      );

  /// {@template amplify_core.amplify_push_notifications_category.get_badge_count}
  /// Returns the current number displayed in the app icon badge.
  ///
  /// This method takes effect only on iOS.
  /// {@endtemplate}
  Future<int> getBadgeCount() => defaultPlugin.getBadgeCount();

  /// {@template amplify_core.amplify_push_notifications_category.set_badge_count}
  /// Sets [badgeCount] as the number displayed in the App icon badge.
  ///
  /// This method takes effect only on iOS.
  /// {@endtemplate}
  Future<void> setBadgeCount(int badgeCount) =>
      defaultPlugin.setBadgeCount(badgeCount);
}
