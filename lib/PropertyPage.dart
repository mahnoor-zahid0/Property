import 'package:flutter/material.dart';
import 'Property_Details.dart';  // Import PropertyDetailPage
import 'constants/colors.dart'; // Import the color constants

class PropertyPage extends StatelessWidget {
  const PropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyColor.withOpacity(0.3),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.greyColor),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Search address',
                        style: TextStyle(color: AppColors.greyColor),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list, color: AppColors.primaryColor),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Categories
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryButton('Apartment'),
                    _buildCategoryButton('House'),
                    _buildCategoryButton('Hotel'),
                    _buildCategoryButton('Villa'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Near You section with horizontal scrolling cards
              const Text(
                'Near You',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildPropertyCard(
                      'Opera House',
                      'New Jersey',
                      4.5,
                      '2.3 km',
                      context,
                      ['uni/IMG_1103.JPG', 'uni/IMG_1104.JPG'], // Add image paths from local assets
                    ),
                    _buildPropertyCard(
                      'Green Villa',
                      'New Jersey',
                      4.0,
                      '1.5 km',
                      context,
                      ['uni/IMG_1105.JPG', 'uni/IMG_1106.JPG'], // Add image paths from local assets
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Recommended Section
              const Text(
                'Recommended For You',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 10),
              _buildPropertyCard(
                'Ocean House',
                'New Jersey',
                4.8,
                '1.8 km',
                context,
                ['uni/IMG_1107.JPG', 'uni/IMG_1108.JPG'], // Add image paths from local assets
              ),
              _buildPropertyCard(
                'Farm House',
                'New Jersey',
                4.2,
                '3.2 km',
                context,
                ['uni/IMG_1109.JPG', 'uni/IMG_1110.JPG'], // Add image paths from local assets
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build category buttons
  Widget _buildCategoryButton(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: AppColors.primaryColor),
      ),
    );
  }

  // Helper function to build property cards with image and text under it
  // Helper function to build property cards with image and text under it
  Widget _buildPropertyCard(String title, String location, double rating, String distance, BuildContext context, List<String> images) {
    return GestureDetector(
      onTap: () {
        // Navigate to the PropertyDetailPage with relevant details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailPage(
              title: title,
              location: location,
              rating: rating,
              distance: distance,
              images: images,  // Passing images list as named parameter
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.only(right: 16, bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                images[0],  // Display the first image from the assets folder
                width: 180,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: TextStyle(color: AppColors.greyColor),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 18,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text('$rating'),
                      const SizedBox(width: 8),
                      Text(distance),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}