import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';

class _Constants {
  static const TextStyle textStyle = TextStyle(
    fontSize: CustomFontSize.s14,
    fontWeight: CustomFontWeight.bold,
    color: CustomColors.neutralBlack,
  );
  static const double iconSize = 18;
}

class PokeAboutItemWidget extends StatelessWidget {
  final String title;
  final double? value;
  final IconData? icon;

  const PokeAboutItemWidget({
    super.key,
    required this.title,
    required this.value,
    this.icon,
  });

  String _getText(double? value) => value?.toString() ?? '??';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            text: '$title: ',
            style: _Constants.textStyle,
            children: <TextSpan>[
              TextSpan(
                text: _getText(value),
                style: _Constants.textStyle.copyWith(
                  fontWeight: CustomFontWeight.regular,
                ),
              ),
            ],
          ),
        ),
        if (icon != null) ...[
          Spaces.horizontalXXS,
          Icon(
            icon,
            size: _Constants.iconSize,
          ),
        ],
      ],
    );
  }
}
