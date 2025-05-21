import 'package:flutter/material.dart';
import 'dart:math';
import '../constants/bottom_nav_bar.dart';
import '../constants/sidebar.dart';
import '../constants/colors.dart'; // Importing colors

class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  int _selectedIndex = 1;
  final Random _random = Random();

  List<Map<String, dynamic>> trendingImages = [
    {'path': 'https://via.placeholder.com/300x200', 'title': 'Modern Bedroom'},
    {'path': 'https://via.placeholder.com/300x200', 'title': 'Luxury Kitchen'},
    {'path': 'https://via.placeholder.com/300x200', 'title': 'Spacious Living Room'},
    {'path': 'https://via.placeholder.com/300x200', 'title': 'New Office Space'},
    {'path': 'https://via.placeholder.com/300x200', 'title': 'Contemporary Bathroom'},
  ];

  List<Map<String, dynamic>> professionals = [
    {'name': 'John Doe', 'profilePic': 'https://via.placeholder.com/60', 'specialty': 'Interior Designer'},
    {'name': 'Jane Smith', 'profilePic': 'https://via.placeholder.com/60', 'specialty': 'Architect'},
    {'name': 'Bob Brown', 'profilePic': 'https://via.placeholder.com/60', 'specialty': 'Construction Expert'},
  ];

  List<Map<String, dynamic>> suggestions = [];
  bool _isLoading = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  // Search functionality for properties and profiles
  Future<void> _fetchSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() {
        suggestions = [];
      });
      return;
    }

    List<Map<String, dynamic>> allSuggestions = [];

    // Searching properties based on title
    List<Map<String, dynamic>> imageSuggestions = trendingImages
        .where((image) => image['title'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    // Searching professionals based on name
    List<Map<String, dynamic>> professionalSuggestions = professionals
        .where((professional) => professional['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    allSuggestions = [...professionalSuggestions, ...imageSuggestions];

    setState(() {
      suggestions = allSuggestions;
    });
  }

  // Perform search query
  void _performSearch(String query) {
    if (query.isEmpty) return;

    // Filter trendingImages based on the search query
    List<Map<String, dynamic>> imageResults = trendingImages.where((image) {
      return image['title'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      trendingImages = imageResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search professionals or images',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.black54),
          ),
          onChanged: (query) {
            searchQuery = query;
            _fetchSuggestions(query); // Search suggestions dynamically
          },
          onSubmitted: (query) {
            _performSearch(query); // Perform full search when submitted
          },
        ),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : suggestions.isNotEmpty || searchQuery.isNotEmpty
          ? _buildSuggestionsList()
          : _buildTrendingGrid(),
      drawer: SideBar(toggleDarkMode: (bool value) {}, userName: '', profileImageUrl: '',),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }

  // Build suggestions list based on search query
  Widget _buildSuggestionsList() {
    if (suggestions.isEmpty && searchQuery.isNotEmpty) {
      return const Center(
        child: Text(
          'No results found',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion['type'] == 'professional'
              ? 'Professional: ${suggestion['name']}'
              : 'Design: ${suggestion['title']}'),
          onTap: () {
            // Handle navigation or interaction here
          },
        );
      },
    );
  }

  // Build trending grid with optional ads
  Widget _buildTrendingGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75, // Ratio for image size
        ),
        itemCount: trendingImages.length + (trendingImages.length ~/ 5), // Account for ads
        itemBuilder: (context, index) {
          if (_shouldShowAd(index)) {
            return _buildAdContainer(); // Show ad
          }

          final actualIndex = index - (index ~/ 5);
          if (actualIndex >= trendingImages.length) return Container(); // Avoid index errors

          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyColor), // Add border to grid box
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TrendingTile(
              imagePath: trendingImages[actualIndex]['path'] ?? '',
              title: trendingImages[actualIndex]['title'] ?? '',
            ),
          );
        },
      ),
    );
  }

  // Determine whether to show an ad
  bool _shouldShowAd(int index) {
    return _random.nextInt(10) == 0; // Show ad every 10 items
  }

  // Widget for ads
  Widget _buildAdContainer() {
    return GestureDetector(
      onTap: () {
        // Handle professional container click
        print("Ad clicked");
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.softGold, // Light accent for ad
          border: Border.all(color: AppColors.greyColor),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.network(
                'https://via.placeholder.com/60', // Placeholder image for ad
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Professional Ad',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Click to contact for design consultations',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {}, // Add your logic
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Contact'),
            ),
          ],
        ),
      ),
    );
  }

  // Bottom navigation tap handler
  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation based on the selected index
  }
}

// Widget for each trending image tile
class TrendingTile extends StatelessWidget {
  final String imagePath;
  final String title;

  const TrendingTile({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    // Check the current theme mode
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDarkMode
                  ? AppColors.whiteColor // White color for text in dark mode
                  : AppColors.textColor, // Normal text color for light mode
            ),
          ),
        ),
      ],
    );
  }
}
