//frontend\sway\lib\screens\profile_screen.dart
import 'package:flutter/material.dart';
import 'package:sway/models/user.dart'; // Import User model
import '../services/api_service.dart'; // Import ApiService for fetching user data

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user; // Define User object

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data when screen initializes
  }

  Future<void> fetchUserData() async {
    try {
      user = await ApiService
          .fetchUserDetails(); // Replace with your API call to fetch user data
      setState(() {}); // Update the UI after fetching data
    } catch (e) {
      // Handle error
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: user != null
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile picture and username
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.profilePictureUrl),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    user.username,
                    style:
                        const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  // Quick access buttons (Account settings, Orders, Saved Addresses)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildProfileButton('Account Settings', Icons.settings,
                          () {
                        // Navigate to account settings screen
                      }),
                      _buildProfileButton('Orders', Icons.shopping_bag, () {
                        // Navigate to orders screen
                      }),
                      _buildProfileButton('Saved Addresses', Icons.location_on,
                          () {
                        // Navigate to saved addresses screen
                      }),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  // Section for recent activity and recommendations (Placeholder)
                  const Text(
                    'Recent Activity',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  // Replace with actual recent activity widget
                  _buildActivityItem('Viewed Product: Product Name'),
                  _buildActivityItem('Purchased Product: Product Name'),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Recommendations',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  // Replace with actual recommendations widget
                  _buildRecommendationItem('Recommended Product: Product Name'),
                ],
              ),
            )
          : const Center(
              child:
                  CircularProgressIndicator(), // Loading indicator while fetching data
            ),
    );
  }

  Widget _buildProfileButton(
      String title, IconData icon, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          iconSize: 40.0,
        ),
        const SizedBox(height: 8.0),
        Text(title),
      ],
    );
  }

  Widget _buildActivityItem(String activity) {
    return ListTile(
      leading: const Icon(Icons.history),
      title: Text(activity),
    );
  }

  Widget _buildRecommendationItem(String recommendation) {
    return ListTile(
      leading: const Icon(Icons.star),
      title: Text(recommendation),
    );
  }
}
