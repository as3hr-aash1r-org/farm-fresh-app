import 'dart:developer';

import 'package:farm_fresh_shop_app/initializer.dart';
import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(BottomBarState.empty());

  void updateIndex(int index) {
    emit(state.copyWith(currentIndex: index, page: state.items[index].page));
  }

  void exitApp() {
    emit(state.copyWith(canPop: true));
    AppNavigation.exitApp();
  }

  @override
  Future<void> close() async {
    log("DISPOSING INITIALIZER");
    await Initializer.dispose();
    return super.close();
  }
}
