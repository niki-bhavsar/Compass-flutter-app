import 'package:compass_software/data/entity/state_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../my_profile_bloc.dart';

class MyProfileAddressView extends StatelessWidget {
  const MyProfileAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    String? zipcodeValidator(String? text) {
      if (text!.isNotEmpty && text.length != 5) {
        return context.l10n.myProfileScreen_zip_invalidError;
      }
      return null;
    }

    final bloc = context.read<MyProfileBloc>();
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.myProfileScreen_address_title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bloc.addressController,
              decoration: InputDecoration(
                labelText: context.l10n.myProfileScreen_address_hint,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bloc.cityController,
              decoration: InputDecoration(
                labelText: context.l10n.myProfileScreen_city_hint,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            DropdownSearch<StatesList>(
              popupProps: PopupProps.dialog(
                showSearchBox: true,
                showSelectedItems: false,
                searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: context.l10n.myProfileScreen_searchStates,
                      fillColor: Theme.of(context).colorScheme.onPrimary,
                      prefixIcon: const Icon(Icons.search),
                    ),
                    padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 0.0),
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              items: bloc.statesList,
              autoValidateMode: bloc.autoValidateMode,
              itemAsString: (StatesList st) => st.name,
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: Theme.of(context).textTheme.bodyMedium,
                dropdownSearchDecoration: InputDecoration(
                  labelText: context.l10n.myProfileScreen_state_hint,
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              onChanged: (StatesList? st) async {
                bloc.selectedState = st;
              },
              selectedItem: bloc.selectedState,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bloc.zipController,
              decoration: InputDecoration(
                labelText: context.l10n.myProfileScreen_zip_hint,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: zipcodeValidator,
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
