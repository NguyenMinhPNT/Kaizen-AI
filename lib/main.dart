import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'app/app.dart';
import 'app/di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize flutter_foreground_task communication port.
  FlutterForegroundTask.initCommunicationPort();

  // Configure the foreground task notification channel.
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'kaizen_timer_channel',
      channelName: 'Kaizen Timer',
      channelDescription: 'Shows the active habit timer session.',
      channelImportance: NotificationChannelImportance.LOW,
      priority: NotificationPriority.LOW,
    ),
    iosNotificationOptions: const IOSNotificationOptions(
      showNotification: true,
      playSound: false,
    ),
    foregroundTaskOptions: ForegroundTaskOptions(
      eventAction: ForegroundTaskEventAction.nothing(),
      autoRunOnBoot: false,
      allowWifiLock: false,
    ),
  );

  await configureDependencies();
  runApp(const App());
}
