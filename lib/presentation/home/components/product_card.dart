import 'package:farm_fresh_shop_app/data/model/product_json.dart';
import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:farm_fresh_shop_app/navigation/route_name.dart';
import 'package:flutter/material.dart';
import '../../../helpers/styles/app_images.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book});
  final ProductModel book;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppNavigation.push(RouteName.bookDetails, arguments: {'book': book});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(book.image ?? AppImages.book1),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book.name ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              book.description ?? "",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
