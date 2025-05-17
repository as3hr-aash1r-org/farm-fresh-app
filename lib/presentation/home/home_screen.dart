import 'package:farm_fresh_shop_app/presentation/home/components/home_screen_body.dart';
import 'package:farm_fresh_shop_app/presentation/home/components/home_screen_header.dart';
import 'package:farm_fresh_shop_app/presentation/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/service_locator.dart';
import '../cart/cart_cubit.dart';
import 'home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final homeCubit = sl<HomeCubit>();
  static final cartCubit = sl<CartCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        builder: (context, state) {
          return const Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 16, 5, 0),
                child: Column(
                  children: [
                    HomeScreenHeader(),
                    Expanded(child: HomeScreenBody()),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
