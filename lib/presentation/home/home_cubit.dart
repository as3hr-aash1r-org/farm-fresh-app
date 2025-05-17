import 'package:bloc/bloc.dart';
import 'package:farm_fresh_shop_app/domain/repositories/book_repository.dart';
import 'package:farm_fresh_shop_app/helpers/utils.dart';
import 'package:farm_fresh_shop_app/presentation/home/home_navigator.dart';
import 'package:farm_fresh_shop_app/presentation/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNavigator navigator;
  final BookRepository bookRepository;
  HomeCubit(this.bookRepository, this.navigator) : super(HomeState.empty());

  Future<void> fetchBooks() async {
    emit(state.copyWith(isLoading: true));
    bookRepository.getBooks().then(
        (response) => response.fold((error) => showToast(error.error), (books) {
              emit(state.copyWith(isLoading: false, books: books));
            }));
  }

  void searchBooks(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(filteredBooks: state.books, isSearchActive: false));
      return;
    }

    final filtered = state.books
        .where((book) =>
            book.title?.toLowerCase().contains(query.toLowerCase()) == true ||
            book.author?.toLowerCase().contains(query.toLowerCase()) == true)
        .toList();

    emit(state.copyWith(filteredBooks: filtered, isSearchActive: true));
  }
}
