
import 'package:finalproject/features/post/data/model/post_service_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_service_dto.g.dart';

@JsonSerializable()
class PostServiceDTO {
  final PostServiceModel service;

  PostServiceDTO({required this.service});

  factory PostServiceDTO.fromJson(Map<String, dynamic> json) => _$PostServiceDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PostServiceDTOToJson(this);
}
