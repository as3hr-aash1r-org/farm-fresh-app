import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/service_locator.dart';
import '../../../helpers/widgets/shadow_mask.dart';
import '../home_cubit.dart';
import '../home_state.dart';
import 'book_card.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  static final homeCubit = sl<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Text(
              'New Arrivals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (state.isSearchActive)
              Expanded(
                child: state.filteredBooks.isEmpty
                    ? const Center(child: Text("No books found"))
                    : ScrollShaderMask(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: state.filteredBooks.length,
                          itemBuilder: (context, index) {
                            return BookCard(book: state.filteredBooks[index]);
                          },
                        ),
                      ),
              ),
            if (!state.isSearchActive)
              Expanded(
                child: ScrollShaderMask(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: state.books.length,
                    itemBuilder: (context, index) {
                      return BookCard(
                        book: state.books[index],
                      );
                    },
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
