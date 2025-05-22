import 'package:farm_fresh_shop_app/helpers/styles/app_images.dart';
import 'package:farm_fresh_shop_app/helpers/widgets/farm_fresh_asset.dart';
import 'package:flutter/material.dart';

import '../styles/app_color.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.prefilledValue,
    this.validator,
    this.enabled = true,
    this.passwordField = false,
  });

  final void Function(String) onChanged;
  final void Function(String)? onSubmitted;
  final String hintText;
  final String? prefilledValue;
  final Widget? prefixIcon;
  final bool enabled;
  final bool passwordField;
  final String? Function(String?)? validator;

  @override
  State<AppTextField> createState() => _InputFieldState();
}

class _InputFieldState extends State<AppTextField> {
  final controller = TextEditingController();
  final hidePassword = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    if (widget.prefilledValue != null) {
      controller.text = widget.prefilledValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: hidePassword,
      builder: (context, value, _) {
        return TextFormField(
          enabled: widget.enabled,
          controller: controller,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          obscureText: widget.passwordField && value,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIconConstraints: const BoxConstraints(maxHeight: 20),
            prefixIcon: widget.prefixIcon != null ? widget.prefixIcon : null,
            suffixIcon: widget.passwordField
                ? IconButton(
                    padding: EdgeInsets.zero,
                    icon: FarmFreshAsset(
                      image: value ? AppImages.visibleOff : AppImages.visible,
                    ),
                    onPressed: () => hidePassword.value = !hidePassword.value,
                  )
                : null,
            enabledBorder: _bottomBorder(Colors.grey.shade400),
            focusedBorder: _bottomBorder(AppColor.primary),
            errorBorder: _bottomBorder(Colors.red),
            focusedErrorBorder: _bottomBorder(Colors.red),
            border: _bottomBorder(Colors.grey.shade400),
            filled: false,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
          ),
        );
      },
    );
  }

  UnderlineInputBorder _bottomBorder(Color color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }
}
