import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/distributor_code/bloc/distributor_code_state.dart';
import 'package:compass_software/screens/distributor_code/widget/distributor_code_form_view.dart';
import 'package:compass_software/screens/loginTest/login_test.dart';
import 'package:compass_software/widget/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/app_logo.dart';
import 'bloc/distributor_code_event.dart';
import 'distributor_code_bloc.dart';

class DistributorCodeScreen extends StatelessWidget {
  const DistributorCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DistributorCodeBloc(
        authRepository: context.read(),
      ),
      child: const _DistributorCodeView(),
    );
  }
}

class _DistributorCodeView extends StatelessWidget {
  const _DistributorCodeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
              child: BlocConsumer<DistributorCodeBloc, DistributorCodeState>(
                listener: (BuildContext context, DistributorCodeState state) {
                  if (state is DistributorCodeSuccessState) {
                    context.navigate(const LoginTestPage());
                  }
                  },
                builder: (BuildContext context, DistributorCodeState state) {
                  return ProgressView(
                      isLoading: state is DistributorCodeLoadingState,
                      child: IntrinsicHeight(
                        child: _DistributorCodeLayout(),
                      )
                  );
                  },
              )
          )
      ),
    );
  }
}

class _DistributorCodeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          const AppLogo(),
          const SizedBox(height: 30),
          Text(
            context.l10n.distributorCodeScreen_codeInput_title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          const DistributorCodeFormView(),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                context.hideKeyboard();
                context.read<DistributorCodeBloc>().add(DistributorCodeSubmitClickEvent());
              },
              child: Text(context.l10n.action_next.toUpperCase()),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
