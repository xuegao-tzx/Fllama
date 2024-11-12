import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:fllama/fllama.dart';
import 'package:fllama_example/db/IsarDao.dart';
import 'package:fllama_example/utils/DialogUtils.dart';
import 'package:fllama_example/view/module/DownloadButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vibration/vibration.dart';

class ModelDownloadController extends DownloadController with ChangeNotifier {
  ModelDownloadController({
    DownloadStatus downloadStatus = DownloadStatus.notDownloaded,
    double progress = 0.0,
    String downloadUrl = "",
    String fileHash = "",
    String modelName = "",
    String quantMethod = "",
    String modelSize = "",
    String modelPolicy = "",
  })  : _downloadStatus = downloadStatus,
        _progress = progress,
        _downloadUrl = downloadUrl,
        _fileHash = fileHash,
        _fileName = "${modelName}_$quantMethod",
        _modelName = modelName,
        _quantMethod = quantMethod,
        _modelSize = modelSize,
        _modelPolicy = modelPolicy;

  DownloadStatus _downloadStatus;

  @override
  DownloadStatus get downloadStatus => _downloadStatus;

  double _progress;

  @override
  double get progress => _progress;

  bool _isDownloading = false;

  final String _downloadUrl;

  final String _fileHash;

  final String _fileName;

  final String _modelName;
  final String _quantMethod;
  final String _modelSize;
  final String _modelPolicy;

  DownloadTask? backgroundDownloadTask;

  @override
  void startDownload() {
    Get.log("[downloadStatus]=$downloadStatus");
    if (downloadStatus == DownloadStatus.notDownloaded) {
      _doDownload();
    }
  }

  @override
  Future<void> stopDownload() async {
    if (_isDownloading) {
      if (backgroundDownloadTask != null) {
        await FileDownloader()
            .cancelTasksWithIds([backgroundDownloadTask!.taskId]);
        _isDownloading = false;
        _downloadStatus = DownloadStatus.notDownloaded;
        _progress = 0.0;
        notifyListeners();
      }
    }
  }

  @override
  Future<void> deleteDownload() async {
    if (await Vibration.hasVibrator() == true) {
      if (await Vibration.hasCustomVibrationsSupport() == true) {
        Vibration.vibrate(duration: 123, amplitude: 36);
      } else {
        Vibration.vibrate();
      }
    }
    if (_isDownloading) {
      final ans = await Get.dialog(showCustomDialog(
        context: Get.context!,
        title: "Cancel Download".tr,
        confirm: "OK".tr,
        cancel: "Cancel".tr,
      ));
      if (ans == true) {
        if (backgroundDownloadTask != null) {
          await FileDownloader()
              .cancelTaskWithId(backgroundDownloadTask!.taskId);
          _progress = 0.0;
          _isDownloading = false;
          _downloadStatus = DownloadStatus.notDownloaded;
          notifyListeners();
        }
      }
    } else {
      final ans = await Get.dialog(showCustomDialog(
        context: Get.context!,
        title: "Delete Download File".tr,
        confirm: "OK".tr,
        cancel: "Cancel".tr,
      ));
      if (ans == true) {
        await IsarDao.instance()?.deleteOneModel(
            mName: _modelName,
            mSize: _modelSize,
            quantMethod: _quantMethod,
            policy: _modelPolicy);
        _progress = 0.0;
        _isDownloading = false;
        _downloadStatus = DownloadStatus.notDownloaded;
        notifyListeners();
      }
    }
  }

  @override
  Future<void> pauseDownload() async {
    if (_isDownloading) {
      if (backgroundDownloadTask != null) {
        await FileDownloader().pause(backgroundDownloadTask!);
        _isDownloading = false;
        _downloadStatus = DownloadStatus.pauseDownloaded;
        notifyListeners();
      }
    }
  }

  @override
  Future<void> resumeDownload() async {
    if (!_isDownloading) {
      if (backgroundDownloadTask != null) {
        await FileDownloader().resume(backgroundDownloadTask!);
        _isDownloading = true;
        _downloadStatus = DownloadStatus.downloading;
        notifyListeners();
      }
    }
  }

