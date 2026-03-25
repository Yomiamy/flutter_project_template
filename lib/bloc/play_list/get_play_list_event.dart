part of 'get_play_list_bloc.dart';

sealed class GetPlayListEvent extends Equatable {
  const GetPlayListEvent();

  @override
  List<Object?> get props => [];
}

class GetPlayListInit extends GetPlayListEvent {
  const GetPlayListInit();
}

class GetPlayListQuery extends GetPlayListEvent {
  final String lang;

  const GetPlayListQuery({required this.lang});

  @override
  List<Object?> get props => [lang];
}

class GetPlayListSuccess extends GetPlayListEvent {
  final List<PlayListItem> playListItem;
  final int page;
  final int? total;

  const GetPlayListSuccess({
    required this.playListItem,
    required this.page,
    this.total,
  });

  @override
  List<Object?> get props => [playListItem, page, total];
}

class GetPlayListFail extends GetPlayListEvent {
  final String message;

  const GetPlayListFail({required this.message});

  @override
  List<Object?> get props => [message];
}
