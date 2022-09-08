import 'package:flutter/material.dart';

import '../../../../shared/components/custom_card_tile_widget.dart';
import '../../../../shared/models/person_driver.dart';

class AdmSubpage extends StatefulWidget {
  const AdmSubpage({Key? key}) : super(key: key);

  @override
  State<AdmSubpage> createState() => _AdmSubpageState();
}

class _AdmSubpageState extends State<AdmSubpage> {
  final peopleDriver = List.generate(
      20,
      (index) => PersonDriver(
            cod: index + 1 * 1000,
            name: 'Nome: Motorista Lorem Ipsum Dollor $index',
            cpf: '***.***.***-**',
            cnh: '***********',
          ));
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 26, 16, 0),
      itemCount: peopleDriver.length,
      itemBuilder: (context, index) {
        final personDriver = peopleDriver[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CustomCardTile(
            personDriver: personDriver,
            onAcceptTap: () {},
            onDeclineTap: () {},
          ),
        );
      },
    );
  }
}
