import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../shared/components/custom_back_button_widget.dart';
import '../../shared/components/custom_elevated_button_widget.dart';
import '../../shared/components/custom_text_form_field_widget.dart';
import '../../shared/constants/app_images.dart';
import '../../shared/components/custom_sufix_icon_widget.dart';
import '../../shared/controllers/map_location_controller.dart';
import 'components/expansion_section.dart';
import 'models/car_marker.dart';

class ScheduleRideConfirmationPage extends StatefulWidget {
  const ScheduleRideConfirmationPage({Key? key}) : super(key: key);

  @override
  State<ScheduleRideConfirmationPage> createState() =>
      _ScheduleRideConfirmationPageState();
}

class _ScheduleRideConfirmationPageState
    extends State<ScheduleRideConfirmationPage> {
  final markers = [
    CarMarker(id: 'car1', lat: -22.970225, lng: -43.186071),
    CarMarker(id: 'car2', lat: -22.964971, lng: -43.189366),
    CarMarker(id: 'car3', lat: -22.966551, lng: -43.182456)
  ];
  bool isModalOpen = false;

  final Set<Marker> setMarkers = {};

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  _buildMarkers() {
    addMarkers(CarMarker carMarker) async {
      // BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: pixelRatio), assetName)

      getBytesFromAsset(AppImages.smallCar, 180).then((icon) {
        setMarkers.add(
          Marker(
              markerId: MarkerId(carMarker.id),
              position: LatLng(carMarker.lat, carMarker.lng),
              icon: BitmapDescriptor.fromBytes(icon),
              onTap: () {
                setState(() {
                  // _showModalBottom();
                  isModalOpen = true;
                });
              }),
        );
        setState(() {
          debugPrint("ESTÁ SEMPRE CHAMANDO O SETSTATE");
        });
      });
    }

    markers.forEach(addMarkers);
  }

  @override
  void initState() {
    _buildMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final location = context.watch<UserLocationController>();
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
                CustomTextFormField(
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    // title: 'Qual o seu destino?',
                    hintText: 'Digite o ponto de partida',
                    icon: CustomSufixIcon(
                      backgroundColor:
                          Theme.of(context).buttonTheme.colorScheme!.secondary,
                      assetName: AppImages.place,
                    )),
                CustomTextFormField(
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    // title: 'Qual o seu destino?',
                    hintText: 'Digite seu destino',
                    icon: CustomSufixIcon(
                      backgroundColor:
                          Theme.of(context).buttonTheme.colorScheme!.secondary,
                      assetName: AppImages.search,
                    )),
                CustomTextFormField(
                    // controller: controller,
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.done,
                    // title: 'Horário de partida:',
                    hintText: '00:00',
                    icon: CustomSufixIcon(
                      backgroundColor:
                          Theme.of(context).buttonTheme.colorScheme!.secondary,
                      assetName: AppImages.time,
                    )),
              ]),
            ),
          ),
          // AnimatedAlign(alignment: Alignment.bottomCenter, duration: duration)
          Expanded(
            child: AnimatedAlign(
              alignment:
                  isModalOpen ? Alignment.topCenter : Alignment.bottomCenter,
              duration: const Duration(milliseconds: 800),
              // padding: EdgeInsets.only(bottom: isModalOpen ? 8 : 0),
              child:
                  Consumer<MapLocationController>(builder: (_, location, __) {
                return GoogleMap(
                  mapToolbarEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  minMaxZoomPreference: const MinMaxZoomPreference(13, 16),
                  initialCameraPosition: CameraPosition(
                      target: LatLng(location.lat, location.lng), zoom: 16),
                  markers: setMarkers,
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
                        CustomElevatedButton(context,
                            onTap: () {},
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
