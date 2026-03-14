import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spacebook/services/api_service.dart';

const Color _green = Color(0xFF3F6B00);

class Slot {
  final String time;
  final String status;
  Slot(this.time, this.status);
}

class ListYourSpacePage extends StatefulWidget {
  const ListYourSpacePage({super.key});

  @override
  State<ListYourSpacePage> createState() => _ListYourSpacePageState();
}

class _ListYourSpacePageState extends State<ListYourSpacePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController =
      TextEditingController(text: "500");

  String _selectedSpaceType = "Select Space Type";
  bool _isLoading = false;
  bool _isUploadingImage = false;

  Uint8List? _pickedImageBytes;
  String _pickedImageName = '';
  String _uploadedImageUrl = '';

  final Map<String, bool> facilities = {
    "Wi-Fi": false,
    "Parking": false,
    "Lighting": false,
    "Showers": false,
    "Air Conditioning": false,
  };

  final List<Slot> timeSlots = [
    Slot("08:00 AM", "free"),
    Slot("09:00 AM", "free"),
    Slot("10:00 AM", "free"),
    Slot("11:00 AM", "free"),
    Slot("12:00 PM", "free"),
    Slot("01:00 PM", "free"),
    Slot("02:00 PM", "free"),
    Slot("03:00 PM", "free"),
    Slot("04:00 PM", "free"),
  ];

  Set<String> selectedSlots = {};

  String _getCategoryValue(String type) {
    switch (type) {
      case "Turf": return "Sports Turfs";
      case "Library": return "Libraries";
      case "Study Halls": return "Study Halls";
      case "Event Halls": return "Event Halls";
      default: return type;
    }
  }

  String _getDefaultImageForCategory(String type) {
    switch (type) {
      case "Turf": return 'https://images.unsplash.com/photo-1551958219-acbc630e2914?w=600';
      case "Library": return 'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?w=600';
      case "Study Halls": return 'https://images.unsplash.com/photo-1568667256549-094345857637?w=600';
      case "Event Halls": return 'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?w=600';
      default: return 'https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=600';
    }
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        imageQuality: 80,
      );
      if (picked == null) return;

      final bytes = await picked.readAsBytes();
      setState(() {
        _pickedImageBytes = bytes;
        _pickedImageName = picked.name;
        _uploadedImageUrl = ''; // reset previous upload
        _isUploadingImage = true;
      });

      // Upload to Cloudinary immediately after picking
      try {
        final url = await ApiService.uploadImageToCloudinary(
          bytes,
          picked.name,
        );
        setState(() {
          _uploadedImageUrl = url;
          _isUploadingImage = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image uploaded successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        setState(() => _isUploadingImage = false);
        _showError('Image upload failed. Default image will be used.');
      }
    } catch (e) {
      setState(() => _isUploadingImage = false);
      _showError('Could not pick image. Try again.');
    }
  }

  Future<void> _handleDone() async {
    if (_nameController.text.trim().isEmpty) {
      _showError('Please enter a space name');
      return;
    }
    if (_selectedSpaceType == "Select Space Type") {
      _showError('Please select a space type');
      return;
    }
    if (_locationController.text.trim().isEmpty) {
      _showError('Please enter a location/address');
      return;
    }
    if (_priceController.text.trim().isEmpty) {
      _showError('Please enter a price');
      return;
    }
    if (_isUploadingImage) {
      _showError('Please wait for image upload to complete');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Use Cloudinary URL if uploaded, otherwise use default
      final imageUrl = _uploadedImageUrl.isNotEmpty
          ? _uploadedImageUrl
          : _getDefaultImageForCategory(_selectedSpaceType);

      final result = await ApiService.createSpace(
        title: _nameController.text.trim(),
        category: _getCategoryValue(_selectedSpaceType),
        area: _locationController.text.trim(),
        description: _descriptionController.text.trim(),
        pricePerHr: int.tryParse(_priceController.text.trim()) ?? 500,
        hasSeats: _seatsController.text.trim().isNotEmpty,
        imageUrl: imageUrl,
      );

      if (result['id'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Space listed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        _showError(result['error'] ?? 'Failed to list space. Try again.');
      }
    } catch (e) {
      _showError('Connection error. Is the backend running?');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "List Your Space",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text("Space Name",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _buildTextField("e.g. Downtown Sports Arena",
                      controller: _nameController),

                  const SizedBox(height: 20),

                  const Text("Space Type",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _buildDropdown(),

                  const SizedBox(height: 20),

                  const Text("Number of seats (optional)",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _buildTextField("e.g. 100",
                      controller: _seatsController,
                      keyboardType: TextInputType.number),

                  const SizedBox(height: 20),

                  const Text("Available Slots",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: timeSlots.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 2.5,
                    ),
                    itemBuilder: (context, index) {
                      final slot = timeSlots[index];
                      final isSelected = selectedSlots.contains(slot.time);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedSlots.contains(slot.time)) {
                              selectedSlots.remove(slot.time);
                            } else {
                              selectedSlots.add(slot.time);
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? _green : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _green, width: 2),
                            boxShadow: isSelected
                                ? [BoxShadow(color: _green.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 4))]
                                : [],
                          ),
                          child: Text(
                            slot.time,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  const Text("Location/Address",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  _buildTextField("e.g. MG Road, Bangalore",
                      controller: _locationController),

                  const SizedBox(height: 20),

                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: _green, width: 2),
                      color: Colors.grey.shade200,
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map, size: 40, color: Colors.grey),
                          SizedBox(height: 6),
                          Text("Map view",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text("Pricing per Hour (INR)",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: "₹ ",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: _green, width: 2), borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: _green, width: 2), borderRadius: BorderRadius.circular(12)),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text("Facilities",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  ...facilities.keys.map((facility) {
                    return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(facility),
                      value: facilities[facility],
                      activeColor: _green,
                      onChanged: (value) =>
                          setState(() => facilities[facility] = value!),
                    );
                  }),

                  const SizedBox(height: 20),

                  // ── Photo Upload with Cloudinary ──
                  const Text("Upload Photo",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  const Text(
                    "Pick a photo from your device — it uploads automatically",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: _isUploadingImage ? null : _pickImage,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _uploadedImageUrl.isNotEmpty
                              ? _green
                              : _pickedImageBytes != null
                                  ? Colors.orange
                                  : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: _isUploadingImage
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(color: _green),
                                const SizedBox(height: 12),
                                Text(
                                  'Uploading $_pickedImageName...',
                                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                                ),
                              ],
                            )
                          : _pickedImageBytes != null
                              ? Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.memory(
                                        _pickedImageBytes!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // Upload status badge
                                    Positioned(
                                      top: 8,
                                      left: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: _uploadedImageUrl.isNotEmpty
                                              ? Colors.green
                                              : Colors.orange,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              _uploadedImageUrl.isNotEmpty
                                                  ? Icons.cloud_done
                                                  : Icons.cloud_upload,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              _uploadedImageUrl.isNotEmpty
                                                  ? 'Uploaded'
                                                  : 'Uploading...',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Remove button
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: GestureDetector(
                                        onTap: () => setState(() {
                                          _pickedImageBytes = null;
                                          _pickedImageName = '';
                                          _uploadedImageUrl = '';
                                        }),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle),
                                          child: const Icon(Icons.close,
                                              color: Colors.white, size: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate_outlined,
                                        size: 48, color: Colors.grey.shade400),
                                    const SizedBox(height: 10),
                                    Text("Tap to select from gallery",
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 14)),
                                    const SizedBox(height: 4),
                                    Text("Uploads directly to cloud",
                                        style: TextStyle(
                                            color: Colors.grey.shade400,
                                            fontSize: 12)),
                                  ],
                                ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text("Description",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Tell guests what makes your space unique...",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: _green, width: 2), borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: _green, width: 2), borderRadius: BorderRadius.circular(12)),
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: _green, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Save Draft",
                        style: TextStyle(fontWeight: FontWeight.w600, color: _green)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (_isLoading || _isUploadingImage) ? null : _handleDone,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Done",
                            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint,
      {TextEditingController? controller,
      TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: _green, width: 2), borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: _green, width: 2), borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: _green, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton<String>(
            isExpanded: true,
            value: _selectedSpaceType,
            items: const [
              DropdownMenuItem(value: "Select Space Type", child: Text("Select Space Type")),
              DropdownMenuItem(value: "Turf", child: Text("Turf")),
              DropdownMenuItem(value: "Library", child: Text("Library")),
              DropdownMenuItem(value: "Study Halls", child: Text("Study Halls")),
              DropdownMenuItem(value: "Event Halls", child: Text("Event Halls")),
            ],
            onChanged: (value) => setState(() => _selectedSpaceType = value!),
          ),
        ),
      ),
    );
  }
}