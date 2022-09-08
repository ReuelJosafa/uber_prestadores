import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/scheduled_rides.dart';

class ScheduledRideCard extends StatelessWidget {
  final ScheduledRide scheduledRide;
  const ScheduledRideCard({Key? key, required this.scheduledRide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Nome: ',
                      style: theme.textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.primaryColor),
                      children: [
                        TextSpan(
                          text: scheduledRide.personName,
                          style: theme.textTheme.headline4,
                        ),
                      ],
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 6),
                  Text(scheduledRide.address,
                      maxLines: 2, style: theme.textTheme.bodyText1)
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Text(DateFormat.Hm().format(scheduledRide.dateTime),
                    style: theme.textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.primaryColor)),
                Text(DateFormat('dd/MM').format(scheduledRide.dateTime),
                    style: theme.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF595959),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
