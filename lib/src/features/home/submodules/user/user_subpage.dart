import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_prestadores/src/shared/components/custom_elevated_button_widget.dart';
import 'package:uber_prestadores/src/shared/controllers/map_location_controller.dart';

import '../../../../shared/constants/app_images.dart';
import '../../../../shared/constants/app_routes.dart';
import '../../../../shared/controllers/search_place_controller.dart';
import '../../../../shared/models/marker_model.dart';
import '../../../../shared/utils/alert_dialog_utils.dart';
import 'components/custom_search_widget.dart';

class UserSubpage extends StatefulWidget {
  const UserSubpage({Key? key}) : super(key: key);

  @override
  State<UserSubpage> createState() => _UserSubpageState();
}

class _UserSubpageState extends State<UserSubpage> {
  final textSearchController = TextEditingController();
  late final MapLocationController mapLocationController;
  final Set<Marker> setMarkers = {};
  Marker? newSearchMarker;
  bool _showLinearProgressIndicator = false;

  void _buildMarkers() {
    void addMarkers(MarkerModel destinationMarker) {
      setMarkers.add(
        Marker(
            markerId: MarkerId(destinationMarker.id),
            position: LatLng(destinationMarker.lat, destinationMarker.lng)),
      );
    }

    mapLocationController.destinationMarkers.forEach(addMarkers);
  }

  void _buildSingleMarker(MarkerModel marker) {
    _deleteLastMarker();

    newSearchMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        markerId: MarkerId(marker.id),
        position: LatLng(marker.lat, marker.lng));

    _addSingleMarkerToSetMarkers();
  }

  void _deleteLastMarker() {
    if (newSearchMarker != null) {
      setMarkers.removeWhere(
          (marker) => marker.markerId == newSearchMarker!.markerId);
    }
    _buildMarkers();
  }

  void _addSingleMarkerToSetMarkers() {
    setMarkers.add(newSearchMarker!);
    mapLocationController.animateCameraTo(newSearchMarker!.position);
  }

  @override
  void initState() {
    mapLocationController = context.read<MapLocationController>();

    mapLocationController.addListener(() {
      _buildMarkers();
    });

    final searchPlaceController = context.read<SearchPlaceController>();

    searchPlaceController.addListener(() async {
      //TODO: Modificar maneira de exibição de mensagem
      if (searchPlaceController.state == SearchState.error &&
          searchPlaceController.showErrorDialog) {
        searchPlaceController.showErrorDialog = false;
        await AlertDialogUtils.showAlertDialog(
          context,
          title: "Erro de conexão",
          contentText: searchPlaceController.error,
        );
        await Future.delayed(const Duration(seconds: 15)).then((_) {
          searchPlaceController.showErrorDialog = true;
        });
      } else if (searchPlaceController.state == SearchState.loading) {
        _showLinearProgressIndicator = true;
      } else {
        _showLinearProgressIndicator = false;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchPlaceController = context.watch<SearchPlaceController>();

    return Column(
      children: [
        if (_showLinearProgressIndicator) const LinearProgressIndicator(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              const Text('LOGO',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.w400)),
              const SizedBox(height: 32),
              Text('Bem-vindo, Usuário.',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline1),
              const SizedBox(height: 8),
              CustomSearchWidget(
                textHint: 'Digite seu destino',
                onSuggestionSelected: (String placeId) async {
                  await searchPlaceController.setSelectedLocation(placeId);
                  final place = searchPlaceController.selectedLocation;
                  mapLocationController.destinationMarker = MarkerModel(
                      lat: place.location.lat,
                      lng: place.location.lng,
                      address: place.name);
                  _buildSingleMarker(
                      mapLocationController.getDestinationMarker()!);
                },
                textController: textSearchController,
                assetIconName: AppImages.search,
                backgroundColor: Colors.red,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        Expanded(
            child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Consumer<MapLocationController>(builder: (_, location, __) {
                if (location.mapLocationState == MapLocationState.error) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(location.error,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3),
                    ),
                  );
                }
                return GoogleMap(
                  mapToolbarEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  minMaxZoomPreference: const MinMaxZoomPreference(8, 16),
                  onMapCreated: location.onMapCreated,
                  initialCameraPosition:
                      CameraPosition(target: location.latLng, zoom: 16),
                  markers: setMarkers,
                );
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Consumer<MapLocationController>(
                      builder: (_, location, __) {
                    return CustomElevatedButton(context,
                        onTap: location.getDestinationMarker() != null
                            ? () => Navigator.of(context)
                                    .pushNamed(
                                        AppRoutes.scheduleRideConfirmation)
                                    .then((_) {
                                  _deleteLastMarker();
                                  newSearchMarker = null;
                                  textSearchController.text = '';
                                })
                            : null,
                        title: 'Agendar corrida',
                        icon: SvgPicture.asset(AppImages.calendar),
                        color: Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .secondary);
                  }),
                ),
              )
            ],
          ),
        ))
      ],
    );
  }
}
