import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'req_play_list.g.dart';

@JsonSerializable()
class ReqPlayList extends Equatable {

  final String lang;
  final int page;

  const ReqPlayList({
    required this.lang,
    required this.page,
  });

  ReqPlayList copyWith({String? lang, int? page}) {
    return ReqPlayList(
      lang: lang ?? this.lang,
      page: page ?? this.page,
    );
  }

  factory ReqPlayList.fromJson(Map<String, dynamic> json) =>
      _$ReqPlayListFromJson(json);

  Map<String, dynamic> toJson() => _$ReqPlayListToJson(this);

  @override
  List<Object?> get props => [
    lang,
    page,
  ];
}
