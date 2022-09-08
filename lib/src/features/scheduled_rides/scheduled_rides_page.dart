import 'package:flutter/material.dart';

import '../../shared/components/custom_back_button_widget.dart';
import 'components/scheduled_ride_card_widget.dart';
import 'models/scheduled_rides.dart';

class ScheduledRidesPage extends StatefulWidget {
  const ScheduledRidesPage({Key? key}) : super(key: key);

  @override
  State<ScheduledRidesPage> createState() => _ScheduledRidesPageState();
}

class _ScheduledRidesPageState extends State<ScheduledRidesPage> {
  final scheduledRides = List.generate(
      20,
      (index) => ScheduledRide(
          personName: 'Nome:Lorem Ipsum Monteiro Dollor $index',
          address: 'Centro - Rio de Janeiro, RJ',
          dateTime: DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 26, 16, 0),
        itemCount: scheduledRides.length,
        itemBuilder: (context, index) {
          final scheduledRide = scheduledRides[index];

          return ScheduledRideCard(scheduledRide: scheduledRide);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: CustomBackButton(context, buttonColor: Colors.white),
      centerTitle: true,
      title: const Text(
        'Corridas agendadas',
      ),
    );
  }
}
