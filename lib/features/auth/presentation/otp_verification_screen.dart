import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/phone_number_formatter.dart';
import '../../../core/widgets/primary_button.dart';
import 'profile_setup_screen.dart';

import '../application/auth_controller.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  const OtpVerificationScreen({
    required this.verificationId,
    required this.phoneNumber,
    super.key,
  });

  static const routePath = '/verify-otp';

  final String verificationId;
  final String phoneNumber;

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final _codeController = TextEditingController();
  String? _verificationId;
  bool _requestingOtp = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _verificationId =
        widget.verificationId.isEmpty ? null : widget.verificationId;
    if (_verificationId == null) {
      Future.microtask(_requestOtp);
    }
  }

  Future<void> _requestOtp() async {
    if (_requestingOtp) {
      return;
    }
    _requestingOtp = true;
    try {
      final verificationId =
          await ref.read(authControllerProvider.notifier).requestOtp(
                normalizePhoneNumber(widget.phoneNumber),
              );
      if (!mounted) {
        return;
      }
      setState(() {
        _verificationId = verificationId;
      });
    } finally {
      _requestingOtp = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);

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
      appBar: AppBar(title: const Text('Verify OTP')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Enter the code sent to ${widget.phoneNumber}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                _verificationId == null
                    ? 'Requesting OTP...'
                    : 'OTP sent. Enter the 6-digit code.',
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: '6-digit OTP',
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Verify',
                isLoading: state.isLoading,
                icon: Icons.verified_rounded,
                onPressed: _verificationId == null
                    ? null
                    : () async {
                  await ref.read(authControllerProvider.notifier).verifyOtp(
                        verificationId: _verificationId!,
                        smsCode: _codeController.text.trim(),
                      );
                  if (!mounted) {
                    return;
                  }
                  context.push(ProfileSetupScreen.routePath);
                },
              ),
              TextButton(
                onPressed: state.isLoading ? null : _requestOtp,
                child: const Text('Resend OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
