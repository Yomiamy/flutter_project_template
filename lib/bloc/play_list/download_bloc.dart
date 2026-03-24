import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_home_work/bloc/status.dart';
import 'package:flutter_home_work/data/paly_list/dto/dto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'download_event.dart';
import 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final Dio _dio;

  DownloadBloc({required Dio dio})
      : _dio = dio,
        super(const DownloadState()) {
    on<DownloadStart>(_onDownloadStart);
    on<DownloadProgressUpdate>(_onProgressUpdate);
    on<DownloadComplete>(_onComplete);
    on<DownloadFail>(_onFail);
    on<DownloadCheckStatus>(_onCheckStatus);
  }

  Future<String> _getFilePath(PlayListItem item) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = '${item.id}.${item.fileExt ?? 'mp3'}';
    return join(directory.path, fileName);
  }

  FutureOr<void> _onCheckStatus(
      DownloadCheckStatus event, Emitter<DownloadState> emit) async {
    final Set<int> downloadedIds = {};
    for (final item in event.items) {
      if (item.id == null) continue;
      final path = await _getFilePath(item);
      if (await File(path).exists()) {
        downloadedIds.add(item.id!);
      }
    }
    emit(state.copyWith(downloadedIds: downloadedIds));
  }

  FutureOr<void> _onDownloadStart(
      DownloadStart event, Emitter<DownloadState> emit) async {
    final item = event.item;

    if (item.id == null || item.url == null) return;

    final id = item.id!;
    final url = item.url!;
    final savePath = await _getFilePath(item);
    final newProgress = Map<int, double>.from(state.progress);
    newProgress[id] = 0.0;
    emit(state.copyWith(progress: newProgress));

    try {
      await _dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            add(DownloadProgressUpdate(id: id, progress: (received / total)));
          }
        },
      );
      add(DownloadComplete(id: id));
    } catch (e) {
      add(DownloadFail(id: id, message: e.toString()));
    }
  }

  void _onProgressUpdate(
      DownloadProgressUpdate event, Emitter<DownloadState> emit) {
    final newProgress = Map<int, double>.from(state.progress);
    newProgress[event.id] = event.progress;
    emit(state.copyWith(progress: newProgress));
  }

  void _onComplete(DownloadComplete event, Emitter<DownloadState> emit) {
    final newProgress = Map<int, double>.from(state.progress);
    newProgress.remove(event.id);

    final newDownloadedIds = Set<int>.from(state.downloadedIds);
    newDownloadedIds.add(event.id);

    emit(state.copyWith(
      progress: newProgress,
      downloadedIds: newDownloadedIds,
    ));
  }

  void _onFail(DownloadFail event, Emitter<DownloadState> emit) {
    final newProgress = Map<int, double>.from(state.progress);
    newProgress.remove(event.id);

    emit(state.copyWith(
      status: Status.failure,
      errorMsg: event.message,
      progress: newProgress,
    ));
  }
}
