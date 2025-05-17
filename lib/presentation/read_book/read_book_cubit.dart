import 'package:bloc/bloc.dart';
import 'package:farm_fresh_shop_app/domain/entities/book_entity.dart';

import 'read_book_navigator.dart';
import 'read_book_state.dart';

class ReadBookCubit extends Cubit<ReadBookState> {
  final BookEntity params;
  final ReadBookNavigator navigator;
  ReadBookCubit(this.params, this.navigator) : super(ReadBookState.empty()) {
    setReadBook();
  }

  void setReadBook() {
    emit(state.copyWith(book: params));
  }

  void changeFontSize(double value) {
    final clampedValue = value.clamp(10.0, 40.0);
    emit(state.copyWith(fontSize: clampedValue));
  }
}
