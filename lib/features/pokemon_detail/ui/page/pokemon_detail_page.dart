import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/export_domain.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/export_ui.dart';
import 'package:pokedex_code_challenge_21a/core/extension/export_extension.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/export_pokemon_detail.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/ui/widgets/export_widgets.dart';
import 'package:universal_io/io.dart';

class _Constants {
  static const double topPadding = 72;
  static const double miniumImageWidth = 250;
  static const double imagePercentage = 0.25;
  static const pokeball = 'assets/svg/pokeball.svg';
  static const selectedPokeball = 'assets/svg/selected_pokeball.svg';
}

class PokemonDetailPage extends StatefulWidget {
  final PokemonUIModel pokemon;
  const PokemonDetailPage({
    super.key,
    required this.pokemon,
  });

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  late PokemonDetailBloc _pokemonDetailBloc;
  late bool _isMobile;

  @override
  void initState() {
    super.initState();
    _pokemonDetailBloc = locator<PokemonDetailBloc>()
      ..getPokemon(
        name: widget.pokemon.name,
        isShiny: widget.pokemon.isShiny,
      );
    _isMobile = Platform.isAndroid || Platform.isIOS;
    if (widget.pokemon.isFromPokedex && widget.pokemon.isShiny) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomSnackBar.success(
          ctx: context,
          text: context.trl.snack_bar_shiny_pokemon_title,
        );
      });
    }
  }

  Widget get _error => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spaces.spaceXS,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  FontAwesomeIcons.triangleExclamation,
                ),
                Spaces.verticalS,
                Text(
                  context.trl.pokemon_detail_error_title,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );

  double get _imageSize {
    double width =
        MediaQuery.of(context).size.width * _Constants.imagePercentage;
    if (width < _Constants.miniumImageWidth) {
      width = _Constants.miniumImageWidth;
    }
    return width;
  }

  Widget get _backArrowWidget => IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(
          Icons.arrow_back,
        ),
        style: CustomButtonStyles.iconButton,
      );

  Widget get _caughtPokeWidget => ValueListenableBuilder(
        valueListenable: _pokemonDetailBloc.isCaught,
        builder: (_, isCaughtListenable, __) {
          final (screenState, isCaught) = isCaughtListenable;
          if (screenState.isLoading) {
            return IconButton(
              onPressed: null,
              icon: const CircularProgressIndicator(),
              style: CustomButtonStyles.iconButton,
            );
          }
          if (screenState.isIdle && isCaught != null) {
            return IconButton(
              onPressed: () => isCaught
                  ? _pokemonDetailBloc.freePokemon(context)
                  : _pokemonDetailBloc.caughtPokemon(context),
              icon: SvgPicture.asset(
                isCaught ? _Constants.selectedPokeball : _Constants.pokeball,
                height: Spaces.spaceS,
              ),
              style: CustomButtonStyles.iconButton,
            );
          }
          return const SizedBox.shrink();
        },
      );

  Widget get _appBar => Padding(
        padding: const EdgeInsets.all(Spaces.spaceXS),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _backArrowWidget,
            _caughtPokeWidget,
          ],
        ),
      );

  String get _shinyText =>
      widget.pokemon.isShiny ? ' (${context.trl.shiny_label})' : '';

  Widget _body(ScreenState screenState) => Column(
        children: [
          if (_isMobile)
            SafeArea(
              bottom: false,
              child: _appBar,
            )
          else
            _appBar,
          Spaces.verticalSpace(_imageSize / 2),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: CustomColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Spaces.spaceXXS),
                  topRight: Radius.circular(Spaces.spaceXXS),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spaces.spaceXS,
                ),
                child: Column(
                  children: [
                    Spaces.verticalSpace(_imageSize * 0.47),
                    Text(
                      '${widget.pokemon.name.capitalize}$_shinyText',
                      style: const TextStyle(
                        fontSize: CustomFontSize.s24,
                        color: CustomColors.neutralBlack,
                        fontWeight: CustomFontWeight.semibold,
                      ),
                    ),
                    Spaces.verticalXXS,
                    Text(
                      widget.pokemon.pokedexNum.pokedexNum,
                      style: const TextStyle(
                        fontSize: CustomFontSize.s16,
                        color: CustomColors.neutralBlack,
                        fontWeight: CustomFontWeight.regular,
                      ),
                    ),
                    if (screenState.isIdle)
                      Column(
                        children: [
                          Spaces.verticalXS,
                          Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              runSpacing: Spaces.spaceXXS,
                              spacing: Spaces.spaceXXS,
                              children: [
                                for (final type in _pokemonDetailBloc
                                    .pokemonDetailUIModel!.types)
                                  PokeTypeChip(type: type),
                              ],
                            ),
                          ),
                          Spaces.verticalXS,
                          PokeAboutWidget(
                            pokemonDetailUIModel:
                                _pokemonDetailBloc.pokemonDetailUIModel,
                          ),
                        ],
                      )
                    else
                      Container(
                        height: Spaces.spaceXXL,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget get _pokemonImage => Container(
        margin: const EdgeInsets.only(
          top: _Constants.topPadding,
        ),
        width: _imageSize,
        height: _imageSize,
        child: Hero(
          tag: '${widget.pokemon.name}_${widget.pokemon.isFromPokedex}',
          child: Stack(
            alignment: Alignment.center,
            children: [
              PokemonImageWidget(
                pokemon: widget.pokemon.pokedexNum,
                isShiny: widget.pokemon.isShiny,
                showBack: _pokemonDetailBloc.showBack,
                width: _imageSize,
                height: _imageSize,
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => setState(
                    _pokemonDetailBloc.updateShowBack,
                  ),
                  style: CustomButtonStyles.iconButton,
                  icon: const Icon(
                    FontAwesomeIcons.rotate,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _pokemonDetailBloc.screenState,
      builder: (_, screenState, __) {
        return Scaffold(
          backgroundColor: screenState.isIdle
              ? _pokemonDetailBloc.pokemonDetailUIModel?.backgroundColor
              : null,
          body: switch (screenState) {
            ScreenState.error => _error,
            _ => Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  _body(screenState),
                  if (_isMobile)
                    SafeArea(child: _pokemonImage)
                  else
                    _pokemonImage,
                ],
              ),
          },
        );
      },
    );
  }
}
