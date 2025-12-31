import 'package:image_picker/image_picker.dart';

class AiAnalysisResult {
  final String category;
  final String damageReport;
  final String odometer;
  final String priceRange;
  final int healthScore;

  AiAnalysisResult({
    required this.category,
    required this.damageReport,
    required this.odometer,
    required this.priceRange,
    required this.healthScore,
  });
}

class AiService {
  // Mock analysis - in real app this would call Google Cloud Vision API
  Future<AiAnalysisResult> analyzeImages(List<XFile> images) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock logic based on image count or just random for demo
    return AiAnalysisResult(
      category: 'Car',
      damageReport: 'Minor scratches on front bumper. Interior looks clean.',
      odometer: '45,000 km (detected from dashboard)',
      priceRange: '₹1,600 - ₹2,000 per day',
      healthScore: 82,
    );
  }
}
