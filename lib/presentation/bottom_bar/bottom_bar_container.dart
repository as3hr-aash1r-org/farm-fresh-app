import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'bottom_bar_cubit.dart';
import 'bottom_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/bottom_bar_icon.dart';

class BottomBarContainer extends StatelessWidget {
  const BottomBarContainer({super.key, required this.cubit});

  final BottomBarCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 5)
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: BlocBuilder<BottomBarCubit, BottomBarState>(
          bloc: cubit,
          builder: (context, bottomBarState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: bottomBarState.items.mapIndexed((index, item) {
                return BottomBarIcon(
                  item: item,
                  cubit: cubit,
                  index: index,
                );
              }).toList(),
            );
          }),
    );
  }
}
