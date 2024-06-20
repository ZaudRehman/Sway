// lib/screens/categories_screen.dart

import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<dynamic> categories = []; // List to store categories data

  @override
  void initState() {
    super.initState();
    // Fetch categories data when the widget initializes
    fetchCategoriesData();
  }

  Future<void> fetchCategoriesData() async {
    try {
      // Replace with actual ApiService function to fetch categories
      categories = await ApiService.fetchCategories();
      setState(() {}); // Update UI after fetching data
    } catch (e) {
      // Handle error fetching data
      print('Error fetching categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: categories.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while fetching data
          : ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryItem(categories[index]);
              },
            ),
    );
  }

  Widget _buildCategoryItem(dynamic category) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Handle category tap, navigate to subcategories or products screen
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200, // Adjust height based on your design
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(category['image_url']),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  category['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                category['description'],
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            // Add more widgets here for subcategories or additional details
          ],
        ),
      ),
    );
  }
}
