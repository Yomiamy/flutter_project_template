import 'package:flutter_home_work/bloc/play_list/play_list.dart';

extension DownloadStateX on DownloadState {
  bool isDownloaded(int? id) => downloadedIds.contains(id);

  double? getDownloadProgress(int? id) => progress[id];

  bool isDownloading(int? id) => progress.containsKey(id);
}
