import 'package:compass_software/data/entity/favourite_procedure_entity.dart';
import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/favourite_procedure/widget/procedure_list_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../favourite_procedure_bloc.dart';

class FavouriteProcedureCard extends StatefulWidget {
  final ProcedureList favouriteProcedure;
  final List<Procedure> procedureList;
  const FavouriteProcedureCard({
    super.key,
    required this.favouriteProcedure,
    required this.procedureList,
  });

  @override
  State<FavouriteProcedureCard> createState() => _FavouriteProcedureCardState();
}

class _FavouriteProcedureCardState extends State<FavouriteProcedureCard> {
  @override
  Widget build(BuildContext context) {
    TextEditingController procedureNameController = TextEditingController();
    procedureNameController.text = widget.favouriteProcedure.procedureName!;

    final bloc = context.read<FavouriteProcedureBloc>();
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: procedureNameController,
              decoration: InputDecoration(
                labelText: context.l10n.favouriteProcedureScreen_procedure_name,
                fillColor: Theme.of(context).colorScheme.onPrimary,
                suffixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 22,
                  ),
                ),
              ),
              // initialValue: widget.favouriteProcedure.procedureName,
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Text(context.l10n.favouriteProcedureScreen_select_procedure),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: Theme.of(context).colorScheme.error,
                                ))
                          ],
                        ),
                        content: setupProcedureListPopup(bloc.procedureList, context),
                      );
                    });
              },
              readOnly: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: context.l10n.favouriteProcedureScreen_nickname,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
              initialValue: widget.favouriteProcedure.nickName,
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                widget.favouriteProcedure.nickName = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget setupProcedureListPopup(List<Procedure> procedure, BuildContext context) {
    return SizedBox(
      height: 450.0,
      width: 350.0,
      child: ProcedureListPopup(
        procedureList: procedure,
        procedureSelected: (procedure) {
          Navigator.pop(context);
          setState(() {
            widget.favouriteProcedure.id = procedure.id;
            widget.favouriteProcedure.procedureId = procedure.procedureId;
            widget.favouriteProcedure.procedureName = procedure.procedureName;
            widget.favouriteProcedure.header = procedure.header;
          });
        },
      ),
    );
  }
}
