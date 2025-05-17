import '../../domain/entities/book_entity.dart';

class HomeState {
  final bool isLoading;
  final List<BookEntity> books;
  final List<BookEntity> filteredBooks;
  final bool isSearchActive;

  HomeState({
    this.isLoading = true,
    this.isSearchActive = false,
    required this.books,
    required this.filteredBooks,
  });

  factory HomeState.empty() => HomeState(books: [], filteredBooks: []);

  HomeState copyWith(
      {bool? isLoading,
      bool? isSearchActive,
      List<BookEntity>? books,
      List<BookEntity>? filteredBooks}) {
    return HomeState(
      books: books ?? this.books,
      isSearchActive: isSearchActive ?? this.isSearchActive,
      filteredBooks: filteredBooks ?? this.filteredBooks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
