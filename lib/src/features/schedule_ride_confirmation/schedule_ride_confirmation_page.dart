import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../shared/components/custom_back_button_widget.dart';
import '../../shared/components/custom_elevated_button_widget.dart';
import '../../shared/components/custom_sufix_icon_widget.dart';
import '../../shared/components/custom_text_form_field_widget.dart';
import '../../shared/constants/app_images.dart';
import '../../shared/controllers/map_location_controller.dart';
import '../../shared/controllers/search_place_controller.dart';
import '../../shared/models/marker_model.dart';
import '../../shared/utils/uint_8_list_utils.dart';
import '../home/submodules/user/components/custom_search_widget.dart';
import 'components/expansion_section.dart';

class ScheduleRideConfirmationPage extends StatefulWidget {
  const ScheduleRideConfirmationPage({Key? key}) : super(key: key);

  @override
  State<ScheduleRideConfirmationPage> createState() =>
      _ScheduleRideConfirmationPageState();
}

class _ScheduleRideConfirmationPageState
    extends State<ScheduleRideConfirmationPage> {
  bool isModalOpen = false;
  late final MapLocationController mapLocationController;
  final Set<Marker> setMarkers = {};
  Marker? _originMarker;
  Marker? _destinationMarker;
  final textOriginController = TextEditingController();
  final textDestinationController = TextEditingController();
  final Set<Polyline> polylines = {};
  _buildMarkers() {
    addMarkers(MarkerModel carMarker) async {
      Uint8ListUtils.getBytesFromAsset(AppImages.smallCar, 180).then((icon) {
        setMarkers.add(
          Marker(
              markerId: MarkerId(carMarker.id),
              position: LatLng(carMarker.lat, carMarker.lng),
              icon: BitmapDescriptor.fromBytes(icon),
              onTap: () {
                setState(() {
                  isModalOpen = true;
                });
              }),
        );
      });
    }

    mapLocationController.markers.forEach(addMarkers);
  }

  void _buildOriginMarker(MarkerModel marker) {
    _deleteLastMarker(_originMarker);

    _originMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        markerId: MarkerId(marker.id),
        position: LatLng(marker.lat, marker.lng));

    _addSingleMarkerToSetMarkers(_originMarker!);
  }

  void _buildDestinationMarker(MarkerModel marker) {
    _deleteLastMarker(_destinationMarker);

    _destinationMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        markerId: MarkerId(marker.id),
        position: LatLng(marker.lat, marker.lng));

    _addSingleMarkerToSetMarkers(_destinationMarker!);
  }

  void _deleteLastMarker(Marker? marker) {
    if (marker != null) {
      setMarkers
          .removeWhere((setMarker) => setMarker.markerId == marker.markerId);
    }
  }

  void _addSingleMarkerToSetMarkers(Marker marker) {
    setMarkers.add(marker);
    if (_originMarker == null || _destinationMarker == null) {
      mapLocationController.animateCameraTo(marker.position);
    }
  }

  void _setPolylines() {
    polylines.add(Polyline(
      polylineId: const PolylineId('polylineId'),
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      jointType: JointType.bevel,
      width: 4,
      color: Theme.of(context).primaryColor,
      points: mapLocationController
          .getDirections()!
          .polylineDecoded
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList(),
    ));
    mapLocationController.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: mapLocationController.getDirections()!.boundsSw,
            northeast: mapLocationController.getDirections()!.boundsNe),
        50));
  }

  @override
  void initState() {
    mapLocationController = context.read<MapLocationController>();
    mapLocationController.addListener(() {
      _buildDestinationMarker(mapLocationController.getDestinationMarker()!);
      _buildMarkers();
    });

    final searchPlaceController = context.read<SearchPlaceController>();
    textDestinationController.text =
        searchPlaceController.selectedLocation.name;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchPlaceController = Provider.of<SearchPlaceController>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          ExpandedSection(
            expand: !isModalOpen,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                CustomSearchWidget(
                  textHint: 'Digite o ponto de partida',
                  onSuggestionSelected: (String placeId) async {
                    await searchPlaceController.setSelectedLocation(placeId);
                    final place = searchPlaceController.selectedLocation;
                    mapLocationController.originMarker = MarkerModel(
                        lat: place.location.lat, lng: place.location.lng);
                    _buildOriginMarker(
                        mapLocationController.getOriginMarker()!);
                    if (_originMarker != null && _destinationMarker != null) {
                      await mapLocationController.fetchDirections();
                      _setPolylines();
                    }
                  },
                  textController: textOriginController,
                  assetIconName: AppImages.place,
                  backgroundColor: Colors.blue,
                ),
                const SizedBox(height: 16),
                /* CustomTextFormField(
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    hintText: 'Digite o ponto de partida',
                    icon: CustomSufixIcon(
                      backgroundColor:
                          Theme.of(context).buttonTheme.colorScheme!.secondary,
                      assetName: AppImages.place,
                    )), */
                CustomSearchWidget(
                  textHint: 'Digite seu destino',
                  onSuggestionSelected: (String placeId) async {
                    await searchPlaceController.setSelectedLocation(placeId);
                    final place = searchPlaceController.selectedLocation;
                    mapLocationController.destinationMarker = MarkerModel(
                        lat: place.location.lat, lng: place.location.lng);
                    _buildDestinationMarker(
                        mapLocationController.getDestinationMarker()!);
                    if (_originMarker != null && _destinationMarker != null) {
                      await mapLocationController.fetchDirections();
                      _setPolylines();
                    }
                  },
                  textController: textDestinationController,
                  assetIconName: AppImages.search,
                  backgroundColor: Colors.red,
                ),
                /* CustomTextFormField(
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    hintText: 'Digite seu destino',
                    icon: CustomSufixIcon(
                      backgroundColor:
                          Theme.of(context).buttonTheme.colorScheme!.secondary,
                      assetName: AppImages.search,
                    )), */
                CustomTextFormField(
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.done,
                    hintText: '00:00',
                    icon: CustomSufixIcon(
                      backgroundColor:
                          Theme.of(context).buttonTheme.colorScheme!.secondary,
                      assetName: AppImages.time,
                    )),
              ]),
            ),
          ),
          Expanded(
            child: AnimatedAlign(
              alignment:
                  isModalOpen ? Alignment.topCenter : Alignment.bottomCenter,
              duration: const Duration(milliseconds: 800),
              child:
                  Consumer<MapLocationController>(builder: (_, location, __) {
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
                  polylines: polylines,
                );
              }),
            ),
          ),
          ExpandedSection(
              expand: isModalOpen,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(width: 4),
                                      Column(
                                        children: [
                                          // const SizedBox(height: 4),
                                          SvgPicture.asset(
                                              AppImages.localPlace),
                                          const SizedBox(height: 6),
                                          SvgPicture.asset(
                                              AppImages.dottedLine),
                                        ],
                                      ),
                                      const SizedBox(width: 8),
                                      const SizedBox(height: 3),
                                      Expanded(
                                        child: Text('Seu local',
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(
                                                    color: const Color(
                                                        0xFF979797))),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: SvgPicture.asset(
                                            AppImages.destinationPlace),
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                            'Informe seu destino  dsfsdf ds dfhhhhhhhhh hrfe e er ew e ',
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(
                                                    color: const Color(
                                                        0xFF979797))),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                width: 110,
                                child: Image.asset(AppImages.translucidCar,
                                    fit: BoxFit.scaleDown))
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomElevatedButton(context, onTap: () async {
                          await mapLocationController.fetchDirections();
                          _setPolylines();
                        },
                            title: 'Agendar corrida',
                            color: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .secondary)
                      ],
                    ),
                  ),
                  Container(
                      color: Colors.grey[300],
                      height: 1,
                      width: double.maxFinite),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: IconButton(
                        splashRadius: 22,
                        onPressed: () {
                          setState(() {
                            isModalOpen = false;
                          });
                        },
                        icon: const Icon(Icons.close)),
                  )
                ],
              ))
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: CustomBackButton(context, buttonColor: Colors.white),
      centerTitle: true,
      title: const Text(
        'Agendamento',
      ),
    );
  }

