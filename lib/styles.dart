import 'package:flutter/material.dart';

final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: Color(0xFFd8dae5),
      width: 1,
    ));

final inputDecoration = InputDecoration(
  border: border,
  disabledBorder: border,
  enabledBorder: border,
  focusedBorder: border,
  errorBorder: border,
  focusedErrorBorder: border,
  fillColor: const Color(0xFFF4F7F8),
  filled: true,
  isDense: true,
);
