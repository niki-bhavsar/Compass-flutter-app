import 'package:compass_software/data/repository/favourite_repository.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/favourite_hospital/favourite_hospital_bloc.dart';
import 'package:compass_software/screens/favourite_hospital/widget/favourite_hospital_card.dart';
import 'package:compass_software/screens/favourite_hospital/widget/favourite_hospital_state_view.dart';
import 'package:compass_software/screens/login/login_screen.dart';
import 'package:compass_software/widget/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/favourite_hospital_event.dart';
import 'bloc/favourite_hospital_state.dart';

class FavouriteHospitalScreen extends StatelessWidget {
  const FavouriteHospitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavouriteHospitalBloc(
        favouriteRepository: context.read<FavouriteRepository>(),
      )..add(FavouriteHospitalFetchEvent()),
      child: const _FavouriteHospitalScaffold(),
    );
  }
}

class _FavouriteHospitalScaffold extends StatelessWidget {
  const _FavouriteHospitalScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.favouriteHospitalScreen_title),
        centerTitle: false,
      ),
      body: BlocConsumer<FavouriteHospitalBloc, FavouriteHospitalState>(
        listener: (context, state) {
          if (state is FavouriteHospitalErrorState && state.isAuthError == true) {
            context.navigateAndReplace(const LoginScreen());
          } else if (state is FavouriteHospitalSaveDataSuccessState) {
            context.showSnackBar(state.entity.message);
          }
        },
        builder: (context, state) {
          final bloc = context.read<FavouriteHospitalBloc>();
          if (bloc.hospitalList.isNotEmpty) {
            return ProgressView(
              isLoading: state is FavouriteHospitalLoadingState,
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
                        context.read<FavouriteHospitalBloc>().add(FavouriteHospitalSaveEvent());
                      },
                      child: Text(context.l10n.action_update),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return FavouriteHospitalStateView(
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
    final bloc = context.read<FavouriteHospitalBloc>();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: bloc.favouriteCount,
      itemBuilder: (BuildContext context, int index) {
        return FavouriteHospitalCard(
          hospital: bloc.selectedHospitalList[index],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }
}
