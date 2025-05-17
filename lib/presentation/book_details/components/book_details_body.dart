import 'package:farm_fresh_shop_app/presentation/book_details/book_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../helpers/styles/app_color.dart';
import '../../../helpers/styles/app_images.dart';
import '../book_details_state.dart';

class BookDetailsBody extends StatelessWidget {
  const BookDetailsBody({
    super.key,
    required this.cubit,
  });
  final BookDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      bloc: cubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.book.title ?? "",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                state.book.author ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'About the author',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.book.aboutAuthor ?? '',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.book.overview ?? '',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.navigator.navigateToReadBook(state.book);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColor.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.readBook,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          const Text('Read Preview'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.onAddToCartTap();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                          'Buy for \$${state.book.price?.toStringAsFixed(2) ?? "14.95"}'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
