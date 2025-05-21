import 'package:flutter/material.dart';
import 'package:property/EMI/EMI.dart';
import 'package:property/Profile_Page/agent.dart';
import 'package:property/PropertyPage.dart';
import 'package:property/Trending/trending.dart';

import '../auth/login.dart';
import '../home.dart';
import '../sample.dart';
import 'colors.dart'; // Importing the SamplePage

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Get current theme mode
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          onTap(index);

          // Navigate to the corresponding page when an icon is clicked
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
              MaterialPageRoute(builder: (context) => const ProfilePage()), // Navigate to SamplePage
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedItemColor: isDarkMode ? AppColors.ivoryWhite : AppColors.primaryColor,
        unselectedItemColor: isDarkMode ? AppColors.greyColor : AppColors.greyColor,
        selectedLabelStyle: TextStyle(color: isDarkMode ? AppColors.ivoryWhite : AppColors.primaryColor),
        unselectedLabelStyle: TextStyle(color: isDarkMode ? AppColors.greyColor : AppColors.greyColor),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.home, 0, isDarkMode),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.whatshot, 1, isDarkMode),
            label: 'Trending',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.view_in_ar, 2, isDarkMode),
            label: 'AR',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.message_outlined, 3, isDarkMode),
            label: 'Consult',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.person, 4, isDarkMode),  // Changed to profile icon
            label: 'Profile',  // Change label if needed
          ),

        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, int index, bool isDarkMode) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.only(top: currentIndex == index ? 0 : 10),
      child: Icon(
        icon,
        size: currentIndex == index ? 30 : 24,
        color: currentIndex == index
            ? (isDarkMode ? AppColors.ivoryWhite : AppColors.primaryColor)
            : (isDarkMode ? AppColors.greyColor : AppColors.greyColor),
      ),
    );
  }
}
