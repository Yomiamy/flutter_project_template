import 'package:equatable/equatable.dart';
import 'package:flutter_home_work/data/paly_list/dto/dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rsp_play_list.g.dart';

@JsonSerializable()
class RspPlayList extends Equatable {
  final int? total;
  final List<PlayListItem>? data;

  const RspPlayList({
    this.total,
    this.data,
  });

  RspPlayList copyWith({
    int? total,
    List<PlayListItem>? data,
  }) {
    return RspPlayList(
      total: total ?? this.total,
      data: data ?? this.data,
    );
  } 

  factory RspPlayList.fromJson(Map<String, dynamic> json) =>
      _$RspPlayListFromJson(json);

  Map<String, dynamic> toJson() => _$RspPlayListToJson(this);

  @override
  List<Object?> get props => [];
}
