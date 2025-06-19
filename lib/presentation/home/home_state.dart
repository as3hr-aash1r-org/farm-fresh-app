import 'package:farm_fresh_shop_app/data/model/product_json.dart';
import 'package:farm_fresh_shop_app/data/model/user_model.dart';

enum DeliveryType { none, pickup, doorstep }

class HomeState {
  final bool isLoading;
  final bool isSearching;
  final List<ProductModel> products;
  final UserModel user;
  final DeliveryType selectedDeliveryType;
  final String? selectedState;
  final String? zipCode;
  final bool isVerifyingZip;
  final bool isFetchingAirports;
  final List<String> states;
  final List<String> airports;
  final String? selectedAirport;

  HomeState({
    this.airports = const [],
    this.selectedAirport,
    this.isSearching = false,
    this.isLoading = true,
    required this.user,
    this.isVerifyingZip = false,
    this.isFetchingAirports = false,
    required this.products,
    this.selectedDeliveryType = DeliveryType.pickup,
    this.selectedState,
    this.zipCode,
    this.states = const [],
  });

  factory HomeState.empty() => HomeState(products: [], user: UserModel());

  HomeState copyWith({
    bool? isLoading,
    bool? isSearching,
    List<ProductModel>? products,
    UserModel? user,
    DeliveryType? selectedDeliveryType,
    String? selectedState,
    String? zipCode,
    bool? isVerifyingZip,
    bool? isFetchingAirports,
    List<String>? states,
    List<String>? airports,
    String? selectedAirport,
  }) {
    return HomeState(
      isSearching: isSearching ?? this.isSearching,
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      user: user ?? this.user,
      selectedDeliveryType: selectedDeliveryType ?? this.selectedDeliveryType,
      selectedState: selectedState ?? this.selectedState,
      zipCode: zipCode ?? this.zipCode,
      isVerifyingZip: isVerifyingZip ?? this.isVerifyingZip,
      states: states ?? this.states,
      airports: airports ?? this.airports,
      selectedAirport: selectedAirport ?? this.selectedAirport,
      isFetchingAirports: isFetchingAirports ?? this.isFetchingAirports,
    );
  }
}
