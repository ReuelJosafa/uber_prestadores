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
import 'components/custom_search_widget.dart';

class UserSubpage extends StatefulWidget {
  const UserSubpage({Key? key}) : super(key: key);

  @override
  State<UserSubpage> createState() => _UserSubpageState();
}

class _UserSubpageState extends State<UserSubpage> {
  final textSearchController = TextEditingController();
  late final MapLocationController mapLocationController;
  late final SearchPlaceController searchPlaceController;

  final Set<Marker> setMarkers = {};

  Marker? newSearchMarker;

  void _buildMarkers() {
    void addMarkers(MarkerModel carMarker) async {
      setMarkers.add(
        Marker(
            markerId: MarkerId(carMarker.id),
            position: LatLng(carMarker.lat, carMarker.lng)),
      );
    }

    mapLocationController.markers.forEach(addMarkers);
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
  }

  void _addSingleMarkerToSetMarkers() {
    setMarkers.add(newSearchMarker!);
    mapLocationController.animateCameraTo(newSearchMarker!.position);
  }

  @override
  void initState() {
    mapLocationController = context.read<MapLocationController>();

    mapLocationController.addListener(() => _buildMarkers());

    searchPlaceController = context.read<SearchPlaceController>();

    searchPlaceController.addListener(() {
      if (searchPlaceController.state == SearchState.error) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Erro"),
              content: Text(searchPlaceController.error),
            );
          },
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                      lat: place.location.lat, lng: place.location.lng);
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
                  minMaxZoomPreference: const MinMaxZoomPreference(13, 16),
                  onMapCreated: location.onMapCreated,
                  initialCameraPosition:
                      CameraPosition(target: location.latLng, zoom: 16),
                  markers: setMarkers,
                  /* onTap: (place) {
                    mapLocationController.originMarker = MarkerModel(
                        id: place.latitude.toString(),
                        lat: place.latitude,
                        lng: place.longitude);
                    /* Place newPlace = Place(
                        name: 'novoLugar',
                        vicinity: 'vicinity',
                        location: Location(
                            lat: place.latitude, lng: place.longitude)); */
                    setState(() {
                      // _buildSingleMarker(newPlace);
                      textSearchController.text = '';
                    });
                  }, */
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
                                    .then((value) {
                                  /* setState(() {});
                                    _deleteLastMarker();
                                    newSearchMarker = null; */
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
