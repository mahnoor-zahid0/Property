import 'package:flutter/material.dart';
import 'package:property/PropertyPage.dart';
import 'package:property/sample.dart';
import 'constants/bottom_nav_bar.dart';
import 'constants/colors.dart';
import 'constants/sidebar.dart';

class HomePage extends StatefulWidget {
  final Function(bool) toggleDarkMode;

  const HomePage({Key? key, required this.toggleDarkMode}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String userName = 'User';  // Default user name (no need for loggedIn state)

  // Function to simulate running some code
  void run() {
    print("Running some code!");
    // You can perform any initialization or logic here.
  }

  @override
  void initState() {
    super.initState();
    run();  // Call the run function when the page is initialized
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textColor),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          'PROPERTY',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Notification Icon
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: AppColors.textColor,
            ),
            onPressed: () {
              // Handle the notification icon click here
              print("Notifications clicked!");
              // For example, navigate to a Notifications page
              // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
            },
          ),
        ],
      ),
      // Drawer (Sidebar)
      drawer: SideBar(
        userName: userName,  // Always show the same user
        profileImageUrl: null,  // No profile image logic for now
        toggleDarkMode: widget.toggleDarkMode, // Pass the dark mode toggle function here
      ),
      // Main body content
      body: PropertyPage(),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _onItemTapped(index);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SamplePage()), // Navigate to SamplePage
          );
        },
      ),
    );
  }
}
