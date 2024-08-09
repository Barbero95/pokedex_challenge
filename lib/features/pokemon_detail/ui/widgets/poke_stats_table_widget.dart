import 'package:flutter/material.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';
import 'package:pokedex_code_challenge_21a/features/pokemon_detail/ui/ui_model/export_ui_model.dart';

class _Constants {
  static const TextStyle textStyle = TextStyle(
    fontSize: CustomFontSize.s14,
    fontWeight: CustomFontWeight.bold,
  );
}

class PokeStatsTableWidget extends StatelessWidget {
  final List<PokemonStatUIModel> stats;

  const PokeStatsTableWidget({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
        2: IntrinsicColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        for (final stat in stats)
          TableRow(
            children: <Widget>[
              Text(
                stat.type.label(context),
                style: _Constants.textStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(left: Spaces.spaceXS),
                child: LinearProgressIndicator(
                  minHeight: Spaces.spaceXXS,
                  value: stat.value / 100,
                  borderRadius: BorderRadius.circular(
                    Spaces.spaceXXXL,
                  ),
                  color: CustomColors.bostonUniversityRed,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: Spaces.spaceXS),
                child: Text(
                  '${stat.value} / 100',
                ),
              ),
            ],
          ),
      ],
    );
  }
}
