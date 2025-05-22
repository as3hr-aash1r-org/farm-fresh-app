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
        name: json["name"],
        inStock: json["stock"],
        image: [
          AppImages.mango1,
          AppImages.mango2,
          AppImages.mango3,
          AppImages.mango4,
          AppImages.mango5,
          AppImages.mango6,
        ][Random().nextInt(6)],
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
        quantity: quantity ?? this.quantity,
        name: title ?? name,
        image: image ?? this.image,
        description: overview ?? description,
        price: price ?? this.price,
      );
}
