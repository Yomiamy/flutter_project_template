part of 'get_play_list_bloc.dart';

final class GetPlayListState extends Equatable {
  final Status status;
  final String? errorMsg;
  final List<PlayListItem>? playListItem;

  const GetPlayListState({
    this.status = Status.initial,
    this.errorMsg,
    this.playListItem,
  });

  GetPlayListState copyWith({
    Status? status,
    String? errorMsg,
    List<PlayListItem>? playListItem,
  }) {
    return GetPlayListState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      playListItem: playListItem ?? this.playListItem,
    );
  }

  @override
  List<Object?> get props => [status, errorMsg, playListItem];
}
