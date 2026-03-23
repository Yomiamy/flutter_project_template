// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rsp_play_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RspPlayList _$RspPlayListFromJson(Map<String, dynamic> json) => RspPlayList(
  total: (json['total'] as num?)?.toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => PlayListItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RspPlayListToJson(RspPlayList instance) =>
    <String, dynamic>{'total': instance.total, 'data': instance.data};
