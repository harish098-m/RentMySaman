import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants.dart';
import '../../core/mock_data.dart';
import '../../widgets/verified_badge.dart';
import '../verification/verification_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Profile'),
              Tab(text: 'My Listings'),
              Tab(text: 'My Bookings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Profile Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.person, size: 50, color: AppColors.secondary),
                  ),
                  const SizedBox(height: 16),
                  const Text('Demo User', style: AppTextStyles.heading1),
                  const SizedBox(height: 8),
                  const Text('+91 9876543210', style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 24),
                  
                  // Verification Status
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Verification Status', style: AppTextStyles.heading2),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Mobile Number'),
                              const VerifiedBadge(label: 'Verified'),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Aadhaar'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const VerificationScreen(),
                                    ),
                                  );
                                },
                                child: const Text('Verify Now'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Stats
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Text('2', style: AppTextStyles.heading1),
                                const SizedBox(height: 4),
                                Text('Listings', style: AppTextStyles.caption),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Text('2', style: AppTextStyles.heading1),
                                const SizedBox(height: 4),
                                Text('Bookings', style: AppTextStyles.caption),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // My Listings Tab
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: MockData.listings.take(2).length,
              itemBuilder: (context, index) {
                final listing = MockData.listings[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        listing.images.first,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image),
                        ),
                      ),
                    ),
                    title: Text(listing.title),
                    subtitle: Text('₹${listing.pricePerDay.toInt()}/day'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            ),
            
            // My Bookings Tab
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: MockData.bookings.length,
              itemBuilder: (context, index) {
                final booking = MockData.bookings[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(booking.listingTitle, style: AppTextStyles.bodyLarge),
                            Chip(
                              label: Text(booking.status.toUpperCase()),
                              backgroundColor: booking.status == 'completed'
                                  ? Colors.green.shade100
                                  : AppColors.primary.withOpacity(0.2),
                              labelStyle: TextStyle(
                                fontSize: 12,
                                color: booking.status == 'completed'
                                    ? Colors.green.shade700
                                    : AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${DateFormat('dd MMM').format(booking.startDate)} - ${DateFormat('dd MMM yyyy').format(booking.endDate)}',
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Total: ₹${booking.totalPrice.toInt()} (${booking.numberOfDays} days)',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
