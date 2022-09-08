import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uber_prestadores/src/shared/components/custom_back_button_widget.dart';

import '../../shared/components/custom_card_tile_widget.dart';
import '../../shared/constants/app_images.dart';
import '../../shared/models/person_driver.dart';
import 'components/search_header_delegate.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
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
      body: _buildSliver(),
    );
  }

  Widget _buildSliver() {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: SearchHeaderDelegate(_buildSearchWidget()),
          floating: true,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final personDriver = peopleDriver[index];

              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: CustomCardTile(personDriver: personDriver),
              );
            },
            childCount: peopleDriver.length,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 26, 16, 16),
      child: TextField(
        style: Theme.of(context).textTheme.headline5,
        decoration: InputDecoration(
            hintText: 'Pesquisar...',
            suffixIcon:
                SvgPicture.asset(AppImages.search, fit: BoxFit.scaleDown),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: CustomBackButton(context, buttonColor: Colors.white),
      centerTitle: true,
      title: const Text(
        'Busca por usuário',
      ),
    );
  }

 /*  Widget _builSimpleLayout() {
    return Column(
      children: [
        _buildSearchWidget(),
        Expanded(
          child: _buildList(),
        ),
      ],
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
      itemCount: peopleDriver.length,
      itemBuilder: (context, index) {
        final personDriver = peopleDriver[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CustomCardTile(personDriver: personDriver),
        );
      },
    );
  } */
}
