import 'package:compass_software/data/entity/surgeon_detail_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/surgeon_profile/widget/surgeon_profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/image_view.dart';
import '../../notes/notes_screen.dart';
import '../surgeon_profile_bloc.dart';

class SurgeonProfileView extends StatelessWidget {
  const SurgeonProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SurgeonProfileBloc>();
    final SurgeonDetail? surgeonDetail = bloc.surgeonDetail;
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
                imageUrl: surgeonDetail?.photo,
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
            surgeonDetail?.fullName() ?? "",
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
            "HCPID #: ${surgeonDetail?.hcpid}",
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
            surgeonDetail!.cellNumber ?? "",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
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
                  context.l10n.surgeonProfilesScreen_sales,
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
                  context.navigate(NotesScreen(id: surgeonDetail.id ?? "", isSurgeon: true));
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(8),
                  ),
                ),
                child: Text(
                  context.l10n.surgeonProfilesScreen_notes,
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
        const Expanded(
          child: SurgeonProfileTab(),
        ),
      ],
    );
  }
}
