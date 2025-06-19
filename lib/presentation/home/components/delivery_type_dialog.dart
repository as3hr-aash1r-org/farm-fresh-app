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

class _DeliveryTypeDialogState extends State<DeliveryTypeDialog>
    with TickerProviderStateMixin {
  DeliveryType? _tempSelectedType;
  String? _selectedAirport;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _tempSelectedType = sl<HomeCubit>().state.selectedDeliveryType;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = sl<HomeCubit>();

    return ScaleTransition(
      scale: _scaleAnimation,
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        builder: (context, state) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 16,
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Color(0xFFFFFDF5),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.primary.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header with mango icon
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColor.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.local_shipping_rounded,
                          color: AppColor.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "🥭 Select Airport Location",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColor.green,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Choose how you'd like to receive your fresh mangos",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      // Delivery options
                      _buildDeliveryOption(
                        DeliveryType.pickup,
                        "🚗 Pickup",
                        "Collect from airport location",
                        Icons.flight_land_rounded,
                        homeCubit,
                      ),
                      const SizedBox(height: 12),
                      // _buildDeliveryOption(
                      //   DeliveryType.doorstep,
                      //   "🏠 Doorstep",
                      //   "Delivered to your home",
                      //   Icons.home_rounded,
                      //   homeCubit,
                      // ),

                      // Conditional fields with animation
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: _tempSelectedType == null ? 0 : null,
                        child: Column(
                          children: [
                            // Doorstep flow
                            // if (_tempSelectedType == DeliveryType.doorstep) ...[
                            //   const SizedBox(height: 24),
                            //   _buildEnhancedDropdown(
                            //     value: state.selectedState,
                            //     items: state.states,
                            //     labelText: "Select State",
                            //     hintText: "Choose your state",
                            //     icon: Icons.location_on_rounded,
                            //     onChanged: (val) =>
                            //         homeCubit.updateSelectedState(val!),
                            //   ),
                            //   const SizedBox(height: 16),
                            //   _buildEnhancedTextField(
                            //     hintText: "Enter Zip Code",
                            //     icon: Icons.pin_drop_rounded,
                            //     keyboardType: TextInputType.number,
                            //     onChanged: homeCubit.updateZipCode,
                            //   ),
                            // ],

                            // Pickup flow
                            if (_tempSelectedType == DeliveryType.pickup) ...[
                              const SizedBox(height: 24),
                              _buildEnhancedDropdown(
                                value: _selectedAirport,
                                items: state.airports,
                                labelText: "Select Airport",
                                hintText: "Choose pickup location",
                                icon: Icons.flight_rounded,
                                onChanged: (val) {
                                  setState(() {
                                    _selectedAirport = val!;
                                  });
                                },
                              ),
                            ],
                          ],
                        ),
                      ),

                      if (state.isVerifyingZip) ...[
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColor.lightYellow.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppColor.orange,
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                "Verifying location...",
                                style: TextStyle(
                                  color: AppColor.orange,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: AppColor.pink.withOpacity(0.3)),
                              ),
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: AppColor.pink,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: const LinearGradient(
                                  colors: [AppColor.primary, AppColor.green],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.primary.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed:
                                    _canConfirm() ? _handleConfirm : null,
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  "Confirm",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDeliveryOption(
    DeliveryType type,
    String title,
    String subtitle,
    IconData icon,
    HomeCubit homeCubit,
  ) {
    final isSelected = _tempSelectedType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          _tempSelectedType = type;
          _selectedAirport = null;
        });
        if (type == DeliveryType.pickup) {
          homeCubit.fetchAirports();
        } else {
          homeCubit.fetchStates();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected ? AppColor.primary.withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColor.primary : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.primary : Colors.grey[400],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColor.green : Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedScale(
              scale: isSelected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColor.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedDropdown({
    required String? value,
    required List<String> items,
    required String labelText,
    required String hintText,
    required IconData icon,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.primary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(icon, color: AppColor.primary),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColor.primary.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColor.primary, width: 2),
          ),
          labelStyle: const TextStyle(color: AppColor.green),
        ),
        dropdownColor: Colors.white,
        style: const TextStyle(color: Colors.black87),
        items: items
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  // Widget _buildEnhancedTextField({
  //   required String hintText,
  //   required IconData icon,
  //   required TextInputType keyboardType,
  //   required Function(String) onChanged,
  // }) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(16),
  //       boxShadow: [
  //         BoxShadow(
  //           color: AppColor.primary.withOpacity(0.1),
  //           blurRadius: 8,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: TextField(
  //       decoration: InputDecoration(
  //         hintText: hintText,
  //         prefixIcon: Icon(icon, color: AppColor.primary),
  //         filled: true,
  //         fillColor: Colors.white,
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(16),
  //           borderSide: BorderSide.none,
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(16),
  //           borderSide: BorderSide(color: Colors.grey[300]!),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(16),
  //           borderSide: const BorderSide(color: AppColor.primary, width: 2),
  //         ),
  //         hintStyle: TextStyle(color: Colors.grey[500]),
  //       ),
  //       keyboardType: keyboardType,
  //       onChanged: onChanged,
  //     ),
  //   );
  // }

  bool _canConfirm() {
    if (_tempSelectedType == DeliveryType.doorstep) {
      return true; // Let the cubit handle validation
    } else if (_tempSelectedType == DeliveryType.pickup) {
      return _selectedAirport != null;
    }
    return false;
  }

  void _handleConfirm() {
    final homeCubit = sl<HomeCubit>();
    if (_tempSelectedType == DeliveryType.doorstep) {
      homeCubit.verifyAndSetDoorstep(context);
    } else if (_tempSelectedType == DeliveryType.pickup) {
      if (_selectedAirport != null) {
        homeCubit.setPickup(_selectedAirport!);
        Navigator.pop(context);
      }
    }
  }
}
