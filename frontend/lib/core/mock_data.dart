import '../models/listing.dart';
import '../models/booking.dart';

class MockData {
  static final List<Listing> listings = [
    Listing(
      id: '1',
      title: 'Swift Dzire 2020',
      description: 'Well-maintained car, perfect for city rides and long trips. AC, music system, comfortable seating.',
      category: 'Car',
      pricePerDay: 1800,
      location: 'Bangalore, Karnataka',
      images: ['https://via.placeholder.com/400x300/FFD700/000000?text=Swift+Dzire'],
      ownerId: 'owner1',
      ownerName: 'Rajesh Kumar',
      ownerVerified: true,
      availableFrom: DateTime.now(),
      availableTo: DateTime.now().add(const Duration(days: 90)),
      healthScore: 85,
      aiInsights: 'Minor scratches on front bumper. Interior clean. Odometer: 45,000 km',
    ),
    Listing(
      id: '2',
      title: 'Honda Activa 2021',
      description: 'Fuel-efficient scooter, great for daily commute. Recently serviced.',
      category: 'Bike',
      pricePerDay: 400,
      location: 'Pune, Maharashtra',
      images: ['https://via.placeholder.com/400x300/FFD700/000000?text=Honda+Activa'],
      ownerId: 'owner2',
      ownerName: 'Priya Sharma',
      ownerVerified: true,
      availableFrom: DateTime.now(),
      availableTo: DateTime.now().add(const Duration(days: 60)),
      healthScore: 92,
      aiInsights: 'Excellent condition. No visible damage. Odometer: 12,000 km',
    ),
    Listing(
      id: '3',
      title: 'Canon EOS 1500D DSLR',
      description: 'Professional camera with 18-55mm lens. Perfect for photography enthusiasts.',
      category: 'Camera',
      pricePerDay: 800,
      location: 'Mumbai, Maharashtra',
      images: ['https://via.placeholder.com/400x300/FFD700/000000?text=Canon+DSLR'],
      ownerId: 'owner3',
      ownerName: 'Amit Patel',
      ownerVerified: false,
      availableFrom: DateTime.now(),
      availableTo: DateTime.now().add(const Duration(days: 30)),
    ),
    Listing(
      id: '4',
      title: 'Power Drill Set',
      description: 'Complete drill set with multiple bits. Ideal for home repairs and DIY projects.',
      category: 'Tool',
      pricePerDay: 200,
      location: 'Delhi, NCR',
      images: ['https://via.placeholder.com/400x300/FFD700/000000?text=Power+Drill'],
      ownerId: 'owner1',
      ownerName: 'Rajesh Kumar',
      ownerVerified: true,
      availableFrom: DateTime.now(),
      availableTo: DateTime.now().add(const Duration(days: 120)),
    ),
  ];

  static final List<Booking> bookings = [
    Booking(
      id: 'b1',
      listingId: '1',
      listingTitle: 'Swift Dzire 2020',
      userId: 'currentUser',
      startDate: DateTime.now().subtract(const Duration(days: 5)),
      endDate: DateTime.now().subtract(const Duration(days: 3)),
      totalPrice: 5400,
      status: 'completed',
    ),
    Booking(
      id: 'b2',
      listingId: '2',
      listingTitle: 'Honda Activa 2021',
      userId: 'currentUser',
      startDate: DateTime.now().add(const Duration(days: 2)),
      endDate: DateTime.now().add(const Duration(days: 4)),
      totalPrice: 1200,
      status: 'confirmed',
    ),
  ];

  static Listing? getListingById(String id) {
    try {
      return listings.firstWhere((listing) => listing.id == id);
    } catch (e) {
      return null;
    }
  }
}
