part of 'download_bloc.dart';

class DownloadState extends Equatable {
  final Status status;
  final String? errorMsg;
  final Map<int, double> progress; // id: percentage
  final Set<int> downloadedIds;
  final Map<int, String> downloadedPaths;

  const DownloadState({
    this.status = Status.initial,
    this.errorMsg,
    this.progress = const {},
    this.downloadedIds = const {},
    this.downloadedPaths = const {},
  });

  DownloadState copyWith({
    Status? status,
    String? errorMsg,
    Map<int, double>? progress,
    Set<int>? downloadedIds,
    Map<int, String>? downloadedPaths,
  }) {
    return DownloadState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      progress: progress ?? this.progress,
      downloadedIds: downloadedIds ?? this.downloadedIds,
      downloadedPaths: downloadedPaths ?? this.downloadedPaths,
    );
  }

  @override
  List<Object?> get props => [status, errorMsg, progress, downloadedIds, downloadedPaths];
}

extension DownloadStateX on DownloadState {
  bool isDownloaded(int? id) => downloadedIds.contains(id);

  double? getDownloadProgress(int? id) => progress[id];

  bool isDownloading(int? id) => progress.containsKey(id);

  String? getDownloadedPath(int? id) => downloadedPaths[id];
}
