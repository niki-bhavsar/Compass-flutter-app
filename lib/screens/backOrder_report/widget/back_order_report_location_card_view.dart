import 'package:compass_software/data/entity/back_order_report_location_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/backOrder_report/widget/back_order_text_span_view.dart';
import 'package:compass_software/utils/intl_utils.dart';
import 'package:flutter/material.dart';

import 'back_order_leading_view.dart';

class BackorderReportLocationCardView extends StatelessWidget {
  final LocationData locationData;
  const BackorderReportLocationCardView({
    super.key,
    required this.locationData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).colorScheme.surface,
      child: ExpansionTile(
        visualDensity: const VisualDensity(vertical: 1),
        title: Text(
          locationData.partNumber ?? "",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          locationData.partDescription ?? "",
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w300,
              ),
        ),
        leading: BackOrderLeadingView(
          title: context.l10n.backOrderReportScreen_location_qty,
          value: locationData.openQty ?? "",
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackOrderTextSpanView(
                  title: context.l10n.backOrderReportScreen_location_notes,
                  value: locationData.puOrderNo,
                ),
                const SizedBox(height: 8),
                BackOrderTextSpanView(
                  title: context.l10n.backOrderReportScreen_location_date_ordered,
                  value: IntlUtil.getOnCreateDate(locationData.orderCreationDate),
                ),
                const SizedBox(height: 8),
                BackOrderTextSpanView(
                  title: context.l10n.backOrderReportScreen_location_order_number,
                  value: locationData.slsOrder,
                ),
                const SizedBox(height: 8),
                BackOrderTextSpanView(
                  title: context.l10n.backOrderReportScreen_location_days_on_backOrder,
                  value: locationData.daysOnBackorder,
                ),
                const SizedBox(height: 16),
              ],
            ),
          )
        ],
      ),
    );
  }
}
