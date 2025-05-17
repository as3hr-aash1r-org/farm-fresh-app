import 'package:farm_fresh_shop_app/data/model/product_json.dart';
import 'package:farm_fresh_shop_app/data/model/user_model.dart';

class HomeState {
  final bool isLoading;
  final List<ProductModel> books;
  final UserModel user;

  HomeState({
    this.isLoading = true,
    required this.user,
    required this.books,
  });

  factory HomeState.empty() => HomeState(books: [], user: UserModel());

  HomeState copyWith(
      {bool? isLoading, List<ProductModel>? books, UserModel? user}) {
    return HomeState(
        books: books ?? this.books,
        isLoading: isLoading ?? this.isLoading,
        user: user ?? this.user);
  }
}
