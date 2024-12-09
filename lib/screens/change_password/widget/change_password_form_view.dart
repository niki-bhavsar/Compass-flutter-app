import 'package:compass_software/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/keyboard_util.dart';
import '../../../utils/text_util.dart';
import '../bloc/change_password_event.dart';
import '../change_password_bloc.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  bool _currentPasswordObscureText = true;
  bool _newPasswordObscureText = true;
  bool _confirmPasswordObscureText = true;

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ChangePasswordBloc>();
    return Form(
      key: bloc.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  controller: bloc.currentPasswordController,
                  decoration: InputDecoration(
                    labelText: context.l10n.changePasswordScreen_currentPassword,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(Icons.lock_outline),
                    ),
                    suffixIcon: _suffixIcon(
                      obscureText: _currentPasswordObscureText,
                      onPressed: () {
                        setState(() {
                          _currentPasswordObscureText = !_currentPasswordObscureText;
                        });
                      },
                    ),
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textInputAction: TextInputAction.done,
                  obscureText: _currentPasswordObscureText,
                  validator: _currentPasswordValidator,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: bloc.newPasswordController,
                  decoration: InputDecoration(
                    labelText: context.l10n.changePasswordScreen_newPassword,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(Icons.lock_outline),
                    ),
                    suffixIcon: _suffixIcon(
                      obscureText: _newPasswordObscureText,
                      onPressed: () {
                        setState(() {
                          _newPasswordObscureText = !_newPasswordObscureText;
                        });
                      },
                    ),
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textInputAction: TextInputAction.done,
                  obscureText: _newPasswordObscureText,
                  validator: _newPasswordValidator,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: bloc.confirmPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(Icons.lock_outline),
                    ),
                    suffixIcon: _suffixIcon(
                      obscureText: _confirmPasswordObscureText,
                      onPressed: () {
                        setState(() {
                          _confirmPasswordObscureText = !_confirmPasswordObscureText;
                        });
                      },
                    ),
                    labelText: context.l10n.changePasswordScreen_confirmPassword,
                    fillColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onSaved: (String? value) {},
                  style: Theme.of(context).textTheme.bodyMedium,
                  textInputAction: TextInputAction.done,
                  obscureText: _confirmPasswordObscureText,
                  validator: _confirmPasswordValidator,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: FilledButton(
              onPressed: () {
                KeyboardUtil.hideKeyboard(context);
                context.read<ChangePasswordBloc>().add(ChangePasswordUpdateEvent());
              },
              child: Text(context.l10n.action_update.toUpperCase()),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _suffixIcon({required bool obscureText, VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: IconButton(
        icon: Icon(obscureText ? Icons.visibility_rounded : Icons.visibility_off_rounded),
        onPressed: () {
          onPressed?.call();
        },
      ),
    );
  }

  String? _currentPasswordValidator(String? text) {
    if (TextUtil.isBlank(text)) {
      return context.l10n.changePasswordScreen_currentPassword_validation;
    }
    return null;
  }

  String? _newPasswordValidator(String? text) {
    if (TextUtil.isBlank(text)) {
      return context.l10n.changePasswordScreen_newPassword_validation;
    }
    return null;
  }

  String? _confirmPasswordValidator(String? text) {
    final newPassword = context.read<ChangePasswordBloc>().newPasswordController.text;
    if (TextUtil.isBlank(text)) {
      return context.l10n.changePasswordScreen_confirmPassword_validation;
    } else if (newPassword != text) {
      return context.l10n.changePasswordScreen_password_match;
    }
    return null;
  }
}
