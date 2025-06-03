import 'package:farm_fresh_shop_app/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../initializer.dart';
import '../home_cubit.dart';
import '../home_state.dart';
import 'product_card.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: sl<HomeCubit>(),
      builder: (context, state) {
        final isLoading = state.isLoading && !state.isSearching;
        final products = state.products;
        final isEmpty = !isLoading && products.isEmpty;

        return RefreshIndicator(
          color: Colors.white,
          backgroundColor: getRandomMangoColor,
          onRefresh: () => sl<HomeCubit>().fetchData(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              if (isLoading)
                Center(
                    child:
                        CircularProgressIndicator(color: getRandomMangoColor))
              else if (isEmpty)
                Center(child: Text("No Products Found!"))
              else
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(bottom: 60),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: state.products[index]);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
