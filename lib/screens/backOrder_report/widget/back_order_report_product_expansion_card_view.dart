import 'package:compass_software/data/entity/back_order_report_product_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/backOrder_report/widget/back_order_text_span_view.dart';
import 'package:flutter/material.dart';

class BackOrderReportProductExpansionCardView extends StatelessWidget {
  final ProductData productData;

  const BackOrderReportProductExpansionCardView({
    super.key,
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        children: [
          Container(
            height: 16,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          ExpansionTile(
            backgroundColor: Theme.of(context).colorScheme.surface,
            collapsedBackgroundColor: Theme.of(context).colorScheme.surface,
            title: Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                productData.shipPartyName ?? "",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: EdgeInsets.zero,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: Theme.of(context).colorScheme.onPrimary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    BackOrderTextSpanView(
                      title: context.l10n.backOrderReportScreen_product_part_number,
                      value: productData.partNumber ?? "",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BackOrderTextSpanView(
                      title: context.l10n.backOrderReportScreen_product_open_qty,
                      value: productData.openQty ?? "",
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.backOrderReportScreen_product_description,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          productData.partDescription ?? "",
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
