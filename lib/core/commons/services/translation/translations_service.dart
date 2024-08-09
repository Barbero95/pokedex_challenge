import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:universal_io/io.dart';

final Locale defaultNotSupportedLanguage =
    Translation.delegate.supportedLocales.first;

class TranslationsService extends ChangeNotifier {
  LanguageHelper languageHelper = LanguageHelper();

  ValueNotifier<Locale> locale = ValueNotifier<Locale>(
    Locale(
      locator<SharedPreferencesService>().getLanguageCode(),
    ),
  );

  Future<void> loadLanguageFromPrefs() async {
    final String languageCode =
        locator<SharedPreferencesService>().getLanguageCode();
    if (Translation.delegate.supportedLocales
        .contains(Locale.fromSubtags(languageCode: languageCode))) {
      final Locale tempLocale = Locale.fromSubtags(languageCode: languageCode);
      locale.value = tempLocale;
      await Translation.load(tempLocale);
    } else {
      locale.value = deviceLanguage;
      await locator<SharedPreferencesService>()
          .setLanguageCode(locale.value.languageCode);
      await Translation.load(locale.value);
    }

    debugPrint('load language from prefs ${locale.value.languageCode}');
  }

  static Locale get deviceLanguage {
    final String defaultLocale = Platform.localeName;
    Locale tempLocale =
        Locale.fromSubtags(languageCode: defaultLocale.split('_').first);
    if (!Translation.delegate.supportedLocales.contains(tempLocale)) {
      tempLocale = defaultNotSupportedLanguage;
    }
    return tempLocale;
  }

  Future<void> changeLocalLanguage(String newLocale) async {
    Locale convertedLocale;

    convertedLocale = languageHelper.mapLangKeyToLocale(newLocale);
    locale.value = convertedLocale;
    await Translation.load(convertedLocale);
    await locator<SharedPreferencesService>()
        .setLanguageCode(locale.value.languageCode);
  }

  String get getCurrentLanguage =>
      locator<SharedPreferencesService>().getLanguageCode();
}
