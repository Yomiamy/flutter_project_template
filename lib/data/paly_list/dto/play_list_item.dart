import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'play_list_item.g.dart';

@JsonSerializable()
class PlayListItem extends Equatable {
  final int? id;
  final String? title;
  final String? summary;
  final String? url;
  final String? fileExt;
  final String? modified;

  const PlayListItem({
    this.id,
    this.title,
    this.summary,
    this.url,
    this.fileExt,
    this.modified,
  });

  PlayListItem copyWith({
    int? id,
    String? title,
    String? summary,
    String? url,
    String? fileExt,
    String? modified,
  }) {
    return PlayListItem(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      url: url ?? this.url,
      fileExt: fileExt ?? this.fileExt,
      modified: modified ?? this.modified,
    );
  } 

  factory PlayListItem.fromJson(Map<String, dynamic> json) =>
      _$PlayListItemFromJson(json);

  Map<String, dynamic> toJson() => _$PlayListItemToJson(this);

  @override
  List<Object?> get props => [
    id,
    title,
    summary,
    url,
    fileExt,
    modified,
  ];
}