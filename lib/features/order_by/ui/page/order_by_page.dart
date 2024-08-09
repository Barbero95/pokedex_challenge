import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/export_domain.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/export_ui.dart';
import 'package:pokedex_code_challenge_21a/core/extension/export_extension.dart';
import 'package:pokedex_code_challenge_21a/features/order_by/domain/export_domain.dart';

typedef OnChanged = void Function(OrderByType? value);

class OrderByPage extends StatefulWidget {
  final SelectedOrderModel orderBy;
  final bool enableByAlphabetical;
  final bool enableByPokemonType;
  final bool enableByShiny;

  const OrderByPage({
    super.key,
    required this.orderBy,
    required this.enableByAlphabetical,
    required this.enableByPokemonType,
    required this.enableByShiny,
  });

  @override
  State<OrderByPage> createState() => _OrderByPageState();
}

class _OrderByPageState extends State<OrderByPage> {
  late SelectedOrderModel _selectedOrderBy;

  @override
  void initState() {
    super.initState();
    _selectedOrderBy = widget.orderBy;
  }

  Widget get _dropdownPokemonTypeWidget => DropdownButton<PokemonType>(
        value: _selectedOrderBy.pokemonType,
        hint: Text(
          context.trl.select_label,
        ),
        items: PokemonType.values
            .map(
              (type) => DropdownMenuItem<PokemonType>(
                value: type,
                child: Row(
                  children: [
                    CircleAvatar(
                      maxRadius: Spaces.spaceXXS,
                      backgroundColor: type.color,
                    ),
                    Spaces.horizontalXXS,
                    Text(
                      type.label(context),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        onChanged: (type) => setState(
          () => _selectedOrderBy
            ..type = OrderByType.pokemonType
            ..pokemonType = type,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.trl.order_by_title,
          style: const TextStyle(
            color: CustomColors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FilledButton(
        onPressed: () {
          if (_selectedOrderBy.type.isByPokemonType &&
              _selectedOrderBy.pokemonType == null) {
            CustomSnackBar.error(
              ctx: context,
              text: context.trl.snack_bar_select_pokemon_type_error,
            );
            return;
          }
          context.pop(_selectedOrderBy);
        },
        style: CustomButtonStyles.filledButton,
        child: Text(
          context.trl.save_label,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: Spaces.spaceXXS,
          vertical: Spaces.spaceXS,
        ),
        children: [
          for (final order in OrderByType.getValues(
            enableByAlphabetical: widget.enableByAlphabetical,
            enableByPokemonType: widget.enableByPokemonType,
            enableByShiny: widget.enableByShiny,
          ))
            RadioListTile<OrderByType>(
              title: Row(
                children: [
                  Text(order.label(context)),
                  Spaces.horizontalXS,
                  if (order.isByPokemonType) _dropdownPokemonTypeWidget,
                ],
              ),
              groupValue: _selectedOrderBy.type,
              value: order,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedOrderBy
                      ..type = value
                      ..pokemonType = null;
                  });
                }
              },
              activeColor: locator<AppBloc>().themeModel.value.primaryColor,
            ),
        ],
      ),
    );
  }
}
