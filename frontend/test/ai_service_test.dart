import 'package:flutter_test/flutter_test.dart';
import 'package:rent_mi/services/ai_service.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  group('AiService Tests', () {
    test('analyzeImages returns valid result', () async {
      final service = AiService();
      final images = [XFile('dummy_path')];

      final result = await service.analyzeImages(images);

      expect(result.category, 'Car');
      expect(result.healthScore, 82);
      expect(result.priceRange, contains('₹'));
    });
  });
}
