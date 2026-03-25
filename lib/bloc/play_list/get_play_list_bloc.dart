import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_home_work/bloc/status.dart';
import 'package:flutter_home_work/data/paly_list/dto/dto.dart';
import 'package:flutter_home_work/data/paly_list/play_list_api.dart';
import 'package:logger/logger.dart';

part 'get_play_list_event.dart';
part 'get_play_list_state.dart';

class GetPlayListBloc extends Bloc<GetPlayListEvent, GetPlayListState> {
  final PlayListApi _api;

  factory GetPlayListBloc.dio({required Dio dio}) {
    return GetPlayListBloc._(dio: dio);
  }

  GetPlayListBloc._({required Dio dio})
    : _api = PlayListApi(dio),
      super(const GetPlayListState()) {
    on<GetPlayListInit>(_onInit);
    on<GetPlayListQuery>(_onQuery);
    on<GetPlayListSuccess>(_onSuccess);
    on<GetPlayListFail>(_onFail);
  }

  void _onInit(GetPlayListInit event, Emitter<GetPlayListState> emit) {
    emit(const GetPlayListState());
  }

  FutureOr<void> _onQuery(
    GetPlayListQuery event,
    Emitter<GetPlayListState> emit,
  ) async {
    if (state.status.isLoading) return;
    if (!state.hasMore) return;

    emit(state.copyWith(status: Status.loading));

    final nextPage = state.page + 1;
    try {
      final result = await _api.getPlayList(event.lang, nextPage);
      add(
        GetPlayListSuccess(
          playListItem: result.data ?? [],
          page: nextPage,
          total: result.total,
        ),
      );
    } catch (e) {
      Logger().e('load fail, error:${e.toString()}');
      add(GetPlayListFail(message: e.toString()));
    }
  }

  void _onSuccess(GetPlayListSuccess event, Emitter<GetPlayListState> emit) {
    final items = event.page == 1
        ? event.playListItem
        : [...?state.playListItem, ...event.playListItem];

    emit(
      state.copyWith(
        status: Status.success,
        playListItem: items,
        page: event.page,
        total: event.total,
      ),
    );
  }

  void _onFail(GetPlayListFail event, Emitter<GetPlayListState> emit) {
    emit(state.copyWith(status: Status.failure, errorMsg: event.message));
  }
}