/*   void _showModalBottom() {
    showModalBottomSheet(
      // transitionAnimationController: modalController,
      context: context,
      // isDismissible: false,
      elevation: 0,
      barrierColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(color: const Color(0xFFF7F7F7), height: 8, width: 88),
              const SizedBox(height: 8),
              Center(child: _buildCustomDivider()),
              const SizedBox(height: 4),
              Center(child: _buildCustomDivider()),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 4),
                            Column(
                              children: [
                                // const SizedBox(height: 4),
                                SvgPicture.asset(AppImages.localPlace),
                                const SizedBox(height: 6),
                                SvgPicture.asset(AppImages.dottedLine),
                              ],
                            ),
                            const SizedBox(width: 8),
                            const SizedBox(height: 3),
                            Expanded(
                              child: Text('Seu local',
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                          color: const Color(0xFF979797))),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child:
                                  SvgPicture.asset(AppImages.destinationPlace),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                  'Informe seu destino  dsfsdf ds dfhhhhhhhhh hrfe e er ew e ',
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                          color: const Color(0xFF979797))),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: 110,
                      child: Image.asset(AppImages.translucidCar,
                          fit: BoxFit.scaleDown))
                ],
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(context,
                  onTap: () {},
                  title: 'Agendar corrida',
                  color: Theme.of(context).buttonTheme.colorScheme!.secondary)
            ],
          ),
        );
      },
    ).then((value) {
      setState(() {
        isModalOpen = false;
      });
    });
  } */

  /* Container _buildCustomDivider() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      height: 2,
      width: 44,
    );
  } */
}
