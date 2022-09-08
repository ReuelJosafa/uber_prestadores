import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared/components/custom_elevated_button_widget.dart';
import '../../shared/components/custom_text_form_field_widget.dart';
import '../../shared/constants/app_images.dart';
import '../../shared/components/custom_sufix_icon_widget.dart';
import 'components/expansion_section.dart';

class ScheduleRideConfirmationPage extends StatefulWidget {
  const ScheduleRideConfirmationPage({Key? key}) : super(key: key);

  @override
  State<ScheduleRideConfirmationPage> createState() =>
      _ScheduleRideConfirmationPageState();
}

class _ScheduleRideConfirmationPageState
    extends State<ScheduleRideConfirmationPage> {
  final markers = ['car1'];
  bool isModalOpen = false;

  Set<Marker> _buildMarkers() {
    final Set<Marker> setMarkers = {};

    addMarkers(String element) async {
      setMarkers.add(
        Marker(
            markerId: MarkerId(element),
            position: LatLng(-22.970225, -43.186071),
            icon: await BitmapDescriptor.fromAssetImage(
                ImageConfiguration.empty, AppImages.smallCar),
            onTap: () {
              setState(() {
                _showModalBottom();
                isModalOpen = true;
              });
            }),
      );
      setState(() {});
    }

    markers.forEach(addMarkers);

    return setMarkers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: isModalOpen ? 220 : 0),
            child: GoogleMap(
              mapToolbarEnabled: false,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target: LatLng(-22.970225, -43.186071), zoom: 18),
              markers: _buildMarkers(),
            ),
          ),
          ExpandedSection(
            expand: !isModalOpen,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 8),
              child: CustomTextFormField(
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  title: 'Qual o seu destino?',
                  hintText: 'Digite aqui',
                  icon: CustomSufixIcon(
                    backgroundColor:
                        Theme.of(context).buttonTheme.colorScheme!.secondary,
                    assetName: AppImages.search,
                  )),
            ),
          )
        ],
      ),
    );
  }

  void _showModalBottom() {
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
  }

  Container _buildCustomDivider() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      height: 2,
      width: 44,
    );
  }
}
