import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AmountMaskedFormatter extends TextInputFormatter {
  AmountMaskedFormatter({this.maxDigits = 9});

  final int maxDigits;
  late double _uMaskValue;
  final double _maxValue = 100000000.0; // Maximum value allowed

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    if (maxDigits != 0 && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }
    
    // Remove any non-numeric characters and parse the value
    final sanitizedText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    double value = double.tryParse(sanitizedText) ?? 0.0;
    
    // Ensure the value does not exceed the maximum allowed
    if (value > _maxValue) {
      value = _maxValue;
    }

    final formatter = NumberFormat("#,###", "en_US");
    final String newText = formatter.format(value);
    
    // Update the unmasked value
    _uMaskValue = value;
    
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }

  double getUnmaskedDouble() {
    return _uMaskValue;
  }
}
