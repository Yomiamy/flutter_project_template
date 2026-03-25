part of 'download_bloc.dart';

abstract class DownloadEvent extends Equatable {
  const DownloadEvent();

  @override
  List<Object?> get props => [];
}

class DownloadStart extends DownloadEvent {
  final PlayListItem item;

  const DownloadStart({required this.item});

  @override
  List<Object?> get props => [item];
}

class DownloadCheckStatus extends DownloadEvent {
  final List<PlayListItem> items;

  const DownloadCheckStatus({required this.items});

  @override
  List<Object?> get props => [items];
}

class DownloadProgressUpdate extends DownloadEvent {
  final int id;
  final double progress;

  const DownloadProgressUpdate({required this.id, required this.progress});

  @override
  List<Object?> get props => [id, progress];
}

class DownloadComplete extends DownloadEvent {
  final int id;
  final String savePath;

  const DownloadComplete({required this.id, required this.savePath});

  @override
  List<Object?> get props => [id, savePath];
}

class DownloadFail extends DownloadEvent {
  final int id;
  final String message;

  const DownloadFail({required this.id, required this.message});

  @override
  List<Object?> get props => [id, message];
}
