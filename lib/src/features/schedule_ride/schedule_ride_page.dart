import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../shared/components/custom_back_button_widget.dart';
import '../../shared/components/custom_elevated_button_widget.dart';
import '../../shared/components/custom_text_form_field_widget.dart';
import '../../shared/constants/app_images.dart';
import '../../shared/components/custom_sufix_icon_widget.dart';
import '../schedule_ride_confirmation/schedule_ride_confirmation_page.dart';

class ScheduleRidePage extends StatefulWidget {
  const ScheduleRidePage({Key? key}) : super(key: key);

  @override
  State<ScheduleRidePage> createState() => _ScheduleRidePageState();
}

class _ScheduleRidePageState extends State<ScheduleRidePage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: Column(
          children: [
            CustomTextFormField(
                controller: controller,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                title: 'Ponto de partida',
                hintText: 'Digite aqui',
                icon: CustomSufixIcon(
                  backgroundColor:
                      Theme.of(context).buttonTheme.colorScheme!.secondary,
                  assetName: AppImages.place,
                )),
            const SizedBox(height: 20),
            CustomTextFormField(
                // controller: controller,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                title: 'Qual o seu destino?',
                hintText: 'Digite aqui',
                icon: CustomSufixIcon(
                  backgroundColor:
                      Theme.of(context).buttonTheme.colorScheme!.secondary,
                  assetName: AppImages.search,
                )),
            const SizedBox(height: 20),
            CustomTextFormField(
                // controller: controller,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.done,
                title: 'Horário de partida:',
                hintText: '00:00',
                icon: CustomSufixIcon(
                  backgroundColor:
                      Theme.of(context).buttonTheme.colorScheme!.secondary,
                  assetName: AppImages.time,
                )),
            const SizedBox(height: 8),
            Expanded(
                child: Image.asset(AppImages.location, fit: BoxFit.fitHeight)),
            const SizedBox(height: 16),
            CustomElevatedButton(context, onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) =>
                          const ScheduleRideConfirmationPage()));
            },
                title: 'Agendar corrida',
                icon: SvgPicture.asset(AppImages.calendar),
                color: Theme.of(context).buttonTheme.colorScheme!.secondary),
            // const SizedBox(height: 50),
          ],
        ),
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
}
