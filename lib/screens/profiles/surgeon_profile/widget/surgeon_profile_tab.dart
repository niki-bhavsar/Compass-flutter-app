import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/profiles/surgeon_profile/widget/surgeon_profile_events_view.dart';
import 'package:compass_software/screens/profiles/surgeon_profile/widget/surgeon_profile_training_view.dart';
import 'package:flutter/material.dart';

class SurgeonProfileTab extends StatefulWidget {
  const SurgeonProfileTab({super.key});

  @override
  State<SurgeonProfileTab> createState() => _SurgeonProfileTabState();
}

class _SurgeonProfileTabState extends State<SurgeonProfileTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> hospitalProfilesTabs = <Tab>[
      Tab(
        child: Text(
          context.l10n.surgeonProfilesScreen_training_tab,
        ),
      ),
      Tab(
        child: Text(
          context.l10n.surgeonProfilesScreen_events_tab,
        ),
      ),
    ];
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: hospitalProfilesTabs,
          isScrollable: false,
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
              SurgeonProfileTrainingView(),
              SurgeonProfileEventsView(),
            ],
          ),
        ),
      ],
    );
  }
}
