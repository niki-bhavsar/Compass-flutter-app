import 'package:compass_software/data/entity/back_order_report_location_entity.dart';
import 'package:compass_software/screens/backOrder_report/widget/back_order_report_location_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../back_order_report_bloc.dart';

class BackOrderReportLocationList extends StatelessWidget {
  const BackOrderReportLocationList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<BackorderReportBloc>();
    return ListView.separated(
        itemCount: bloc.backOrderLocations.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Location location = bloc.backOrderLocations[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: StickyHeader(
                  header: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      location.location ?? "",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                  content: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    physics: const ClampingScrollPhysics(),
                    itemCount: location.locationData?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return BackorderReportLocationCardView(
                        locationData: location.locationData![index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        });
  }
}
