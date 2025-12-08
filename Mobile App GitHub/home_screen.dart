import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;

  final List<Widget> _screens = [
    const ProfileScreen(),
    const CameraScreen(),
    const DashboardScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECCFA3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFECCFA3),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "AuraSkin",
          style: TextStyle(
            fontFamily: "Parkinsans",
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B5FBF),
          ),
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFECCFA3),
        selectedItemColor: const Color(0xFF8B5FBF),
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            label: "Camera",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
        ],
      ),
    );
  }
}

// CAMERA SCREEN

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _selectedImage;
  bool _loading = false;
  Map<String, dynamic>? _result;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _result = null;
      });
    }
  }

  Future<void> _analyzeImage() async {
    if (_selectedImage == null) return;

    setState(() => _loading = true);

    try {
      final result = await ApiService.analyzeSkin(_selectedImage!.path);
      setState(() => _result = result);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Skin Analyzer",
            style: TextStyle(
              fontFamily: "Parkinsans",
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B5FBF),
            ),
          ),
          const SizedBox(height: 20),

          // IMAGE DISPLAY
          if (_selectedImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                _selectedImage!,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.image_outlined,
                size: 80,
                color: Color(0xFF8B5FBF),
              ),
            ),

          const SizedBox(height: 20),

          // BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo_library),
                label: const Text("Gallery"),
              ),
              ElevatedButton.icon(
                onPressed: null,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Camera"),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // ANALYZE BUTTON
          ElevatedButton(
            onPressed:
                (_selectedImage == null || _loading) ? null : _analyzeImage,
            child: _loading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Analyze Skin"),
          ),

          const SizedBox(height: 30),

          if (_result != null) _buildResultsCard(),
        ],
      ),
    );
  }

// SKIN TYPES/RECOMMENDATIONS
  Widget _buildResultsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Skin Type: ${_result!['skin_type']}"),
          Text(
            "Confidence: ${(100 * _result!['confidence']).toStringAsFixed(2)}%",
          ),
          const SizedBox(height: 10),
          const Text("Recommendations:"),
          ...List.generate(
            (_result!['recommendations'] as List).length,
            (i) => Text("- ${_result!['recommendations'][i]}"),
          ),
        ],
      ),
    );
  }
}

// DASHBOARD SCREEN

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),

          const Text(
            "Welcome to AuraSkin 💜",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Parkinsans",
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B5FBF),
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            "Your personalized skincare dashboard.\n"
            "Upload a photo in the Camera tab to begin analyzing your skin.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Parkinsans",
              fontSize: 16,
              height: 1.4,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 40),

          // Optional cute card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: const [
                Icon(Icons.spa, size: 48, color: Color(0xFF8B5FBF)),
                SizedBox(height: 10),
                Text(
                  "Your skin journey starts here 🌸",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Parkinsans",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Analyze your skin, discover routines, and glow confidently.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Parkinsans",
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

// PROFILE SCREEN

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Profile",
        style: TextStyle(fontSize: 24, fontFamily: "Parkinsans"),
      ),
    );
  }
}
