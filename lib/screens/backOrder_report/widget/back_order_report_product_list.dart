import 'package:compass_software/data/entity/back_order_report_product_entity.dart';
import 'package:compass_software/screens/backOrder_report/widget/back_order_report_product_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import '../back_order_report_bloc.dart';

class BackOrderReportProductList extends StatelessWidget {
  const BackOrderReportProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<BackorderReportBloc>();
    return ListView.separated(
        itemCount: bloc.backOrderProducts.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Product product = bloc.backOrderProducts[index];
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
                      product.partNumber ?? "",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: product.productData!.length,
                        itemBuilder: (BuildContext context, int index) {
                          ProductData productData = product.productData![index];
                          return BackorderReportProductCardView(
                            productData: productData,
                            product: product,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 8);
                        }),
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
