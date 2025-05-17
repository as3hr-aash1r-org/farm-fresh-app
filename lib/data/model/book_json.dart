import 'dart:math';

import 'package:farm_fresh_shop_app/domain/entities/book_entity.dart';
import 'package:farm_fresh_shop_app/helpers/styles/app_images.dart';

class BookJson {
  final String? title;
  final String? author;
  final String? image;
  final String? aboutAuthor;
  final String? overview;
  final String? bookText;
  final double? price;

  BookJson({
    this.title,
    this.author,
    this.image,
    this.aboutAuthor,
    this.overview,
    this.bookText,
    this.price,
  });

  factory BookJson.fromJson(Map<String, dynamic> json) => BookJson(
        title: json["title"],
        author: json["author"],
        image: [
          AppImages.book1,
          AppImages.book2,
          AppImages.book3,
          AppImages.book4,
          AppImages.book5,
        ][Random().nextInt(5)],
        aboutAuthor: json["about_author"],
        overview: json["overview"],
        bookText: json["book_text"],
        price: json["price"]?.toDouble(),
      );

  BookEntity toDomain() => BookEntity(
        title: title,
        author: author,
        image: image,
        aboutAuthor: aboutAuthor,
        overview: overview,
        bookText: bookText,
        price: price,
      );
}
