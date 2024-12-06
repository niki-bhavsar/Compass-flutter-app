import 'package:compass_software/extension/build_context_extension.dart';
import 'package:compass_software/screens/login/state/login_state.dart';
import 'package:compass_software/screens/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormView extends StatefulWidget {
  const LoginFormView({super.key});

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
  // Initially password is obscure
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final loginCubic = context.read<LoginCubit>();
    return Form(
      key: loginCubic.formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: context.l10n.loginScreen_emailInput_hint,
              filled: false,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            controller: loginCubic.usernameTextController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: loginCubic.autoValidateMode,
            validator: _emailValidator,
            autofillHints: const [AutofillHints.email],
          ),
          const SizedBox(height: 24),
          TextFormField(
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              labelText: context.l10n.loginScreen_passwordInput_hint,
              filled: false,
            ),
            onFieldSubmitted: (String? value) {
              context.hideKeyboard();
              context.read<LoginCubit>().handleLoginClickEvent();
            },
            style: Theme.of(context).textTheme.bodyMedium,
            obscureText: _obscureText,
            controller: loginCubic.passwordTextController,
            textInputAction: TextInputAction.done,
            autovalidateMode: loginCubic.autoValidateMode,
            validator: _passwordValidator,
          ),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginErrorState) {
                return Column(
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      state.error,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Theme.of(context).colorScheme.error),
                      textAlign: TextAlign.center,
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

  String? _emailValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return context.l10n.loginScreen_emailInput_emptyError;
    }
    return null;
  }

  String? _passwordValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return context.l10n.loginScreen_passwordInput_emptyError;
    }
    return null;
  }
}
