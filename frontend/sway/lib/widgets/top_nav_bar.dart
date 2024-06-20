//frontend\sway\lib\widgets\top_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:sway/screens/cart_screen.dart';
import 'package:sway/screens/notification_screen.dart';
import 'package:sway/screens/wishlist_screen.dart';
import 'package:sway/screens/profile_screen.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Sway', style: TextStyle(color: Colors.black)),
      centerTitle: true,
      backgroundColor: Colors.white,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {
            // Navigate to search screen or show search dialog
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.person, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.favorite, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WishlistScreen()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationsScreen()),
            );
          },
        ),
      ],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results
    return Center(
      child: Text("Search result for \"$query\""),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions
    return Center(
      child: Text("Suggestions for \"$query\""),
    );
  }
}
