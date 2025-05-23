import 'package:dartz/dartz.dart';
import 'package:farm_fresh_shop_app/data/model/product_json.dart';
import 'package:farm_fresh_shop_app/helpers/utils.dart';
import '../../initializer.dart';

class FarmFreshAppData {
  Future<Either<String, List<ProductModel>>> getProducts(
      {String? search}) async {
    final response = await networkRepository
        .get(url: "/products", extraQuery: {"search": search});
    if (!response.failed) {
      final products = parseList(response.data, ProductModel.fromJson);
      return right(products);
    }

    return left(response.message);
  }

  Future<Either<String, List<String>>> getStates() async {
    final response = await networkRepository.get(url: "/delivery/states");
    if (!response.failed) {
      final states = (response.data as List<dynamic>)
          .map((state) => state.toString())
          .toList();
      return right(states);
    }

    return left(response.message);
  }

  Future<Either<String, List<String>>> getAirPorts() async {
    final response = await networkRepository.get(url: "/delivery/airports");
    if (!response.failed) {
      final airPorts = (response.data as List<dynamic>)
          .map((airPort) => airPort["name"].toString())
          .toList();
      return right(airPorts);
    }

    return left(response.message);
  }

  Future<Either<String, (bool, String)>> validateZipCode({
    required String state,
    required String zipCode,
  }) async {
    final response = await networkRepository.get(
        url: "/delivery/validate-zipcode",
        extraQuery: {"state": state, "zipcode": zipCode});
    if (!response.failed) {
      final value = response.data["valid"] as bool;
      final message = response.data["message"] as String;
      return right((value, message));
    }

    return left(response.message);
  }

  Future<Either<String, double>> getProductPriceCalculation({
    required String deliveryType,
    required String mangoType,
    required String quantity,
    String? state,
  }) async {
    final response = await networkRepository
        .get(url: "/delivery/calculate-price", extraQuery: {
      "delivery_type": deliveryType,
      "mango_type": mangoType,
      "quantity": quantity,
      if (deliveryType == "doorstep") "state": state
    });
    if (!response.failed) {
      final price = (response.data["price"] as double);
      return right(price);
    }

    return left(response.message);
  }
}
