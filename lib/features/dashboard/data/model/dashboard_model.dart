import 'package:equatable/equatable.dart';
import 'package:finalproject/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

final dashboardtModelProvider = Provider((ref) {
  return DashboardModel.empty();
});

@JsonSerializable()
class DashboardModel {
  @JsonKey(name: '_id')
  final String productId;
  final String productTitle;
  final int productPrice;
  final String productDescription;
  final String productCategory;
  final String productLocation;
  final String productImage;

  const DashboardModel({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
    required this.productLocation,
    required this.productImage,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      productId: json['_id'],
      productTitle: json['productTitle'],
      productDescription: json['productDescription'],
      productCategory: json['productCategory'],
      productPrice: json['productPrice'],
      productLocation: json['productLocation'],
      productImage: json['productImage'],
    );
  }

  DashboardEntity toEntity() => DashboardEntity(
      productId: productId,
      productTitle: productTitle,
      productDescription: productDescription,
      productCategory: productCategory,
      productPrice: productPrice,
      productLocation: productLocation,
      productImage: productImage);

  DashboardModel.empty()
      : productId = '',
        productTitle = '',
        productDescription = '',
        productCategory = '',
        productPrice = 0,
        productLocation = '',
        productImage = '';
}
