import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_prestadores/src/shared/components/custom_elevated_button_widget.dart';

import '../../../../shared/components/custom_text_form_field_widget.dart';
import '../../../../shared/constants/app_images.dart';
import '../../../schedule_ride/schedule_ride_page.dart';
import '../../../../shared/components/custom_sufix_icon_widget.dart';

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
              const Text('Bem-vindo, Usuário.',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400)),
              const SizedBox(height: 28),
              CustomTextFormField(
                  controller: controller,
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  title: 'Qual o seu destino?',
                  hintText: 'Digite aqui',
                  icon: CustomSufixIcon(
                    backgroundColor:
                        Theme.of(context).buttonTheme.colorScheme!.secondary,
                    assetName: AppImages.search,
                  )),
              const SizedBox(height: 28),
            ],
          ),
        ),
        Expanded(
            child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              GoogleMap(
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(-22.970225, -43.186071), zoom: 18),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: CustomElevatedButton(context,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScheduleRidePage())),
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
