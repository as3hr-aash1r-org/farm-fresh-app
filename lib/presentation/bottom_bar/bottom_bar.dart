import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/service_locator.dart';
import '../../helpers/utils.dart';
import 'bottom_bar_container.dart';
import 'bottom_bar_cubit.dart';
import 'bottom_bar_state.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, required this.cubit});
  final BottomBarCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarCubit, BottomBarState>(
        bloc: cubit,
        builder: (context, state) {
          return PopScope(
            canPop: state.canPop,
            onPopInvokedWithResult: (didPop, _) async {
              if (didPop) return;
              if (state.currentIndex != 0) {
                return cubit.updateIndex(state.currentIndex - 1);
              } else {
                if (await showConfirmationDialog(
                        'Do you want to exit the app?') &&
                    context.mounted) {
                  cubit.exitApp();
                }
              }
            },
            child: Scaffold(
              body: Stack(
                children: [
                  state.page,
                  if (MediaQuery.of(context).viewInsets.bottom <= 100)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: BottomBarContainer(cubit: sl()),
                    )
                ],
              ),
            ),
          );
        });
  }
}
