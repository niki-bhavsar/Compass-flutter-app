import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/distributor_code/distributor_code_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/distributor_code_state.dart';

class DistributorCodeFormView extends StatefulWidget {
  const DistributorCodeFormView({super.key});

  @override
  State<DistributorCodeFormView> createState() => _DistributorCodeFormViewState();
}

class _DistributorCodeFormViewState extends State<DistributorCodeFormView> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DistributorCodeBloc>();
    return Form(
      key: bloc.formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: context.l10n.distributorCodeScreen_codeInput_hint,
              filled: false,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            controller: bloc.codeTextController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            autovalidateMode: bloc.autoValidateMode,
            validator: _distributorCodeValidator,
          ),
          const SizedBox(height: 16),
          BlocBuilder<DistributorCodeBloc, DistributorCodeState>(
            builder: (context, state) {
              if (state is DistributorCodeErrorState) {
                return Column(
                  children: [
                   const SizedBox(height: 16),
                    Text(
                      state.error,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Theme.of(context).colorScheme.error),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }

  String? _distributorCodeValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return context.l10n.distributorCodeScreen_codeInput_emptyError;
    }
    return null;
  }
}
