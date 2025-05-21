import 'package:flutter/material.dart';
import '../constants/colors.dart';  // Importing the custom AppColors class

class SideBar extends StatelessWidget {
  final String userName;
  final String? profileImageUrl;
  final ValueChanged<bool> toggleDarkMode;  // Dark mode toggle function

  const SideBar({
    super.key,
    required this.userName,
    required this.profileImageUrl,
    required this.toggleDarkMode, // Accept the toggle function
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // User Accounts Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,  // Use primary color from AppColors
            ),
            accountName: Text(
              userName,  // User name
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,  // Use white text for contrast
              ),
            ),
            accountEmail: Text(
              'user@example.com',  // Simplified email
              style: TextStyle(
                fontSize: 14,
                color: AppColors.whiteColor,  // White color for email
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: profileImageUrl != null
                  ? NetworkImage(profileImageUrl!)
                  : const AssetImage('assets/default_avatar.png') as ImageProvider,
              child: profileImageUrl == null ? const Icon(Icons.person, size: 30, color: AppColors.whiteColor) : null,
            ),
          ),

          // Settings menu item
          ListTile(
            leading: Icon(Icons.settings, color: AppColors.textColor),  // Icon color from AppColors
            title: Text('Settings', style: TextStyle(color: AppColors.textColor)),  // Text color from AppColors
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings or another page
            },
          ),

          // Saved menu item
          ListTile(
            leading: Icon(Icons.bookmark, color: AppColors.textColor),  // Icon color from AppColors
            title: Text('Saved', style: TextStyle(color: AppColors.textColor)),  // Text color from AppColors
            onTap: () {
              Navigator.pop(context);
              // Navigate to Saved items or another page
            },
          ),

          // Become a Professional menu item
          ListTile(
            leading: Icon(Icons.work, color: AppColors.textColor),  // Icon color from AppColors
            title: Text('Become a Professional', style: TextStyle(color: AppColors.textColor)),  // Text color from AppColors
            onTap: () {
              Navigator.pop(context);
              // Link to the Professional sign-up page
            },
          ),

          // Dark Mode toggle button inside the sidebar
          ListTile(
            leading: Icon(Icons.brightness_6, color: AppColors.textColor),  // Icon color from AppColors
            title: Text('Dark Mode', style: TextStyle(color: AppColors.textColor)),  // Text color from AppColors
            trailing: Switch(
              value: Theme.of(context).brightness == Brightness.dark,  // Check the current theme mode
              onChanged: toggleDarkMode,  // Trigger the toggle function
            ),
          ),
        ],
      ),
    );
  }
}
