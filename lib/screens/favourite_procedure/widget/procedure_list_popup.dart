import 'package:compass_software/data/entity/favourite_procedure_entity.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class ProcedureListPopup extends StatelessWidget {
  final List<Procedure> procedureList;
  final void Function(ProcedureList) procedureSelected;

  const ProcedureListPopup({
    super.key,
    required this.procedureList,
    required this.procedureSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: procedureList.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 72),
      itemBuilder: (BuildContext context, int index) {
        Procedure procedure = procedureList[index];
        List<ProcedureList>? proceDataList = procedure.procedureData;
        return StickyHeader(
          header: Container(
            color: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              procedure.name ?? "",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ),
          content: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: proceDataList?.length,
            itemBuilder: (BuildContext context, int index) {
              ProcedureList? pro = proceDataList?[index];
              return GestureDetector(
                onTap: () {
                  procedureSelected(pro!);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    pro?.procedureName ?? "",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
