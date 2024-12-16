import 'package:compass_software/data/repository/favourite_repository.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/favourite_procedure/favourite_procedure_bloc.dart';
import 'package:compass_software/screens/favourite_procedure/widget/favourite_procedure_card.dart';
import 'package:compass_software/screens/favourite_procedure/widget/favourite_procedure_state_view.dart';
import 'package:compass_software/screens/login/login_screen.dart';
import 'package:compass_software/widget/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/favourite_procedure_event.dart';
import 'bloc/favourite_procedure_state.dart';

class FavouriteProcedureScreen extends StatelessWidget {
  const FavouriteProcedureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavouriteProcedureBloc(
        favouriteRepository: context.read<FavouriteRepository>(),
      )..add(FavouriteProcedureFetchEvent()),
      child: const _FavouriteProcedureScaffold(),
    );
  }
}

class _FavouriteProcedureScaffold extends StatelessWidget {
  const _FavouriteProcedureScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.favouriteProcedureScreen_title),
        centerTitle: false,
      ),
      body: BlocConsumer<FavouriteProcedureBloc, FavouriteProcedureState>(
        listener: (context, state) {
          if (state is FavouriteProcedureErrorState && state.isAuthError == true) {
            context.navigateAndReplace(const LoginScreen());
          } else if (state is FavouriteProcedureSaveDataSuccessState) {
            context.showSnackBar(state.entity.message);
          }
        },
        builder: (context, state) {
          final bloc = context.read<FavouriteProcedureBloc>();
          if (bloc.procedureList.isNotEmpty) {
            return ProgressView(
              isLoading: state is FavouriteProcedureLoadingState,
              child: Column(
                children: [
                  const Expanded(
                    child: FavouriteHospitalListView(),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: FilledButton(
                      onPressed: () {
                        context.read<FavouriteProcedureBloc>().add(FavouriteProcedureSaveEvent());
                      },
                      child: Text(context.l10n.action_update),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return FavouriteProcedureStateView(
              state: state,
            );
          }
        },
      ),
    );
  }
}

class FavouriteHospitalListView extends StatelessWidget {
  const FavouriteHospitalListView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavouriteProcedureBloc>();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: bloc.favouriteCount,
      itemBuilder: (BuildContext context, int index) {
        return FavouriteProcedureCard(
          favouriteProcedure: bloc.selectedProcedureList[index],
          procedureList: bloc.procedureList,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }
}
