import 'package:compass_software/data/entity/technique_library_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/technique_libraries/technique_library/state/technique_library_state.dart';
import 'package:compass_software/screens/technique_libraries/technique_library/technique_library_cubit.dart';
import 'package:compass_software/screens/technique_libraries/technique_library/widget/search_textfield.dart';
import 'package:compass_software/screens/technique_libraries/technique_library/widget/technique_card.dart';
import 'package:compass_software/screens/technique_libraries/technique_library/widget/technique_library_state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechniqueLibraryScreen extends StatelessWidget {
  const TechniqueLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TechniqueLibraryCubit(
              settingsRepository: context.read(),
            ),
        child: const TechniqueLibraryPage());
  }
}

class TechniqueLibraryPage extends StatelessWidget {
  const TechniqueLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.techniqueLibraryScreen_title),
        centerTitle: false,
      ),
      body: BlocConsumer<TechniqueLibraryCubit, TechniqueLibraryState>(
        listener: (context, state) {
          if (state is TechniqueLibraryErrorState) {}
        },
        builder: (context, state) {
          if (state is TechniqueLibrarySuccessState) {
            return Flex(
              direction: Axis.vertical,
              children: [
                const SizedBox(
                  height: 8.0,
                ),
                SearchTextField(onChanged: (text) {
                  context.read<TechniqueLibraryCubit>().serchTechniqueLibrary(text);
                }),
                const SizedBox(
                  height: 8.0,
                ),
                Flexible(child: TechniqueList(techlibraries: state.techlibraries))
              ],
            );
          }
          return TechniqueLibraryStateView(state: state);
        },
      ),
    );
  }
}

class TechniqueList extends StatelessWidget {
  final List<TechniqueLibraryInfo> techlibraries;
  const TechniqueList({super.key, required this.techlibraries});

  @override
  Widget build(BuildContext context) {
    if (techlibraries.isEmpty) {
      return Center(
        child: Text(
          context.l10n.techniqueLibraryScreen_noData_message,
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: techlibraries.length,
      itemBuilder: (BuildContext context, int index) {
        return TechniqueCard(techniqueLibrary: techlibraries[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }
}
