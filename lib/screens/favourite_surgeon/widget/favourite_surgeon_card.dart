import 'package:compass_software/extension/build_context_extension.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/entity/favourite_surgeon_entity.dart';
import '../favourite_surgeon_bloc.dart';

class FavouriteSurgeonCard extends StatelessWidget {
  final SurgeonList surgeon;

  const FavouriteSurgeonCard({
    super.key,
    required this.surgeon,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavouriteSurgeonBloc>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownSearch<SurgeonList>(
              popupProps: PopupProps.dialog(
                showSearchBox: true,
                showSelectedItems: false,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    hintText: context.l10n.favouriteSurgeonScreen_search_surgeon,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    prefixIcon: const Icon(Icons.search),
                  ),
                  padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0.0),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              items: bloc.getSurgeonsList(),
              itemAsString: (SurgeonList st) => st.surgeonName(),
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: Theme.of(context).textTheme.bodyMedium,
                dropdownSearchDecoration: InputDecoration(
                  labelText: surgeon.surgeonName(),
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              onChanged: (SurgeonList? st) async {
                surgeon.id = st?.id;
                surgeon.surgeonId = st?.surgeonId;
                surgeon.firstName = st?.firstName;
                surgeon.lastName = st?.lastName;
              },
              selectedItem: surgeon,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: context.l10n.favouriteSurgeonScreen_nickname,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              initialValue: surgeon.nickName ?? "",
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                surgeon.nickName = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
