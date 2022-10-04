import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/components/custom_sufix_icon_widget.dart';
import '../../../../../shared/controllers/map_location_controller.dart';
import '../../../../../shared/controllers/search_place_controller.dart';
import '../../../../../shared/models/place_search.dart';
import '../../../../../shared/utils/text_field_style.dart';

class CustomSearchWidget extends StatelessWidget {
  final String textHint;
  final TextEditingController textController;
  final String assetIconName;
  final void Function(String placeId) onSuggestionSelected;
  final Color backgroundColor;
  const CustomSearchWidget(
      {Key? key,
      required this.textHint,
      required this.textController,
      required this.assetIconName,
      required this.onSuggestionSelected,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchPlaceController = context.watch<SearchPlaceController>();
    final mapLocationController = context.watch<MapLocationController>();

    return TypeAheadField<PlaceSearch?>(
      textFieldConfiguration: TextFieldConfiguration(
        style: Theme.of(context).textTheme.headline3,
        controller: textController,
        onSubmitted: (value) {
          if (value.isNotEmpty &&
              mapLocationController.mapLocationState ==
                  MapLocationState.success) {
            searchPlaceController.searchPlaces(
                value, mapLocationController.latLng);
            if (searchPlaceController.searchResults.isNotEmpty) {
              final suggestion = searchPlaceController.searchResults[0];
              textController.text = suggestion.description;
              onSuggestionSelected(suggestion.placeId);
            }
          }
        },
        decoration: TextFieldStyle(
            text: textHint,
            trailingIcon: CustomSufixIcon(
              isSearching: textController.text.isNotEmpty,
              onTap: () {
                textController.text = '';
              },
              backgroundColor: backgroundColor,
              assetName: assetIconName,
            )),
      ),
      suggestionsCallback: (value) {
        if (mapLocationController.mapLocationState !=
            MapLocationState.success) {
          return [];
        }
        searchPlaceController.searchPlaces(value, mapLocationController.latLng);
        return searchPlaceController.searchResults;
      },
      itemBuilder: (context, PlaceSearch? suggestion) {
        if (suggestion == null) return const SizedBox();

        final place = suggestion;

        return ListTile(
            title: Text(place.details.mainText),
            subtitle: Text(
              place.details.secondaryText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: IconButton(
                onPressed: () {
                  textController.text = place.description;
                },
                icon: const Icon(Icons.north_west)));
      },
      noItemsFoundBuilder: (context) => const SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Text(
            'Não há destinos para esta pesquisa',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      onSuggestionSelected: (PlaceSearch? suggestion) {
        if (suggestion != null &&
            mapLocationController.mapLocationState ==
                MapLocationState.success) {
          textController.text = suggestion.description;
          onSuggestionSelected(suggestion.placeId);
        }
      },
    );
  }
}
