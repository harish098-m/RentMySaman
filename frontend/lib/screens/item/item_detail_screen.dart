import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants.dart';
import '../../models/listing.dart';
import '../../widgets/verified_badge.dart';
import '../booking/booking_screen.dart';

class ItemDetailScreen extends StatelessWidget {
  final Listing listing;

  const ItemDetailScreen({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Gallery
            SizedBox(
              height: 300,
              child: PageView.builder(
                itemCount: listing.images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    listing.images[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image, size: 100, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Category
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          listing.title,
                          style: AppTextStyles.heading1,
                        ),
                      ),
                      Chip(
                        label: Text(listing.category),
                        backgroundColor: AppColors.primary,
                        labelStyle: const TextStyle(color: AppColors.secondary),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 20, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(listing.location, style: AppTextStyles.bodyMedium),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Price
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Price per day:', style: AppTextStyles.bodyLarge),
                        Text(
                          '₹${listing.pricePerDay.toInt()}',
                          style: AppTextStyles.heading1.copyWith(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Owner Info
                  const Text('Owner', style: AppTextStyles.heading2),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Text(
                          listing.ownerName[0],
                          style: const TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listing.ownerName, style: AppTextStyles.bodyLarge),
                            if (listing.ownerVerified)
                              const VerifiedBadge(label: 'Mobile Verified'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Description
                  const Text('Description', style: AppTextStyles.heading2),
                  const SizedBox(height: 8),
                  Text(listing.description, style: AppTextStyles.bodyMedium),
                  
                  const SizedBox(height: 24),
                  
                  // AI Insights (if available)
                  if (listing.aiInsights != null) ...[
                    ExpansionTile(
                      title: Row(
                        children: [
                          const Text('AI Insights', style: AppTextStyles.heading2),
                          const SizedBox(width: 8),
                          const Icon(Icons.smart_toy, color: AppColors.primary),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (listing.healthScore != null)
                                Row(
                                  children: [
                                    const Text('Health Score: ', style: AppTextStyles.bodyMedium),
                                    Text(
                                      '${listing.healthScore}/100',
                                      style: AppTextStyles.bodyLarge.copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 8),
                              Text(listing.aiInsights!, style: AppTextStyles.bodyMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                  
                  // Availability
                  const Text('Availability', style: AppTextStyles.heading2),
                  const SizedBox(height: 8),
                  Text(
                    'Available from ${DateFormat('dd MMM yyyy').format(listing.availableFrom)} to ${DateFormat('dd MMM yyyy').format(listing.availableTo)}',
                    style: AppTextStyles.bodyMedium,
                  ),
                  
                  const SizedBox(height: 100), // Space for button
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingScreen(listing: listing),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Request to Book'),
          ),
        ),
      ),
    );
  }
}
