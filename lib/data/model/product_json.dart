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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final type = json["type"].toString().toLowerCase();
    final image = type == "chaunsa"
        ? AppImages.chaunsa
        : type == "langra"
            ? AppImages.langra
            : type == "sindhri"
                ? AppImages.sindhri
                : type == "ratol"
                    ? AppImages.ratol
                    : AppImages.chaunsa;
    return ProductModel(
      id: json["id"],
      name: json["type"],
      inStock: json["stock"],
      image: image,
      description: json["description"],
      price: json["price"]?.toDouble(),
    );
  }

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
