// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewDTO _$ReviewDTOFromJson(Map<String, dynamic> json) => ReviewDTO(
      id: json['_id'] as String,
      serviceId: json['serviceId'] as String,
      userId: UserDTO.fromJson(json['userId'] as Map<String, dynamic>),
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ReviewDTOToJson(ReviewDTO instance) => <String, dynamic>{
      '_id': instance.id,
      'serviceId': instance.serviceId,
      'userId': instance.userId,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
    };
