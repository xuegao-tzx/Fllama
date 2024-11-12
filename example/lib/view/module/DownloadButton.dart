/*
 * Copyright (c) 田梓萱[小草林] 2021-2024.
 * All Rights Reserved.
 * All codes are protected by China's regulations on the protection of computer software, and infringement must be investigated.
 * 版权所有 (c) 田梓萱[小草林] 2021-2024.
 * 所有代码均受中国《计算机软件保护条例》保护，侵权必究.
 */

import "package:fllama_example/utils/IconSwitch.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:material_symbols_icons/material_symbols_icons.dart";

enum DownloadStatus {
  notDownloaded,
  pauseDownloaded,
  fetchingDownload,
  downloading,
  downloaded,
  hasDownloaded,
}

abstract class DownloadController implements ChangeNotifier {
  DownloadStatus get downloadStatus;

  double get progress;

  void startDownload();

  void stopDownload();

  void pauseDownload();

  void resumeDownload();

  void deleteDownload();

  void setDownloadStatus(DownloadStatus status);
}

@immutable
class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    required this.status,
    this.downloadProgress = 0.0,
    required this.onDownload,
    required this.onDownloaded,
    required this.onCancel,
    required this.onPause,
    required this.onResume,
    this.transitionDuration = const Duration(milliseconds: 500),
  });

  final DownloadStatus status;
  final double downloadProgress;
  final VoidCallback onDownload;
  final VoidCallback onDownloaded;
  final VoidCallback onCancel;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final Duration transitionDuration;

  bool get _isDownloading => status == DownloadStatus.downloading;

  bool get _isFetching => status == DownloadStatus.fetchingDownload;

  bool get _isDownloaded => status == DownloadStatus.downloaded;

  bool get _isPauseDownloaded => status == DownloadStatus.pauseDownloaded;

  bool get _hasDownloaded => status == DownloadStatus.hasDownloaded;

  void _onPressed() {
    switch (status) {
      case DownloadStatus.notDownloaded:
        onDownload();
        break;
      case DownloadStatus.pauseDownloaded:
        onResume();
        break;
      case DownloadStatus.fetchingDownload:
        onCancel();
        break;
      case DownloadStatus.downloading:
        onPause();
        break;
      case DownloadStatus.downloaded:
      case DownloadStatus.hasDownloaded:
        onDownloaded();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: _onPressed,
      child: Stack(
        children: [
          Offstage(
              offstage: _hasDownloaded,
              child: ButtonShapeWidget(
                transitionDuration: transitionDuration,
                isDownloaded: _isDownloaded,
                isDownloading: _isDownloading,
                isPausing: _isPauseDownloaded,
                isFetching: _isFetching,
                colorScheme: colorScheme,
              )),
          Positioned.fill(
            child: AnimatedOpacity(
              duration: transitionDuration,
              opacity: (_isDownloading || _isFetching || _isPauseDownloaded)
                  ? 1.0
                  : 0.0,
              curve: Curves.ease,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ProgressIndicatorWidget(
                    downloadProgress: downloadProgress,
                    isDownloading: _isDownloading,
                    isFetching: _isFetching,
                    isPausing: _isPauseDownloaded,
                    colorScheme: colorScheme,
                  ),
                  if (_isDownloading)
                    Icon(
                      Symbols.pause,
                      size: 26,
                      color: colorScheme.primary,
                    ),
                  if (_isPauseDownloaded)
                    Icon(
                      Symbols.resume,
                      size: 26,
                      color: colorScheme.primary,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@immutable
class ButtonShapeWidget extends StatelessWidget {
  const ButtonShapeWidget({
    super.key,
    required this.isDownloading,
    required this.isDownloaded,
    required this.isFetching,
    required this.isPausing,
    required this.transitionDuration,
    required this.colorScheme,
  });

  final bool isDownloading;
  final bool isDownloaded;
  final bool isPausing;
  final bool isFetching;
  final Duration transitionDuration;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    var shape = ShapeDecoration(
      shape: const StadiumBorder(),
      color: colorScheme.surfaceContainerHighest,
    );

    if (isDownloading || isFetching || isPausing) {
      shape = ShapeDecoration(
        shape: const CircleBorder(),
        color: colorScheme.primaryContainer,
      );
    }

    return AnimatedContainer(
      duration: transitionDuration,
      curve: Curves.ease,
      width: double.infinity,
      decoration: shape,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: AnimatedOpacity(
          duration: transitionDuration,
          opacity: (isDownloading || isFetching || isPausing) ? 0.0 : 1.0,
          curve: Curves.ease,
          child: isDownloaded
              ? const IconSwitch()
              : const Icon(
                  Symbols.download,
                  size: 26,
                ),
        ),
      ),
    );
  }
}

@immutable
class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({
    super.key,
    required this.downloadProgress,
    required this.isDownloading,
    required this.isFetching,
    required this.isPausing,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;
  final double downloadProgress;
  final bool isDownloading;
  final bool isFetching;
  final bool isPausing;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: downloadProgress),
        duration: const Duration(milliseconds: 200),
        builder: (context, progress, child) {
          return CircularProgressIndicator(
            backgroundColor: (isDownloading || isPausing)
                ? colorScheme.surfaceContainerHighest
                : colorScheme.primary,
            valueColor: AlwaysStoppedAnimation(isFetching
                ? colorScheme.surfaceContainerHighest
                : colorScheme.primary),
            strokeWidth: 2.5,
            value: isFetching ? null : progress,
          );
        },
      ),
    );
  }
}
