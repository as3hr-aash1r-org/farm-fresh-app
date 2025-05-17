import 'components/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../home/home_screen.dart';

class BottomBarState {
  List<BottomBarItem> items;
  bool canPop;
  Widget page;
  int currentIndex;
  BottomBarState({
    this.canPop = false,
    required this.page,
    this.currentIndex = 0,
    required this.items,
  });

  factory BottomBarState.empty() => BottomBarState(
        items: BottomBarItem.appItems,
        currentIndex: 0,
        page: const HomeScreen(),
      );

  BottomBarState copyWith({
    Widget? page,
    int? currentIndex = 0,
    List<BottomBarItem>? items,
    bool? canPop,
  }) {
    return BottomBarState(
      page: page ?? this.page,
      canPop: canPop ?? this.canPop,
      items: items ?? this.items,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
