import 'package:compass_software/data/entity/template_kits_detail_entiry.dart';
import 'package:compass_software/screens/login/login_screen.dart';
import 'package:compass_software/screens/manage_templates/kits_detail/kits_detail_cubit.dart';
import 'package:compass_software/screens/manage_templates/kits_detail/state/kits_detail_state.dart';
import 'package:compass_software/screens/manage_templates/kits_detail/widget/kit_image.dart';
import 'package:compass_software/widget/progress.dart';
import 'package:compass_software/widget/state_view.dart';
import 'package:flutter/material.dart';

import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KitsDetailScreen extends StatelessWidget {
  final String kitId;
  const KitsDetailScreen({super.key, required this.kitId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => KitsDetailCubit(kitId, settingsRepository: context.read()),
        child: KitsDetailPage(kitId: kitId));
  }
}

class KitsDetailPage extends StatelessWidget {
  final String kitId;
  const KitsDetailPage({super.key, required this.kitId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.template_kit_detail_title),
        centerTitle: false,
      ),
      body: BlocConsumer<KitsDetailCubit, KitsDetailState>(
        listener: (context, state) {
          if (state is KitsDetailErrorState && state.isAuthError) {
            context.navigateAndReplace(const LoginScreen());
          }
        },
        builder: (context, state) {
          if (state is KitsDetailSuccessState) {
            return Flex(
              direction: Axis.vertical,
              children: [
                const SizedBox(
                  height: 8.0,
                ),
                KitImage(kitDetails: state.kitsDetail.values),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Inventory List",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryFixed,
                          ),
                    ),
                  ),
                ),
                const Divider(),
                Flexible(child: InventoryItemsList(kitDetails: state.kitsDetail.values)),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          } else if (state is KitsDetailErrorState) {
            return StateView(
              title: context.l10n.stateView_message,
              message: state.error,
              action: context.l10n.tryAgain_button_title,
              onAction: () {
                context.read<KitsDetailCubit>().fetchKitsDetail(kitId);
              },
            );
          }
          return ProgressView(
            isLoading: state is KitsDetailLoadingState,
            child: const SizedBox(),
          );
        },
      ),
    );
  }
}

class InventoryItemsList extends StatelessWidget {
  final KitsDetail? kitDetails;
  const InventoryItemsList({
    super.key,
    required this.kitDetails,
  });

  @override
  Widget build(BuildContext context) {
    final inventoryList = kitDetails?.inventoryItems ?? [];
    if (inventoryList.isEmpty) {
      return Center(
        child: Text(
          context.l10n.createEditTemplate_implant_noData_message,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: inventoryList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            dense: true, // Makes the ListTile more compact
            // visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("QTY: ${inventoryList[index].quantity}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                Text("# ${inventoryList[index].number}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
              ],
            ),
            subtitle: Text(inventoryList[index].description?.toString() ?? ""),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1, // Adjust separator height if needed
            thickness: 1,
          );
        },
      ),
    );
  }
}
