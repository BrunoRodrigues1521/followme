import 'package:flutter/material.dart';
import 'package:followme/utilities/providers/SearchBar/provider.dart';
import 'package:followme/utilities/widgets/searchScreen/difficulty_toggle_switch.dart';
import 'package:followme/utilities/widgets/searchScreen/distance_toggle_switch.dart';
import 'package:followme/utilities/widgets/searchScreen/rating_switch.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  final bool isPortrait;

  @override
  State<StatefulWidget> createState() =>
      _SearchBarState(isPortrait: isPortrait);

  const SearchBar({
    Key? key,
    required this.isPortrait,
  }) : super(key: key);
}

class _SearchBarState extends State {
  final bool isPortrait;

  _SearchBarState({
    required this.isPortrait,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SearchBarProvider(),
      child: Consumer<SearchBarProvider>(builder: (context, provider, child) {
        return FloatingSearchBar(
          hint: 'Search...',
          scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
          borderRadius: BorderRadius.circular(15),
          transitionDuration: const Duration(milliseconds: 800),
          transitionCurve: Curves.easeInOut,
          physics: const BouncingScrollPhysics(),
          axisAlignment: isPortrait ? 0.0 : -1.0,
          openAxisAlignment: 0.0,
          width: isPortrait ? 600 : 500,
          debounceDelay: const Duration(milliseconds: 500),
          onQueryChanged: (query) {
            provider.routesLoaded = false;
          },
          onSubmitted: (query) {
            provider.getRoutes(context, city: query);
          },
          // Specify a custom transition to be used for
          // animating between opened and closed stated.
          transition: CircularFloatingSearchBarTransition(),
          actions: [
            FloatingSearchBarAction(
              showIfOpened: false,
              child: CircularButton(
                icon: const Icon(Icons.place),
                onPressed: () {},
              ),
            ),
            FloatingSearchBarAction.searchToClear(
              showIfClosed: false,
            ),
          ],
          builder: (context, transition) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Material(
                    color: Colors.white,
                    elevation: 4.0,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: _buildRect(provider),
                    )));
          },
        );
      }),
    );
  }

  Widget _buildRect(SearchBarProvider provider) {
    if (!provider.routesLoaded & !provider.isLoading) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        DifficultyToggleSwitch(),
        DistanceToggleSwitch(),
        RatingSwitch()
      ]);
    } else if (provider.routesLoaded) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: provider.routes
            .map((route) => ListTile(
                  title: Text(route.name),
                  trailing: Icon(Icons.chevron_right),
                ))
            .toList(),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
