import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';

class CustomSnackBar {
  static void success({
    required BuildContext ctx,
    required String text,
  }) =>
      _showSnackBar(
        ctx: ctx,
        text: text,
        backgroundColor: CustomColors.success,
      );

  static void error({
    required BuildContext ctx,
    required String text,
  }) =>
      _showSnackBar(
        ctx: ctx,
        text: text,
        backgroundColor: CustomColors.error,
      );

  static void _showSnackBar({
    required BuildContext ctx,
    required String text,
    required Color backgroundColor,
  }) =>
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          content: Text(text),
        ),
      );
}