  Future<void> getPermission(PermissionType permissionType) async {
    var status = await FileDownloader().permissions.status(permissionType);
    if (status != PermissionStatus.granted) {
      if (await FileDownloader()
          .permissions
          .shouldShowRationale(permissionType)) {
        Get.log('Showing some rationale');
      }
      status = await FileDownloader().permissions.request(permissionType);
      Get.log('Permission for $permissionType was $status');
    }
  }

  Future<void> _doDownload() async {
    Get.log("[isDownloading]=$_isDownloading");
    await getPermission(PermissionType.notifications);
    if (_isDownloading) {
      return;
    }
    _isDownloading = true;
    _downloadStatus = DownloadStatus.fetchingDownload;
    notifyListeners();
    final Directory libraryDirectory = Platform.isAndroid
        ? await getApplicationSupportDirectory()
        : await getLibraryDirectory();
    final mFPath =  "${libraryDirectory.path}/model/$_fileName.gguf";
    Get.log(
        "_downloadUrl=$_downloadUrl _fileHash=$_fileHash _fileName=$_fileName Path=$mFPath");
    final (baseDirectory, directory, filename) =
        await Task.split(filePath: mFPath);
    Get.log(
        "baseDirectory=$baseDirectory directory=$directory filename=$filename");
    backgroundDownloadTask = DownloadTask(
      url: _downloadUrl,
      filename: filename,
      directory: directory,
      baseDirectory: baseDirectory,
      updates: Updates.statusAndProgress,
      retries: 3,
      allowPause: true,
      requiresWiFi: true, //Only WIFI can Download!
    );
    await FileDownloader().download(backgroundDownloadTask!,
        onProgress: (progress) async {
      Get.log("[progress]=$progress");
      switch (progress) {
        case 0.0:
          _progress = 0.01;
          _isDownloading = true;
          _downloadStatus = DownloadStatus.downloading;
          notifyListeners();
          break;
        case 1.0:
          _progress = 0.99;
          notifyListeners();
          try {
            if (await Fllama.instance()?.getFileSHA256(mFPath) == _fileHash) {
              Get.log("[文件SHA256验证成功] mFPath=$mFPath");
              await IsarDao.instance()?.addOneDownloadModel(
                  mName: _modelName,
                  mPath: mFPath,
                  mSize: _modelSize,
                  quantMethod: _quantMethod,
                  policy: _modelPolicy);
              _progress = 1.0;
              _downloadStatus = DownloadStatus.downloaded;
              _isDownloading = false;
            } else {
              Get.log("[文件SHA256验证失败]");
              await File(mFPath).delete();
              _progress = 0.0;
              _isDownloading = false;
              _downloadStatus = DownloadStatus.notDownloaded;
            }
          } catch (e) {
            Get.log("[文件SHA256验证失败-异常]=$e");
            await File(mFPath).delete();
            _progress = 0.0;
            _isDownloading = false;
            _downloadStatus = DownloadStatus.notDownloaded;
          }
          notifyListeners();
          break;
        case -1.0:
        case -2.0:
        case -3.0:
        case -5.0:
          _downloadStatus = DownloadStatus.pauseDownloaded;
          _isDownloading = false;
          notifyListeners();
          break;
        case -4.0:
          _downloadStatus = DownloadStatus.fetchingDownload;
          notifyListeners();
        default:
          _progress = progress;
          _downloadStatus = DownloadStatus.downloading;
          _isDownloading = true;
          notifyListeners();
      }
    });
  }

  @override
  void setDownloadStatus(DownloadStatus status) {
    if (!_isDownloading) {
      if (status == DownloadStatus.downloaded) {
        _progress = 1.0;
        _isDownloading = false;
      }
      if (status == DownloadStatus.notDownloaded) {
        _progress = 0.0;
        _isDownloading = false;
      }
      _downloadStatus = status;
      notifyListeners();
    }
  }
}
