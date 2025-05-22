import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helpers/widgets/shadow_mask.dart';
import '../home_cubit.dart';
import '../home_state.dart';
import 'product_card.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: ScrollShaderMask(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(book: state.products[index]);
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
