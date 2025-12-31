import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../core/constants.dart';
import '../../services/ai_service.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  
  String _selectedCategory = 'Car';
  final List<String> _categories = ['Car', 'Bike', 'Camera', 'Tool', 'Other'];
  
  final ImagePicker _picker = ImagePicker();
  List<XFile> _images = [];
  
  final AiService _aiService = AiService();
  AiAnalysisResult? _aiResult;
  bool _isAnalyzing = false;
  
  DateTimeRange? _selectedDateRange;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _images.addAll(pickedFiles);
      });
      _analyzeImages();
    }
  }

  Future<void> _analyzeImages() async {
    if (_images.isEmpty) return;
    
    setState(() => _isAnalyzing = true);
    
    try {
      final result = await _aiService.analyzeImages(_images);
      setState(() {
        _aiResult = result;
        _isAnalyzing = false;
        // Auto-fill suggestions if user hasn't typed yet
        if (_priceController.text.isEmpty) {
           // Extracting a value from range for demo, e.g., 1800
           // In real app, we'd parse this better
        }
        if (_selectedCategory == 'Other') {
          _selectedCategory = result.category;
        }
      });
    } catch (e) {
      setState(() => _isAnalyzing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('AI Analysis failed: $e')),
      );
    }
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  void _submitListing() {
    if (_formKey.currentState!.validate()) {
      if (_images.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please add at least one image')),
        );
        return;
      }
      
      // TODO: Upload images to Firebase Storage
      // TODO: Save listing to Firestore
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Listing added successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Listing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Category Selector
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              
              // Hints based on category
              if (_selectedCategory == 'Car' || _selectedCategory == 'Bike')
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.amber.withOpacity(0.1),
                  child: const Text(
                    'Tip: Include photos of the dashboard (odometer) and any scratches for better AI pricing.',
                    style: AppTextStyles.caption,
                  ),
                ),
              const SizedBox(height: 16),

              // Image Picker
              ElevatedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.add_a_photo),
                label: const Text('Add Photos (3-5 recommended)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              if (_images.isNotEmpty)
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.file(
                          File(_images[index].path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              
              // AI Analysis Result
              if (_isAnalyzing)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              if (_aiResult != null)
                Card(
                  color: Colors.black87,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('AI Insights 🤖', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('Suggested Price: ${_aiResult!.priceRange}', style: const TextStyle(color: Colors.white)),
                        Text('Health Score: ${_aiResult!.healthScore}/100', style: const TextStyle(color: Colors.white)),
                        Text('Detected: ${_aiResult!.odometer}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 8),
                        const Text('Note: You decide the final price.', style: TextStyle(color: Colors.amber, fontSize: 12, fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                ),
              
              const SizedBox(height: 16),
              
              // Basic Details
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title (e.g. Swift Dzire 2020)'),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 16),
              
              // Price
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price per Day (₹)',
                  prefixText: '₹ ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter a price' : null,
              ),
              
              const SizedBox(height: 16),
              
              // Location
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  suffixIcon: Icon(Icons.location_on),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter a location' : null,
              ),
              
              const SizedBox(height: 16),
              
              // Availability
              InkWell(
                onTap: _selectDateRange,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Availability',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _selectedDateRange == null
                        ? 'Select Date Range'
                        : '${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.end)}',
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              ElevatedButton(
                onPressed: _submitListing,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Post Listing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
