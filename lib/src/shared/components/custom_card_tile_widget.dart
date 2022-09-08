import 'package:flutter/material.dart';

import '../models/person_driver.dart';

class CustomCardTile extends StatelessWidget {
  final PersonDriver personDriver;
  final void Function()? onAcceptTap;
  final void Function()? onDeclineTap;
  const CustomCardTile(
      {Key? key,
      required this.personDriver,
      this.onAcceptTap,
      this.onDeclineTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0.5,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cadastro  #${personDriver.cod}',
                    maxLines: 2,
                    style: theme.textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.primaryColor)),
                const SizedBox(height: 6),
                _buildRichText(
                  theme: theme,
                  title: 'Nome: ',
                  text: personDriver.name,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: _buildRichText(
                        theme: theme,
                        title: 'CPF: ',
                        text: personDriver.cpf,
                      ),
                    ),
                    Expanded(
                      child: _buildRichText(
                        theme: theme,
                        title: 'CNH: ',
                        text: personDriver.cnh,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (onAcceptTap != null && onDeclineTap != null)
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: onAcceptTap,
                  child: Container(
                    color: const Color(0xFF41F95E),
                    height: 48,
                    width: double.maxFinite,
                    child: Center(
                        child: Text('Aprovar',
                            style: theme.textTheme.headline4!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white))),
                  ),
                )),
                Expanded(
                    child: InkWell(
                  onTap: onDeclineTap,
                  child: Container(
                    color: const Color(0xFFF94141),
                    height: 48,
                    width: double.maxFinite,
                    child: Center(
                        child: Text('Recusar',
                            style: theme.textTheme.headline4!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white))),
                  ),
                )),
              ],
            )
        ],
      ),
    );
  }

  Widget _buildRichText(
      {required ThemeData theme, required String title, required String text}) {
    return Text.rich(
      TextSpan(
        text: title,
        style: theme.textTheme.headline4!
            .copyWith(fontWeight: FontWeight.w600, color: theme.primaryColor),
        children: [
          TextSpan(
            text: text,
            style: theme.textTheme.headline4,
          ),
        ],
      ),
      maxLines: 2,
    );
  }
}
