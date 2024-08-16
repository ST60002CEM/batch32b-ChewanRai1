import 'package:finalproject/features/serviceDetailpage/data/model/service_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_detail_dto.g.dart';

@JsonSerializable()
class ServiceDetailDto {
  final bool success;
  @JsonKey(name: 'service')
  final ServiceDetailModel data;

  ServiceDetailDto({
    required this.success,
    required this.data,
  });

  factory ServiceDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceDetailDtoToJson(this);
}
