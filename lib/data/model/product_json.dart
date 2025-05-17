import 'dart:math';
import 'package:farm_fresh_shop_app/helpers/styles/app_images.dart';

class ProductModel {
  final int? id;
  final String? name;
  final String? image;
  final String? description;
  final double? price;
  final int quantity;

  ProductModel({
    this.id,
    this.name,
    this.quantity = 1,
    this.image,
    this.description,
    this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        image: [
          AppImages.book1,
          AppImages.book2,
          AppImages.book3,
          AppImages.book4,
          AppImages.book5,
        ][Random().nextInt(5)],
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
