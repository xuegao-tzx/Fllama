import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:fcllama_example/MyApp.dart';
import 'package:fcllama_example/db/IsarDao.dart';
import 'package:fcllama_example/utils/Tools.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:logger/logger.dart';
import 'package:mmkv/mmkv.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Logger logger = Logger(
  printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 6,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await MMKV.initialize(
      logLevel: kDebugMode ? MMKVLogLevel.Info : MMKVLogLevel.None);
  IsarDao.instance();
  if (Platform.isAndroid) {
    FlutterDisplayMode.setHighRefreshRate();
  }
  PaintingBinding.instance.imageCache.maximumSize = 3000;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 500 << 20;
  await Tools.getDeviceInfo();
  await FileDownloader().trackTasks();
  FileDownloader().configureNotification(
      running: const TaskNotification('Downloading', 'File: {filename}'),
      complete: const TaskNotification('Download Complete', 'File: {filename}'),
      error: const TaskNotification('Download Error', 'File: {filename}'),
      paused: const TaskNotification('Download Paused', 'File: {filename}'),
      progressBar: true);
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
}
