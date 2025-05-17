import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:farm_fresh_shop_app/data/model/user_model.dart';
import 'package:farm_fresh_shop_app/di/initializer.dart';
import 'package:farm_fresh_shop_app/helpers/debouncer.dart';
import 'package:farm_fresh_shop_app/helpers/utils.dart';
import 'package:farm_fresh_shop_app/presentation/home/home_state.dart';

import '../../data/product/product_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final bookRepository = ProductRepository();
  final debouncer = Debouncer(delay: Duration(milliseconds: 500));
  HomeCubit() : super(HomeState.empty()) {
    initHome();
    fetchBooks();
  }

  void initHome() async {
    final user = await localStorageRepository.getValue("user");
    user.fold((l) => null,
        (r) => emit(state.copyWith(user: UserModel.fromJson(jsonDecode(r)))));
  }

  Future<void> fetchBooks({String? search}) async {
    emit(state.copyWith(isLoading: true));
    bookRepository
        .getProducts(search: search)
        .then((response) => response.fold((error) => showToast(error), (books) {
              emit(state.copyWith(isLoading: false, books: books));
            }));
  }

  void searchBooks(String query) {
    if (query.isEmpty) {
      return;
    }

    debouncer.call(() => fetchBooks(search: query));
  }
}
