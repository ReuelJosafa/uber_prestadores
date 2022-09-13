import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_prestadores/src/shared/components/custom_elevated_button_widget.dart';
import 'package:uber_prestadores/src/shared/controllers/map_location_controller.dart';

import '../../../../shared/components/custom_sufix_icon_widget.dart';
import '../../../../shared/components/custom_text_form_field_widget.dart';
import '../../../../shared/constants/app_images.dart';
import '../../../../shared/constants/app_routes.dart';

class UserSubpage extends StatefulWidget {
  const UserSubpage({Key? key}) : super(key: key);

  @override
  State<UserSubpage> createState() => _UserSubpageState();
}

class _UserSubpageState extends State<UserSubpage> {
  final controller = TextEditingController();

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
              CustomTextFormField(
                  controller: controller,
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  hintText: 'Digite seu destino',
                  icon: CustomSufixIcon(
                    backgroundColor:
                        Theme.of(context).buttonTheme.colorScheme!.secondary,
                    assetName: AppImages.search,
                  )),
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
                return GoogleMap(
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  minMaxZoomPreference: const MinMaxZoomPreference(13, 16),
                  onMapCreated: location.onMapCreated,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(location.lat, location.lng), zoom: 16),
                );
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: CustomElevatedButton(context,
                      onTap: () => Navigator.of(context)
                          .pushNamed(AppRoutes.scheduleRideConfirmation),
                      title: 'Agendar corrida',
                      icon: SvgPicture.asset(AppImages.calendar),
                      color:
                          Theme.of(context).buttonTheme.colorScheme!.secondary),
                ),
              )
            ],
          ),
        ))
      ],
    );
  }
}
