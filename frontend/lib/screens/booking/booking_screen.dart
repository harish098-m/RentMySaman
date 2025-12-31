import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants.dart';
import '../../models/listing.dart';

class BookingScreen extends StatefulWidget {
  final Listing listing;

  const BookingScreen({super.key, required this.listing});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTimeRange? _selectedDateRange;
  
  double get _totalPrice {
    if (_selectedDateRange == null) return 0;
    final days = _selectedDateRange!.end.difference(_selectedDateRange!.start).inDays + 1;
    return widget.listing.pricePerDay * days;
  }
  
  int get _numberOfDays {
    if (_selectedDateRange == null) return 0;
    return _selectedDateRange!.end.difference(_selectedDateRange!.start).inDays + 1;
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: widget.listing.availableFrom,
      lastDate: widget.listing.availableTo,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.secondary,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  void _confirmBooking() {
    if (_selectedDateRange == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select dates')),
      );
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Booking Confirmed!'),
        content: Text(
          'Your booking for ${widget.listing.title} from ${DateFormat('dd MMM').format(_selectedDateRange!.start)} to ${DateFormat('dd MMM yyyy').format(_selectedDateRange!.end)} has been confirmed.\\n\\nTotal: ₹${_totalPrice.toInt()}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to item detail
              Navigator.of(context).pop(); // Go back to home
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Item'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Item Summary
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.listing.images.first,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.listing.title,
                            style: AppTextStyles.heading2.copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.listing.location,
                            style: AppTextStyles.caption,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '₹${widget.listing.pricePerDay.toInt()}/day',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Date Selection
            const Text('Select Dates', style: AppTextStyles.heading2),
            const SizedBox(height: 12),
            InkWell(
              onTap: _selectDateRange,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _selectedDateRange == null
                            ? 'Tap to select dates'
                            : '${DateFormat('dd MMM').format(_selectedDateRange!.start)} - ${DateFormat('dd MMM yyyy').format(_selectedDateRange!.end)}',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Price Breakdown
            if (_selectedDateRange != null) ...[
              const Text('Price Breakdown', style: AppTextStyles.heading2),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('₹${widget.listing.pricePerDay.toInt()} × $_numberOfDays days'),
                        Text('₹${_totalPrice.toInt()}'),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total', style: AppTextStyles.heading2),
                        Text(
                          '₹${_totalPrice.toInt()}',
                          style: AppTextStyles.heading1.copyWith(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 32),
            
            // Confirm Button
            ElevatedButton(
              onPressed: _confirmBooking,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
