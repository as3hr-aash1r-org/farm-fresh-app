import 'package:farm_fresh_shop_app/initializer.dart';
import 'package:farm_fresh_shop_app/presentation/home/home_cubit.dart';
import 'package:farm_fresh_shop_app/presentation/order/order_cubit.dart';
import 'package:farm_fresh_shop_app/presentation/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/utils.dart';
import 'bottom_bar_container.dart';
import 'bottom_bar_cubit.dart';
import 'bottom_bar_state.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await sl<HomeCubit>()
      ..getAllData();
    sl<ProfileCubit>().getProfile();
    sl<OrderCubit>().fetchOrders();
  }

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
              appBar: AppBar(
                toolbarHeight: 0,
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarColor: Colors.white),
              ),
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                  child: Stack(
                children: [
                  state.page,
                  if (MediaQuery.of(context).viewInsets.bottom == 0)
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: BottomBarContainer()),
                ],
              ))),
        );
      }),
    );
  }
}
