import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helpers/styles/app_color.dart';
import '../../../initializer.dart';
import '../home_cubit.dart';
import '../home_state.dart';

class DeliveryTypeDialog extends StatefulWidget {
  const DeliveryTypeDialog({super.key});

  @override
  State<DeliveryTypeDialog> createState() => _DeliveryTypeDialogState();
}

class _DeliveryTypeDialogState extends State<DeliveryTypeDialog> {
  DeliveryType? _tempSelectedType;
  String? _selectedAirport;

  @override
  void initState() {
    super.initState();
    _tempSelectedType = sl<HomeCubit>().state.selectedDeliveryType;
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = sl<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      builder: (context, state) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          title: const Text(
            "Select Delivery Type",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.primary,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<DeliveryType>(
                value: DeliveryType.pickup,
                groupValue: _tempSelectedType,
                activeColor: AppColor.primary,
                title: const Text("Pickup"),
                onChanged: (val) {
                  setState(() {
                    _tempSelectedType = val;
                    _selectedAirport = null;
                    homeCubit.fetchAirports();
                  });
                },
              ),
              RadioListTile<DeliveryType>(
                value: DeliveryType.doorstep,
                groupValue: _tempSelectedType,
                activeColor: AppColor.primary,
                title: const Text("Doorstep"),
                onChanged: (val) {
                  setState(() {
                    _tempSelectedType = val;
                  });
                  homeCubit.fetchStates();
                },
              ),

              // Doorstep flow
              if (_tempSelectedType == DeliveryType.doorstep) ...[
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: state.selectedState,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: "Select State",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.states
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => homeCubit.updateSelectedState(val!),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Zip Code",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: homeCubit.updateZipCode,
                ),
              ],

              // Pickup flow
              if (_tempSelectedType == DeliveryType.pickup) ...[
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedAirport,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: "Select Airport",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.airports
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedAirport = val!;
                    });
                  },
                ),
              ],

              if (state.isVerifyingZip) ...[
                const SizedBox(height: 16),
                const CircularProgressIndicator(color: AppColor.primary),
              ]
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              color: AppColor.pink,
              onPressed: () => Navigator.pop(context),
            ),
            IconButton(
              icon: const Icon(Icons.done),
              color: AppColor.green,
              onPressed: () {
                if (_tempSelectedType == DeliveryType.doorstep) {
                  homeCubit.verifyAndSetDoorstep(context);
                } else if (_tempSelectedType == DeliveryType.pickup) {
                  if (_selectedAirport != null) {
                    homeCubit.setPickup(_selectedAirport!);
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
