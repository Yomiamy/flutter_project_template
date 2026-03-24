part of 'download_bloc.dart';

class DownloadState extends Equatable {
  final Status status;
  final String? errorMsg;
  final Map<int, double> progress; // id: percentage
  final Set<int> downloadedIds;

  const DownloadState({
    this.status = Status.initial,
    this.errorMsg,
    this.progress = const {},
    this.downloadedIds = const {},
  });

  DownloadState copyWith({
    Status? status,
    String? errorMsg,
    Map<int, double>? progress,
    Set<int>? downloadedIds,
  }) {
    return DownloadState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      progress: progress ?? this.progress,
      downloadedIds: downloadedIds ?? this.downloadedIds,
    );
  }

  @override
  List<Object?> get props => [status, errorMsg, progress, downloadedIds];
}
