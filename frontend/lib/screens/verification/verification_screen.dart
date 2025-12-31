import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../widgets/verified_badge.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _aadhaarVerified = false;

  void _verifyAadhaar() {
    // Simulate verification
    setState(() {
      _aadhaarVerified = true;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Aadhaar verified successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Mobile Verification
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.phone_android, color: AppColors.primary),
                        const SizedBox(width: 12),
                        const Text('Mobile Number', style: AppTextStyles.heading2),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('+91 9876543210'),
                        const VerifiedBadge(label: 'Verified'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Aadhaar Verification
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.credit_card, color: AppColors.primary),
                        const SizedBox(width: 12),
                        const Text('Aadhaar Card', style: AppTextStyles.heading2),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (!_aadhaarVerified) ...[
                      const Text(
                        'Verify your Aadhaar to build trust with renters and increase your listing visibility.',
                        style: AppTextStyles.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _verifyAadhaar,
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Upload Aadhaar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: AppColors.primary,
                        ),
                      ),
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('XXXX XXXX 1234'),
                          const VerifiedBadge(label: 'Verified'),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Benefits
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.verified_user, color: Colors.green.shade700),
                      const SizedBox(width: 8),
                      Text(
                        'Benefits of Verification',
                        style: AppTextStyles.heading2.copyWith(color: Colors.green.shade700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildBenefit('Build trust with renters'),
                  _buildBenefit('Higher listing visibility'),
                  _buildBenefit('Faster booking approvals'),
                  _buildBenefit('Access to premium features'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefit(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 20, color: Colors.green.shade700),
          const SizedBox(width: 8),
          Text(text, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
