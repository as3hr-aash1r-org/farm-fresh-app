import 'package:dartz/dartz.dart';
import 'package:farm_fresh_shop_app/data/model/product_json.dart';
import 'package:farm_fresh_shop_app/helpers/utils.dart';
import '../../di/initializer.dart';

class ProductRepository {
  Future<Either<String, List<ProductModel>>> getProducts(
      {String? search}) async {
    final response = await networkRepository
        .get(url: "/products", extraQuery: {"search": search});
    if (!response.failed) {
      final books = parseList(response.data, ProductModel.fromJson);
      return right(books);
    }

    return left(response.message);
  }
}
