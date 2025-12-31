class Booking {
  final String id;
  final String listingId;
  final String listingTitle;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final double totalPrice;
  final String status; // pending, confirmed, completed, cancelled

  Booking({
    required this.id,
    required this.listingId,
    required this.listingTitle,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
  });

  int get numberOfDays => endDate.difference(startDate).inDays + 1;
}
