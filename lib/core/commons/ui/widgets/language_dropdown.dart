import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';

class _Constants {
  static const TextStyle languageTextStyle = TextStyle(
    fontWeight: CustomFontWeight.semibold,
  );
}

class LanguageDropdownWidget extends StatefulWidget {
  const LanguageDropdownWidget({super.key});

  @override
  State<LanguageDropdownWidget> createState() => _LanguageDropdownWidgetState();
}

class _LanguageDropdownWidgetState extends State<LanguageDropdownWidget> {
  late String _currentLanguage;

  @override
  void initState() {
    super.initState();
    _currentLanguage = locator<TranslationsService>().getCurrentLanguage;
  }

  Widget _getLanguageWidget({
    required String language,
    required Color color,
  }) =>
      Text(
        language.toUpperCase(),
        style: _Constants.languageTextStyle.copyWith(
          color: color,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        value: _currentLanguage,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        underline: Container(
          height: Spaces.zero,
        ),
        onChanged: (String? language) async {
          if (language != null) {
            await locator<TranslationsService>().changeLocalLanguage(language);
            setState(() {
              _currentLanguage = language;
            });
          }
        },
        items: languagesListDefault
            .map<DropdownMenuItem<String>>((String language) {
          return DropdownMenuItem<String>(
            value: language,
            child: _getLanguageWidget(
              language: language,
              color: CustomColors.neutralBlack,
            ),
          );
        }).toList(),
        selectedItemBuilder: (BuildContext context) {
          return languagesListDefault.map((String language) {
            return Center(
              child: _getLanguageWidget(
                language: language,
                color: CustomColors.white,
              ),
            );
          }).toList();
        },
      ),
    );
  }
}
