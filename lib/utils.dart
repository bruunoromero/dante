import 'package:flutter/material.dart';

IconData textToIcon(String text) {
  final lText = text.toLowerCase();

  if(lText == "work") {
    return Icons.work;
  }

  return null;
}