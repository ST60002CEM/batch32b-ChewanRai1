import 'package:finalproject/features/dashboard/domain/entity/dashboard_entity.dart';

class ProductTestData {
  List<DashboardEntity> lstProducts = [
    const DashboardEntity(
        productId: "667f9f01ff88e8309bb58ed8",
        productName: "cleaner",
        productPrice: 123,
        productDescription: "cleaning",
        productCategory: "HomeService",
        productLocation: "kathmandu",
        productImage: "1719639809942-IMG_20240201_083523_655.jpg"),
    const DashboardEntity(
        productId: "66800b51ed3f651cc1b02fa6",
        productName: "upKeep",
        productPrice: 123,
        productDescription: "Servicing",
        productCategory: "HomeService",
        productLocation: "kathmandu",
        productImage: "1719667537207-upkeep.jpeg"),
    const DashboardEntity(
        productId: "66800c0aed3f651cc1b02fac",
        productName: "caretaker",
        productPrice: 123,
        productDescription: "Care taker of pet animals",
        productCategory: "Pet",
        productLocation: "kathmandu",
        productImage: "1719667722721-pet.jpeg"),
    const DashboardEntity(
        productId: "66800c4fed3f651cc1b02fae",
        productName: "energy",
        productPrice: 123,
        productDescription: "Energy saving mentor",
        productCategory: "Trainer",
        productLocation: "kathmandu",
        productImage: "1719667791539-energy.jpeg"),
    const DashboardEntity(
        productId: "66800c82ed3f651cc1b02fb0",
        productName: "moving",
        productPrice: 987,
        productDescription: "Moving the anything",
        productCategory: "handler",
        productLocation: "kathmandu",
        productImage: "1719667842816-moving.jpeg"),
  ];
}
