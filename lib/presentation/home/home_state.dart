import 'package:farm_fresh_shop_app/data/model/product_json.dart';
import 'package:farm_fresh_shop_app/data/model/user_model.dart';

class HomeState {
  final bool isLoading;
  final List<ProductModel> products;
  final UserModel user;

  HomeState({
    this.isLoading = true,
    required this.user,
    required this.products,
  });

  factory HomeState.empty() => HomeState(products: [], user: UserModel());

  HomeState copyWith(
      {bool? isLoading, List<ProductModel>? products, UserModel? user}) {
    return HomeState(
        products: products ?? this.products,
        isLoading: isLoading ?? this.isLoading,
        user: user ?? this.user);
  }
}
