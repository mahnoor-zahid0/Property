import 'package:flutter/material.dart';
import 'constants/bottom_nav_bar.dart'; // Import the BottomNavBar
import 'constants/colors.dart';

class SamplePage extends StatelessWidget {
  const SamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor, // Use primary color for the app bar
        title: const Text('Sample Page'),
      ),
      // Main content of the sample page
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.star,
              size: 80,
              color: AppColors.primaryColor,
            ),
            SizedBox(height: 20),
            Text(
              'This is a sample page!',
              style: TextStyle(fontSize: 18, color: AppColors.textColor),
            ),
          ],
        ),
      ),
      // Add the Bottom Navigation Bar here
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0, // Set this index based on the navigation position
        onTap: (index) {
          // Handle tap if needed
        },
      ),
    );
  }
}
