import 'package:farm_fresh_shop_app/helpers/styles/app_color.dart';
import 'package:farm_fresh_shop_app/helpers/styles/app_images.dart';
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
    required this.cubit,
  });
  final BottomBarItem item;
  final int index;
  final BottomBarCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarCubit, BottomBarState>(
        bloc: cubit,
        builder: (context, state) {
          bool isSelected = state.currentIndex == index;
          return InkWell(
              onTap: () => cubit.updateIndex(index),
              child: (index == 1 && isSelected)
                  ? Image.asset(
                      AppImages.bookmark2,
                    )
                  : Image.asset(
                      item.image,
                      color: isSelected ? AppColor.primary : Colors.grey,
                    ));
        });
  }
}
