import 'package:finalproject/features/rateAndReview/domain/entity/review_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'user_dto.dart';

part 'review_dto.g.dart';

@JsonSerializable()
class ReviewDTO {
  @JsonKey(name: '_id')
  final String id;
  final String serviceId;
  final UserDTO userId;
  final double rating;
  final String comment;
  final DateTime createdAt;

  ReviewDTO({
    required this.id,
    required this.serviceId,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ReviewDTO.fromJson(Map<String, dynamic> json) =>
      _$ReviewDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewDTOToJson(this);

  ReviewEntity toEntity() {
    return ReviewEntity(
      id: id,
      serviceId: serviceId,
      userId: userId.id,
      userName: userId.fname,  // Use fname directly
      rating: rating,
      comment: comment,
      createdAt: createdAt,
    );
  }

  static ReviewDTO fromEntity(ReviewEntity entity) {
    return ReviewDTO(
      id: entity.id,
      serviceId: entity.serviceId,
      userId: UserDTO(id: entity.userId, fname: entity.userName),  // Only fname
      rating: entity.rating,
      comment: entity.comment,
      createdAt: entity.createdAt,
    );
  }
}