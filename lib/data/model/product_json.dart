import 'dart:math';
import 'package:farm_fresh_shop_app/helpers/styles/app_images.dart';

class ProductModel {
  final int? id;
  final String? name;
  final String? image;
  final String? description;
  final double? price;
  final int? inStock;
  final int quantity;

  ProductModel({
    this.id,
    this.name,
    this.inStock,
    this.quantity = 1,
    this.image,
    this.description,
    this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["type"],
        inStock: json["stock"],
        image: [
          AppImages.mango1,
          AppImages.mango2,
          AppImages.mango7,
          AppImages.mango4,
          AppImages.mango5,
          AppImages.mango6,
          AppImages.mango7,
          AppImages.mango8,
          AppImages.mango9,
          AppImages.mango10
        ][Random().nextInt(10)],
        description: json["description"],
        price: json["price"]?.toDouble(),
      );

  copyWith(
          {String? title,
          String? image,
          String? overview,
          String? bookText,
          double? price,
          int? quantity}) =>
      ProductModel(
        id: id,
        quantity: quantity ?? this.quantity,
        name: title ?? name,
        image: image ?? this.image,
        description: overview ?? description,
        price: price ?? this.price,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "inStock": inStock,
        "quantity": quantity,
      };
}
