import 'package:farm_fresh_shop_app/helpers/styles/app_color.dart';
import 'bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bottom_bar_cubit.dart';
import '../bottom_bar_state.dart';

class BottomBarIcon extends StatelessWidget {
  const BottomBarIcon({
    super.key,
    required this.item,
    required this.index,
  });
  final BottomBarItem item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarCubit, BottomBarState>(
        builder: (context, state) {
      final cubit = context.read<BottomBarCubit>();
      bool isSelected = state.currentIndex == index;
      return InkWell(
          onTap: () => cubit.updateIndex(index),
          child: Image.asset(
            item.image,
            height: 25,
            color: isSelected ? AppColor.primary : Colors.grey,
          ));
    });
  }
}
