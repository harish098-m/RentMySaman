import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constants.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  AuthService? _authServiceInstance;
  AuthService get _authService => _authServiceInstance ??= AuthService();
  
  String? _verificationId;
  bool _isOtpSent = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _verifyPhone() async {
    final phone = _phoneController.text.trim();
    
    // Remove any spaces or special characters
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    
    // Check if it's a valid 10-digit number or +91 followed by 10 digits
    if (cleanPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a phone number')),
      );
      return;
    }
    
    // Extract just the digits (remove +91 if present)
    final digits = cleanPhone.replaceAll('+91', '').replaceAll('+', '');
    
    if (digits.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 10-digit phone number')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Assuming +91 for India as per context
      final formattedPhone = phone.startsWith('+') ? phone : '+91$phone';
      
      await _authService.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        onCodeSent: (verificationId, resendToken) {
          setState(() {
            _verificationId = verificationId;
            _isOtpSent = true;
            _isLoading = false;
          });
        },
        onVerificationFailed: (e) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.message}')),
          );
        },
        onVerificationCompleted: (credential) async {
          await _authService.signInWithOTP(
            verificationId: _verificationId!,
            smsCode: credential.smsCode!,
          );
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        onCodeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _signInWithOtp() async {
    final otp = _otpController.text.trim();
    if (otp.isEmpty || _verificationId == null) return;

    setState(() => _isLoading = true);

    try {
      await _authService.signInWithOTP(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid OTP: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppStrings.loginTitle,
              style: AppTextStyles.heading1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Demo Login Button
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              icon: const Icon(Icons.login),
              label: const Text('Demo Login (Skip Auth)'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: const BorderSide(color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('OR'),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),
            if (!_isOtpSent) ...[
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: AppStrings.phoneHint,
                  border: OutlineInputBorder(),
                  prefixText: '+91 ',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _verifyPhone,
                child: _isLoading
                    ? const CircularProgressIndicator(color: AppColors.secondary)
                    : const Text('Send OTP'),
              ),
            ] else ...[
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter OTP',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _signInWithOtp,
                child: _isLoading
                    ? const CircularProgressIndicator(color: AppColors.secondary)
                    : const Text(AppStrings.verifyOtp),
              ),
              TextButton(
                onPressed: _isLoading ? null : () => setState(() => _isOtpSent = false),
                child: const Text('Change Phone Number'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
