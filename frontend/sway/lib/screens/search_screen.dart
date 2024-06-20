//frontend\sway\lib\screens\search_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Import ApiService
import 'package:sway/models/product.dart'; // Import Product model

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search for products...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              _performSearch(value);
            } else {
              setState(() {
                _isSearching = false;
                _searchResults.clear();
              });
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _searchController.clear();
                _isSearching = false;
                _searchResults.clear();
              });
            },
          ),
        ],
      ),
      body: _isSearching ? _buildSearchResults() : Container(),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(_searchResults[index].imageUrl),
          title: Text(_searchResults[index].name),
          subtitle: Text(_searchResults[index].description),
          onTap: () {
            // Navigate to Product Detail Screen or handle tap action
            // Example: Navigator.pushNamed(context, '/product-detail', arguments: _searchResults[index]);
          },
        );
      },
    );
  }

  void _performSearch(String query) async {
    setState(() {
      _isSearching = true;
    });

    try {
      List<Product> results = await ApiService.searchProducts(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      print('Error searching products: $e');
      // Handle error appropriately, e.g., show an error message
    }
  }
}
