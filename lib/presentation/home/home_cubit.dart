import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:farm_fresh_shop_app/data/model/user_model.dart';
import 'package:farm_fresh_shop_app/initializer.dart';
import 'package:farm_fresh_shop_app/helpers/debouncer.dart';
import 'package:farm_fresh_shop_app/helpers/utils.dart';
import 'package:farm_fresh_shop_app/presentation/home/home_state.dart';
import 'package:flutter/material.dart';

import '../../data/app_data/app_data.dart';

class HomeCubit extends Cubit<HomeState> {
  final appData = FarmFreshAppData();
  final debouncer = Debouncer(delay: Duration(milliseconds: 500));

  HomeCubit() : super(HomeState.empty()) {
    initHome();
    fetchData();
    fetchStates();
    fetchAirports();
  }

  void initHome() async {
    final user = await localStorageRepository.getValue("user");
    user.fold((l) => null,
        (r) => emit(state.copyWith(user: UserModel.fromJson(jsonDecode(r)))));
  }

  Future<void> fetchData({String? search}) async {
    emit(state.copyWith(isLoading: true));
    appData.getProducts(search: search).then(
        (response) => response.fold((error) => showToast(error), (products) {
              emit(state.copyWith(isLoading: false, products: products));
            }));
  }

  void fetchStates() {
    appData.getStates().then((states) => states.fold(
          (l) => showToast(l),
          (statesList) => emit(state.copyWith(states: statesList)),
        ));
  }

  void fetchAirports() async {
    emit(state.copyWith(isFetchingAirports: true));
    final result = await appData.getAirPorts();
    result.fold(
      (err) => emit(state.copyWith(isFetchingAirports: false)),
      (airports) =>
          emit(state.copyWith(isFetchingAirports: false, airports: airports)),
    );
  }

  void setPickup(String airport) {
    emit(state.copyWith(
      selectedDeliveryType: DeliveryType.pickup,
      selectedAirport: airport,
    ));
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      return;
    }

    debouncer.call(() => fetchData(search: query));
  }

  void setDeliveryType(DeliveryType type) async {
    if (type == DeliveryType.doorstep && state.states.isEmpty) {
      final result = await appData.getStates();
      result.fold(
        (l) => showToast(l),
        (statesList) => emit(state.copyWith(states: statesList)),
      );
    }
    emit(state.copyWith(selectedDeliveryType: type));
  }

  void updateSelectedState(String selectedState) {
    emit(state.copyWith(selectedState: selectedState));
  }

  void updateZipCode(String zipCode) {
    emit(state.copyWith(zipCode: zipCode));
  }

  void verifyAndSetDoorstep(BuildContext context) async {
    if ((state.selectedState?.isEmpty ?? false) ||
        (state.zipCode?.isEmpty ?? false)) {
      showToast("Please select state and enter zip code.");
      return;
    }

    emit(state.copyWith(isVerifyingZip: true));

    final result = await appData.validateZipCode(
      state: state.selectedState!,
      zipCode: state.zipCode!,
    );

    emit(state.copyWith(isVerifyingZip: false));

    result.fold(
      (error) => showToast(error),
      (res) {
        final (isValid, message) = res;
        if (isValid) {
          setDeliveryType(DeliveryType.doorstep);
          Navigator.pop(context);
        } else {
          showToast(
            message,
          );
        }
      },
    );
  }
}
