import 'package:flutter/material.dart';

class ToolItem {
  final String title;
  final IconData icon;
  final Widget screen;
  final bool isPro;

  const ToolItem({
    required this.title,
    required this.icon,
    required this.screen,
    this.isPro = false,
  });
}
