import 'package:finalproject/features/plan/data/model/plan_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plan_dto.g.dart';

@JsonSerializable()
class FavoriteDTO {
  @JsonKey(name: 'favorites')
  final List<FavoriteModel>? data;
  final bool success;

  FavoriteDTO({
    this.data,
    required this.success,
  });

  factory FavoriteDTO.fromJson(Map<String, dynamic> json) =>
      _$FavoriteDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteDTOToJson(this);
}
