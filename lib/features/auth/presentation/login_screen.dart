import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/enum_label.dart';
import '../../../core/utils/phone_number_formatter.dart';
import '../../../core/widgets/primary_button.dart';
import '../../onboarding/presentation/role_selection_screen.dart';
import '../application/auth_controller.dart';
import 'otp_verification_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const routePath = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(selectedRoleProvider);
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Sign in with phone OTP',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  role == null
                      ? 'Select a role first.'
                      : 'Role selected: ${enumLabel(role).toUpperCase()}',
                ),
                TextButton(
                  onPressed: () => context.push(RoleSelectionScreen.routePath),
                  child: const Text('Change role'),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone number',
                    hintText: '9876543210 or +919876543210',
                  ),
                  validator: (value) {
                    final normalized = normalizePhoneNumber(value ?? '');
                    if (!RegExp(r'^\+[1-9]\d{9,14}$').hasMatch(normalized)) {
                      return 'Enter a valid phone number with country code.';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                PrimaryButton(
                  label: 'Send OTP',
                  isLoading: authState.isLoading,
                  icon: Icons.sms_rounded,
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    final phone = normalizePhoneNumber(_phoneController.text);
                    if (!mounted) {
                      return;
                    }
                    context.push(
                      '${OtpVerificationScreen.routePath}?phone=$phone',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
