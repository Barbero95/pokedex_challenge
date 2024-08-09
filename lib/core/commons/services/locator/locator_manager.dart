import 'package:get_it/get_it.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/BLoC/export_bloc.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/models/export_models.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:pokedex_code_challenge_21a/features/caught_pokemon/export_caught_pokemon.dart';
import 'package:pokedex_code_challenge_21a/features/navigation_bar/export_navigation_bar.dart';
import 'package:pokedex_code_challenge_21a/features/pokedex/export_pokedex.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/export_pokemon_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator(EnvironmentConfig environmentConfig) async {
  _registerServices(environmentConfig);

  _registerDataSources();

  _registerBlocs();

  await locator.allReady();
}

// // ============================== SERVICES ==============================

void _registerServices(EnvironmentConfig environmentConfig) {
  locator
    ..registerSingletonAsync<EnvironmentService>(() async {
      final EnvironmentService appConfigservice = EnvironmentService();
      return appConfigservice;
    })
    ..registerSingletonAsync<SharedPreferencesService>(() async {
      final SharedPreferences sharedPref =
          await SharedPreferences.getInstance();
      return SharedPreferencesService(sharedPref);
    })
    ..registerSingletonAsync<TranslationsService>(
      () async {
        final TranslationsService translationsService = TranslationsService();
        await translationsService.loadLanguageFromPrefs();
        return translationsService;
      },
      dependsOn: [
        SharedPreferencesService,
      ],
    );
}

// // ============================== DATA SOURCES ==============================

void _registerDataSources() {
  locator
    ..registerFactory<PokedexDatasource>(
      PokedexDatasourceImpl.new,
    )
    ..registerFactory<CaughtPokemonDatasource>(
      CaughtPokemonDatasourceImpl.new,
    )
    ..registerFactory<PokemonDetailDatasource>(
      PokemonDetailDatasourceImpl.new,
    );
}

// // ============================== BLOCs ==============================

void _registerBlocs() {
  locator
    ..registerSingletonAsync<AppBloc>(
      () async {
        final primaryColor = await AppBloc.loadPrimaryColorFromPrefs();
        return AppBloc(primaryColor);
      },
      dependsOn: [
        SharedPreferencesService,
      ],
    )
    ..registerFactory(
      NavigationBarBloc.new,
    )
    ..registerFactory(
      () => PokedexBloc(
        locator<PokedexDatasource>(),
      ),
    )
    ..registerLazySingleton(
      () => CaughtPokemonBloc(
        locator<CaughtPokemonDatasource>(),
      ),
    )
    ..registerFactory(
      () => PokemonDetailBloc(
        locator<PokemonDetailDatasource>(),
      ),
    );
}
