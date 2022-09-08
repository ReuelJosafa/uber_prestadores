import 'package:flutter/material.dart';
import 'package:uber_prestadores/src/shared/components/custom_back_button_widget.dart';

import '../../shared/components/custom_card_tile_widget.dart';
import '../../shared/models/person_driver.dart';

class ApprovalsHistoryPage extends StatefulWidget {
  const ApprovalsHistoryPage({Key? key}) : super(key: key);

  @override
  State<ApprovalsHistoryPage> createState() => _ApprovalsHistoryPageState();
}

class _ApprovalsHistoryPageState extends State<ApprovalsHistoryPage> {
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
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 26, 16, 0),
        itemCount: peopleDriver.length,
        itemBuilder: (context, index) {
          final personDriver = peopleDriver[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CustomCardTile(personDriver: personDriver),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: CustomBackButton(context, buttonColor: Colors.white),
      centerTitle: true,
      title: const Text(
        'Histórico de aprovações',
      ),
    );
  }
}
