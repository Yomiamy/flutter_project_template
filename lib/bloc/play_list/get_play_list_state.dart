part of 'get_play_list_bloc.dart';

final class GetPlayListState extends Equatable {
  final Status status;
  final String? errorMsg;
  final List<PlayListItem>? playListItem;
  final int page;
  final int? total;

  const GetPlayListState({
    this.status = Status.initial,
    this.errorMsg,
    this.playListItem,
    this.page = 0,
    this.total,
  });

  GetPlayListState copyWith({
    Status? status,
    String? errorMsg,
    List<PlayListItem>? playListItem,
    int? page,
    int? total,
  }) {
    return GetPlayListState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      playListItem: playListItem ?? this.playListItem,
      page: page ?? this.page,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [status, errorMsg, playListItem, page, total];
}

extension GetPlayListStateX on GetPlayListState {
  bool get hasMore =>
      total == null || (playListItem?.length ?? 0) < (total ?? 0);
}
