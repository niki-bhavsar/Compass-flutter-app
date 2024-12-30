import 'package:compass_software/data/entity/back_order_report_product_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/backOrder_report/widget/back_order_report_product_expansion_card_view.dart';
import 'package:flutter/material.dart';

import 'back_order_leading_view.dart';

class BackorderReportProductCardView extends StatelessWidget {
  final ProductData productData;
  final Product product;

  const BackorderReportProductCardView({
    super.key,
    required this.productData,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).colorScheme.surface,
      child: ExpansionTile(
        visualDensity: const VisualDensity(vertical: 1),
        title: Text(
          productData.partNumber ?? "",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          productData.partDescription ?? "",
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w300,
              ),
        ),
        leading: BackOrderLeadingView(
          title: context.l10n.backOrderReportScreen_product_total_qty,
          value: product.totalQty ?? "",
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackOrderReportProductExpansionCardView(
            productData: productData,
          ),
        ],
      ),
    );
  }
}
