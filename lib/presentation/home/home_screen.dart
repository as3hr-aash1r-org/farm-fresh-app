import 'package:farm_fresh_shop_app/presentation/home/components/home_screen_body.dart';
import 'package:farm_fresh_shop_app/presentation/home/components/home_screen_header.dart';
import 'package:farm_fresh_shop_app/presentation/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Padding(
        padding: EdgeInsets.fromLTRB(5, 16, 5, 0),
        child: Column(
          children: [
            HomeScreenHeader(),
            Expanded(child: HomeScreenBody()),
          ],
        ),
      );
    });
  }
}
