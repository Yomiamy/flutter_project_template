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
  final int page;
  final String lang;

  const GetPlayListQuery({required this.page, required this.lang});

  @override
  List<Object?> get props => [page];
}

class GetPlayListSuccess extends GetPlayListEvent {
  final List<PlayListItem> playListItem;

  const GetPlayListSuccess({required this.playListItem});

  @override
  List<Object?> get props => [playListItem];  
}

class GetPlayListFail extends GetPlayListEvent {
  final String message;

  const GetPlayListFail({required this.message});

  @override
  List<Object?> get props => [message];
}
