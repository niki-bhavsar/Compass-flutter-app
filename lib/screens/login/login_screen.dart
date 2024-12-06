import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/login/state/login_state.dart';
import 'package:compass_software/screens/login/widget/login_form_view.dart';
import 'package:compass_software/screens/bottom_menu/bottom_menu_screen.dart';
import 'package:compass_software/widget/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_cubit.dart';
import 'widget/distributor_app_logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(
        authRepository: context.read(),
      ),
      child: const _LoginScreen(),
    );
  }
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<LoginCubit, LoginState>(
          listenWhen: (previous, current) {
            return current is LoginSuccessState;
          },
          listener: (context, state) {
            if (state is LoginSuccessState) {
              context.navigate(const BottomMenuScreen());
            }
          },
          builder: (context, state) {
            return ProgressView(
              isLoading: state is LoginLoadingState,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                        maxWidth: 600,
                      ),
                      child: IntrinsicHeight(
                        child: _LoginLayout(),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoginLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const DistributorAppLogo(),
          const SizedBox(height: 30),
          Text(
            context.l10n.loginScreen_title,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 5),
          Text(
            context.l10n.loginScreen_subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.normal,
                ),
          ),
          const SizedBox(height: 24),
          const LoginFormView(),
          const SizedBox(height: 24),
          // const Spacer(),
          // const LoginDisclaimer(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                // AnalyticsEvent.login.logEvent();
                context.hideKeyboard();
                cubit.handleLoginClickEvent();
              },
              child: Text(context.l10n.loginScreen_login_action.toUpperCase()),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
