import 'package:finalproject/features/dashboard/domain/entity/dashboard_entity.dart';
class ServiceTestData {
  List<DashboardEntity> lstServices = [
    const DashboardEntity(
        serviceId: "667f9f01ff88e8309bb58ed8",
        serviceTitle: "cleaner",
        servicePrice: 123,
        serviceDescription: "cleaning",
        serviceCategory: "HomeService",
        serviceLocation: "kathmandu",
        serviceImage: "1719639809942-IMG_20240201_083523_655.jpg"),
    const DashboardEntity(
        serviceId: "66800b51ed3f651cc1b02fa6",
        serviceTitle: "upKeep",
        servicePrice: 123,
        serviceDescription: "Servicing",
        serviceCategory: "HomeService",
        serviceLocation: "kathmandu",
        serviceImage: "1719667537207-upkeep.jpeg"),
    const DashboardEntity(
        serviceId: "66800c0aed3f651cc1b02fac",
        serviceTitle: "caretaker",
        servicePrice: 123,
        serviceDescription: "Care taker of pet animals",
        serviceCategory: "Pet",
        serviceLocation: "kathmandu",
        serviceImage: "1719667722721-pet.jpeg"),
    const DashboardEntity(
        serviceId: "66800c4fed3f651cc1b02fae",
        serviceTitle: "energy",
        servicePrice: 123,
        serviceDescription: "Energy saving mentor",
        serviceCategory: "Trainer",
        serviceLocation: "kathmandu",
        serviceImage: "1719667791539-energy.jpeg"),
    const DashboardEntity(
        serviceId: "66800c82ed3f651cc1b02fb0",
        serviceTitle: "moving",
        servicePrice: 987,
        serviceDescription: "Moving the anything",
        serviceCategory: "handler",
        serviceLocation: "kathmandu",
        serviceImage: "1719667842816-moving.jpeg"),
  ];
}
