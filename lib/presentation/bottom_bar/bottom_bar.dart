import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/utils.dart';
import 'bottom_bar_container.dart';
import 'bottom_bar_cubit.dart';
import 'bottom_bar_state.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomBarCubit()),
      ],
      child: BlocBuilder<BottomBarCubit, BottomBarState>(
          builder: (context, state) {
        final cubit = context.read<BottomBarCubit>();
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
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: BottomBarContainer(),
              body: SafeArea(child: state.page)),
        );
      }),
    );
  }
}
