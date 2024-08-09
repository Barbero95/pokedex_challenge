import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/export_domain.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';

class _EndPoints {
  static const String pokemon = '/pokemon';
  static const String back = '/back';
  static const String shiny = '/shiny';
}

class PokemonImageWidget extends StatelessWidget {
  final bool showBack;
  final bool isShiny;
  final int? pokemon;
  final double? width;
  final double? height;

  const PokemonImageWidget({
    super.key,
    this.showBack = false,
    this.isShiny = false,
    required this.pokemon,
    this.width,
    this.height,
  });

  String get _imageUrl {
    final String baseUrl =
        locator<EnvironmentService>().getValue(EnvKeys.mediaUrl) as String;
    final String backString = showBack ? _EndPoints.back : '';
    final String shinyString = isShiny ? _EndPoints.shiny : '';
    return '$baseUrl${_EndPoints.pokemon}$backString$shinyString/$pokemon.png';
  }

  @override
  Widget build(BuildContext context) {
    if (pokemon == null) return const Icon(Icons.error);
    return CachedNetworkImage(
      imageUrl: _imageUrl,
      height: height,
      width: width,
      fit: BoxFit.contain,
      placeholder: (_, __) => const SizedBox.shrink(),
      errorWidget: (_, __, ___) => const Icon(Icons.error),
    );
  }
}
