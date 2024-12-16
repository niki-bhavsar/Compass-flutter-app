import 'package:compass_software/data/entity/favourite_hospital_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../favourite_hospital_bloc.dart';

class FavouriteHospitalCard extends StatelessWidget {
  final HospitalList hospital;

  const FavouriteHospitalCard({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavouriteHospitalBloc>();
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownSearch<HospitalList>(
              popupProps: PopupProps.dialog(
                showSearchBox: true,
                showSelectedItems: false,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    hintText: context.l10n.favouriteHospitalScreen_search_hospital,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                    prefixIcon: const Icon(Icons.search),
                  ),
                  padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0.0),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              items: bloc.getHospitalList(),
              itemAsString: (HospitalList hos) => hos.name ?? "",
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: Theme.of(context).textTheme.bodyMedium,
                dropdownSearchDecoration: InputDecoration(
                  labelText: hospital.name ?? "",
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              onChanged: (HospitalList? hp) async {
                hospital.id = hp?.id;
                hospital.hospitalId = hp?.hospitalId;
                hospital.name = hp?.name;
              },
              selectedItem: hospital,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: context.l10n.favouriteHospitalScreen_nickname,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              initialValue: hospital.nickName,
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                hospital.nickName = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
