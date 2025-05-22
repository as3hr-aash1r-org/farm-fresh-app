import 'package:provider/single_child_widget.dart';
import 'package:farm_fresh_shop_app/presentation/cart/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/local_storage/local_storage_repository.dart';
import 'network/network_repository.dart';

final networkRepository = NetworkRepository();
final localStorageRepository = LocalStorageRepository();

class Initializer {
  static final List<SingleChildWidget> blocProviders = [
    BlocProvider(create: (context) => CartCubit()),
  ];
}
