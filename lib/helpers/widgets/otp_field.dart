import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styles/app_color.dart';

class VerificationOtpInput extends StatelessWidget {
  final List<String> codeValues;
  final List<FocusNode> focusNodes;
  final Function(int, String) onChanged;

  const VerificationOtpInput({
    super.key,
    required this.codeValues,
    required this.focusNodes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        5,
        (index) => SizedBox(
          width: 50,
          height: 56,
          child: TextField(
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              onChanged(index, value);
            },
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColor.grey,
            ),
            decoration: InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColor.grey.withOpacity(0.2),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.green),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.green),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
