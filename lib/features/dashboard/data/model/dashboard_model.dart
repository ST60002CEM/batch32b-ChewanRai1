import 'package:finalproject/features/dashboard/domain/entity/dashboard_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

final dashboardModelProvider = Provider((ref) {
  return DashboardModel.empty();
});

@JsonSerializable()
class DashboardModel {
  @JsonKey(name: '_id')
  final String productId;
  final String productName;
  final int productPrice;
  final String productDescription;
  final String productCategory;
  final String productLocation;
  final String productImage;

  const DashboardModel({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
    required this.productLocation,
    required this.productImage,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      productId: json['_id'],
      productName: json['productName'],
      productDescription: json['productDescription'],
      productCategory: json['productCategory'],
      productPrice: json['productPrice'],
      productLocation: json['productLocation'],
      productImage: json['productImage'],
    );
  }

  DashboardEntity toEntity() => DashboardEntity(
      productId: productId,
      productName: productName,
      productDescription: productDescription,
      productCategory: productCategory,
      productPrice: productPrice,
      productLocation: productLocation,
      productImage: productImage);

  DashboardModel.empty()
      : productId = '',
        productName = '',
        productDescription = '',
        productCategory = '',
        productPrice = 0,
        productLocation = '',
        productImage = '';
}
