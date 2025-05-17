import 'package:farm_fresh_shop_app/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';

import '../../../di/service_locator.dart';
import '../../../helpers/styles/app_images.dart';
import '../home_cubit.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book});
  final BookEntity book;

  static final homeCubit = sl<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        homeCubit.navigator.navigateToBookDetail(book);
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
              book.title ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              book.author ?? "",
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
