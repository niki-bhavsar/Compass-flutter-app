import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/hospital_contacts/hospital_contacts_screen.dart';
import 'package:compass_software/screens/profiles/notes/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/entity/hospital_detail_entity.dart';
import '../../../../utils/image_view.dart';
import '../hospital_profile_bloc.dart';

class HospitalProfileView extends StatelessWidget {
  const HospitalProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HospitalProfileBloc>();
    final HospitalDetail? hospitalDetail = bloc.hospitalDetail;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 240,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.red,
              child: ImageView(
                defaultImage: 'https://farm7.staticflickr.com/6089/6115759179_86316c08ff_z_d.jpg',
                imageUrl: hospitalDetail?.photo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.mode_edit_outline_outlined,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            hospitalDetail?.name ?? "",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "Acc #: ${hospitalDetail?.accountNumber}",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.scrim,
                ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            hospitalDetail!.fullAddress() ?? "",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            hospitalDetail.phone ?? "",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 8,
              ),
              FilledButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(8),
                  ),
                ),
                child: Text(
                  context.l10n.hospitalProfilesScreen_sales,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              FilledButton(
                onPressed: () {
                  context.navigate(HospitalContactsScreen(
                    hospitalId: hospitalDetail.id ?? "",
                  ));
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(8),
                  ),
                ),
                child: Text(
                  context.l10n.hospitalProfilesScreen_hospital_contact,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              FilledButton(
                onPressed: () {
                  context.navigate(NotesScreen(id: hospitalDetail.id ?? "", isSurgeon: false));
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(8),
                  ),
                ),
                child: Text(
                  context.l10n.hospitalProfilesScreen_notes,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            ],
          ),
        ),
        //TODO:We need Apis for Implement the tabs
        // const Expanded(
        //   child: HospitalProfilesTab(),
        // ),
      ],
    );
  }
}
