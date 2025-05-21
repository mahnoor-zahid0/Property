import 'package:flutter/material.dart';
import '../EMI/EMI.dart';
import '../Trending/trending.dart';
import '../constants/bottom_nav_bar.dart';
import '../constants/colors.dart';
import '../constants/sidebar.dart';
import '../home.dart';
import '../sample.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;  // Track the selected index for Bottom Navigation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textColor),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the Sidebar
              },
            );
          },
        ),
        title: const Text(
          'Agent Profile',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.textColor),
            onPressed: () {
              // Handle settings button tap
            },
          ),
        ],
      ),
      drawer: SideBar(
        userName: 'John Doe', // Example agent name
        profileImageUrl: 'https://via.placeholder.com/150', // Profile Image URL
        toggleDarkMode: (bool value) {}, // Dark mode toggle function
      ),
      body: SingleChildScrollView(  // Wrap the body in SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150', // Replace with agent profile image URL
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: const Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ),
            Center(
              child: const Text(
                'Real Estate Agent | Los Angeles, CA',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.greyColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: const Text(
                'Specialized in residential properties with over 10 years of experience.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: AppColors.greyColor),
              ),
            ),
            const SizedBox(height: 16),

            // Stats Section (Properties Sold, Clients Served)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('150+', 'Properties Sold'),
                _buildStatColumn('120+', 'Clients Served'),
                _buildStatColumn('5', 'Years Experience'),
              ],
            ),
            const SizedBox(height: 16),

            // Contact Section
            const Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.phone, color: AppColors.primaryColor),
              title: const Text('Phone'),
              subtitle: const Text('+1 234 567 890'),
            ),
            ListTile(
              leading: const Icon(Icons.email, color: AppColors.primaryColor),
              title: const Text('Email'),
              subtitle: const Text('john.doe@realestate.com'),
            ),
            const SizedBox(height: 16),

            // Recent Listings Section
            const Text(
              'Recent Listings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 8),
            // Placeholder for recent listings (example)
            SizedBox(
              height: 200, // Adjust based on content
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildPropertyCard(
                    title: 'Luxury Apartment',
                    imageUrl: 'https://via.placeholder.com/150',
                    price: '\$500,000',
                    location: 'Los Angeles, CA',
                  ),
                  const SizedBox(width: 16),
                  _buildPropertyCard(
                    title: 'Modern Villa',
                    imageUrl: 'https://via.placeholder.com/150',
                    price: '\$850,000',
                    location: 'Santa Monica, CA',
                  ),
                  const SizedBox(width: 16),
                  _buildPropertyCard(
                    title: 'Beach House',
                    imageUrl: 'https://via.placeholder.com/150',
                    price: '\$1,200,000',
                    location: 'Venice Beach, CA',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Testimonials Section
            const Text(
              'Client Testimonials',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                _buildTestimonial('Isaiah', 'John is the best agent I’ve worked with! Highly recommend.'),
                const SizedBox(height: 8),
                _buildTestimonial('Jayden', 'Great experience, smooth process, and top-notch service.'),
                const SizedBox(height: 8),
                _buildTestimonial('Hunter', 'Found the perfect home with John’s help. 5 stars!'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 4, // Set this index based on the navigation position
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(toggleDarkMode: (bool ) {  },))); // Navigate to SamplePage
          } else if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TrendingPage())); // Navigate to SamplePage
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SamplePage())); // Navigate to SamplePage
          } else if (index == 3) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => EMICalculatorPage())); // Navigate to SamplePage
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (
                  context) => const ProfilePage()), // Navigate to SamplePage
            );
          }
        },
      ),
    );
  }

  // Stat Column widget for Properties Sold, Clients Served, etc.
  Widget _buildStatColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.greyColor,
          ),
        ),
      ],
    );
  }

  // Property Card widget to display a property
  Widget _buildPropertyCard({
    required String title,
    required String imageUrl,
    required String price,
    required String location,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Testimonial widget for client reviews
  Widget _buildTestimonial(String name, String feedback) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.textColor,
        ),
      ),
      subtitle: Text(
        feedback,
        style: const TextStyle(color: AppColors.greyColor),
      ),
    );
  }
}
