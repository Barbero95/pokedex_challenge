import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex_code_challenge_21a/core/extension/export_extension.dart';

class NavigationBarBloc {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set updatedSelectedIndex(int value) => _selectedIndex = value;

  Map<String, IconData> getTabs(BuildContext ctx) => {
        ctx.trl.pokedex_title: FontAwesomeIcons.list,
        ctx.trl.caught_pokemons_title: FontAwesomeIcons.bookmark,
      };
}
