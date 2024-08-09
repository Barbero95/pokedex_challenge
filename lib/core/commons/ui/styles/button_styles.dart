import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/export_domain.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';

class _Constants {
  static const double iconButtonElevation = 1;
}

class CustomButtonStyles {
  static ButtonStyle get iconButton => IconButton.styleFrom(
        elevation: _Constants.iconButtonElevation,
        backgroundColor: CustomColors.white,
      );

  static ButtonStyle get filledButton => FilledButton.styleFrom(
        backgroundColor: locator<AppBloc>().themeModel.value.primaryColor,
      );
}
