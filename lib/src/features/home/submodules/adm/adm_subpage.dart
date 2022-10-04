import 'package:flutter/material.dart';

import '../../../../shared/components/custom_card_tile_widget.dart';
import '../../../../shared/models/person_driver.dart';
import '../../../../shared/utils/alert_dialog_utils.dart';

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
            name: 'Motorista Lorem Ipsum Dollor $index',
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
            onAcceptTap: () async {
              await AlertDialogUtils.showAlertDialog(context,
                      title: "Deseja aprovar?",
                      contentWidget: Text.rich(
                        TextSpan(
                            text: 'Após aprovar o(a) motorista ',
                            children: [
                              TextSpan(
                                  text: personDriver.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.8))),
                              const TextSpan(text: ' de cadastro '),
                              TextSpan(
                                  text: personDriver.cod.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.8))),
                              const TextSpan(
                                  text:
                                      ', você não poderá desfazer esta alteração pelo aplicativo.'),
                            ]),
                      ),
                      /* contentText:
                          'Após aprovar o(a) motorista ${personDriver.name} de cadastro ${personDriver.cod}, você não poderá desfazer esta alteração pelo aplicativo.', */
                      confirmationButtonText: 'Aprovar',
                      cancelButtonText: 'Cancelar')
                  .then((value) {
                if (value == true) {
                  // Navigator.pop(context);
                }
              });
            },
            onDeclineTap: () async {
              await AlertDialogUtils.showAlertDialog(context,
                      title: "Deseja recusar?",
                      contentWidget: Text.rich(
                        TextSpan(
                            text: 'Após recusar o(a) motorista ',
                            children: [
                              TextSpan(
                                  text: personDriver.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.8))),
                              const TextSpan(text: ' de cadastro '),
                              TextSpan(
                                  text: personDriver.cod.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.8))),
                              const TextSpan(
                                  text:
                                      ', você não poderá desfazer esta alteração pelo aplicativo.'),
                            ]),
                      ),
                      /* contentText:
                          'Após aprovar o(a) motorista ${personDriver.name} de cadastro ${personDriver.cod}, você não poderá desfazer esta alteração pelo aplicativo.', */
                      confirmationButtonText: 'Recusar',
                      cancelButtonText: 'Cancelar')
                  .then((value) {
                if (value == true) {
                  // Navigator.pop(context);
                }
              });
            },
          ),
        );
      },
    );
  }
}
