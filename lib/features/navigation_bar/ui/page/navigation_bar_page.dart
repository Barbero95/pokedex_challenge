import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex_code_challenge_21a/core/commons/domain/export_domain.dart';
import 'package:pokedex_code_challenge_21a/core/commons/services/export_services.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/styles/export_styles.dart';
import 'package:pokedex_code_challenge_21a/core/commons/ui/widgets/export_widgets.dart';
import 'package:pokedex_code_challenge_21a/features/caught_pokemon/ui/export_ui.dart';
import 'package:pokedex_code_challenge_21a/features/navigation_bar/export_navigation_bar.dart';
import 'package:pokedex_code_challenge_21a/features/pokedex/export_pokedex.dart';

class _Constants {
  static const pokeball = 'assets/svg/pokeball.svg';
  static const whiteTextStyle = TextStyle(
    color: CustomColors.white,
  );
  static const borderLineWidth = 1.5;
}

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  late NavigationBarBloc _navigationBarBloc;

  @override
  void initState() {
    super.initState();
    _navigationBarBloc = locator<NavigationBarBloc>();
  }

  List<NavigationDestination> get _destinations => [
        for (final tab in _navigationBarBloc.getTabs(context).entries)
          NavigationDestination(
            label: tab.key,
            icon: Icon(
              tab.value,
            ),
          ),
      ];

  Widget get _navigationBar => NavigationBar(
        selectedIndex: _navigationBarBloc.selectedIndex,
        onDestinationSelected: (value) => setState(
          () => _navigationBarBloc.updatedSelectedIndex = value,
        ),
        destinations: _destinations,
      );

  Widget get _body => IndexedStack(
        index: _navigationBarBloc.selectedIndex,
        children: [
          const PokedexPage(),
          CaughtPokemonPage(
            goToPokedex: () => setState(
              () => _navigationBarBloc.updatedSelectedIndex = 0,
            ),
          ),
        ],
      );

  AppBar _appBar(bool isMobile) => AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              _Constants.pokeball,
              height: Spaces.spaceM,
              colorFilter: const ColorFilter.mode(
                CustomColors.white,
                BlendMode.srcIn,
              ),
            ),
            Spaces.horizontalXXS,
            Text(
              locator<EnvironmentService>().getValue(EnvKeys.appTitle)
                  as String,
              style: _Constants.whiteTextStyle,
            ),
          ],
        ),
        actions: [
          if (!isMobile) ...[
            for (final (index, tab)
                in _navigationBarBloc.getTabs(context).entries.indexed) ...[
              InkWell(
                onTap: () => setState(
                  () => _navigationBarBloc.updatedSelectedIndex = index,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: Spaces.spaceXXXS,
                  ),
                  decoration: BoxDecoration(
                    border: _navigationBarBloc.selectedIndex == index
                        ? const Border(
                            bottom: BorderSide(
                              width: _Constants.borderLineWidth,
                              color: CustomColors.white,
                            ),
                          )
                        : null,
                  ),
                  child: Text(
                    tab.key,
                    style: _Constants.whiteTextStyle,
                  ),
                ),
              ),
              Spaces.horizontalXS,
            ],
          ],
          const LanguageDropdownWidget(),
        ],
        centerTitle: false,
      );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final isMobile = AppBloc.isMobile(constraints);
        return Scaffold(
          appBar: _appBar(isMobile),
          bottomNavigationBar: isMobile ? _navigationBar : null,
          body: _body,
        );
      },
    );
  }
}
