import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

class HospitalProfilesTab extends StatefulWidget {
  const HospitalProfilesTab({super.key});

  @override
  State<HospitalProfilesTab> createState() => _HospitalProfilesTabState();
}

class _HospitalProfilesTabState extends State<HospitalProfilesTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> hospitalProfilesTabs = <Tab>[
      Tab(
        child: Text(
          context.l10n.hospitalProfilesScreen_general_tab,
        ),
      ),
      Tab(
        child: Text(
          context.l10n.hospitalProfilesScreen_notes,
        ),
      ),
      Tab(
        child: Text(
          context.l10n.hospitalProfilesScreen_contact_info_tab,
        ),
      ),
      Tab(
        child: Text(
          context.l10n.hospitalProfilesScreen_associated_surgeons_tab,
        ),
      ),
    ];
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: hospitalProfilesTabs,
          isScrollable: true,
          labelColor: Theme.of(context).colorScheme.primary,
          labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
          unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              // HospitalProfileGeneralView(),
              // HospitalProfileNotesView(),
              Placeholder(),
              Placeholder(),
            ],
          ),
        ),
      ],
    );
  }
}
