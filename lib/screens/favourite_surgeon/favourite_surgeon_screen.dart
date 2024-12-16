import 'package:compass_software/data/repository/favourite_repository.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/favourite_surgeon/bloc/favourite_surgeon_state.dart';
import 'package:compass_software/screens/favourite_surgeon/favourite_surgeon_bloc.dart';
import 'package:compass_software/screens/favourite_surgeon/widget/favourite_surgeon_card.dart';
import 'package:compass_software/screens/favourite_surgeon/widget/favourite_surgeon_state_view.dart';
import 'package:compass_software/screens/login/login_screen.dart';
import 'package:compass_software/widget/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/favourite_surgeon_event.dart';

class FavouriteSurgeonScreen extends StatelessWidget {
  const FavouriteSurgeonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavouriteSurgeonBloc(
        favouriteRepository: context.read<FavouriteRepository>(),
      )..add(FavouriteSurgeonFetchEvent()),
      child: const _FavouriteSurgeonScaffold(),
    );
  }
}

class _FavouriteSurgeonScaffold extends StatelessWidget {
  const _FavouriteSurgeonScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.favouriteSurgeonScreen_title),
        centerTitle: false,
      ),
      body: BlocConsumer<FavouriteSurgeonBloc, FavouriteSurgeonState>(
        listener: (context, state) {
          if (state is FavouriteSurgeonErrorState && state.isAuthError == true) {
            context.navigateAndReplace(const LoginScreen());
          } else if (state is FavouriteSurgeonSaveDataSuccessState) {
            context.showSnackBar(state.entity.message);
          }
        },
        builder: (context, state) {
          final bloc = context.read<FavouriteSurgeonBloc>();
          if (bloc.surgeonsList.isNotEmpty) {
            return ProgressView(
              isLoading: state is FavouriteSurgeonLoadingState,
              child: Column(
                children: [
                  const Expanded(
                    child: FavouriteSurgeonListView(),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: FilledButton(
                      onPressed: () {
                        context.read<FavouriteSurgeonBloc>().add(FavouriteSurgeonSaveEvent());
                      },
                      child: Text(context.l10n.action_update),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return FavouriteSurgeonStatView(
              state: state,
            );
          }
        },
      ),
    );
  }
}

class FavouriteSurgeonListView extends StatelessWidget {
  const FavouriteSurgeonListView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavouriteSurgeonBloc>();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: bloc.favouriteCount,
      itemBuilder: (BuildContext context, int index) {
        return FavouriteSurgeonCard(
          surgeon: bloc.selectedSurgeonList[index],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }
}
