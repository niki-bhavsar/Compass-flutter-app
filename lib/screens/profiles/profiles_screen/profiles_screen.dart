import 'package:compass_software/data/repository/profiles_repository.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/profiles_screen/profiles_bloc.dart';
import 'package:compass_software/screens/profiles/profiles_screen/widget/hospital_card.dart';
import 'package:compass_software/screens/profiles/profiles_screen/widget/profiles_state_view.dart';
import 'package:compass_software/screens/profiles/profiles_screen/widget/surgeon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../login/login_screen.dart';
import 'bloc/profiles_event.dart';
import 'bloc/profiles_state.dart';

class ProfilesScreen extends StatelessWidget {
  const ProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfilesBloc(
        profilesRepository: context.read<ProfilesRepository>(),
      )..add(HospitalsListFetchEvent()),
      child: const _ProfilesTab(),
    );
  }
}

class _ProfilesTab extends StatefulWidget {
  const _ProfilesTab();

  @override
  State<_ProfilesTab> createState() => _ProfilesTabState();
}

class _ProfilesTabState extends State<_ProfilesTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> profilesTabs = <Tab>[
      Tab(
        child: Text(
          context.l10n.profilesScreen_hospital_title,
        ),
      ),
      Tab(
        child: Text(
          context.l10n.profilesScreen_surgeons_title,
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(context.l10n.profilesScreen_title),
        centerTitle: false,
      ),
      body: BlocConsumer<ProfilesBloc, ProfilesState>(
        listener: (context, state) {
          if (state is ProfilesErrorState && state.isAuthError == true) {
            context.navigateAndReplace(const LoginScreen());
          } else if (state is ProfileFetchHospitalListState) {
            context.read<ProfilesBloc>().add(SurgeonsListFetchEvent());
          }
        },
        builder: (context, state) {
          final bloc = context.read<ProfilesBloc>();
          if (state is ProfileFetchSurgeonListState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: profilesTabs,
                    labelColor: Theme.of(context).colorScheme.primary,
                    labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        if (bloc.hospitalList.isNotEmpty) _HospitalList(),
                        if (bloc.hospitalList.isEmpty)
                          ProfilesStateView(
                            state: state,
                            isHospitalData: true,
                          ),
                        if (bloc.surgeonList.isNotEmpty) _SurgeonList(),
                        if (bloc.surgeonList.isEmpty)
                          ProfilesStateView(
                            state: state,
                            isHospitalData: false,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ProfilesStateView(
              state: state,
              isHospitalData: _tabController.index == 0 ? true : false,
            );
          }
        },
      ),
    );
  }
}

class _HospitalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfilesBloc>();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      itemCount: bloc.hospitalList.length,
      itemBuilder: (BuildContext context, int index) {
        return HospitalCard(
          hospital: bloc.hospitalList[index],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 1);
      },
    );
  }
}

class _SurgeonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfilesBloc>();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      itemCount: bloc.surgeonList.length,
      itemBuilder: (BuildContext context, int index) {
        return SurgeonCard(
          surgeon: bloc.surgeonList[index],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 1);
      },
    );
  }
}
