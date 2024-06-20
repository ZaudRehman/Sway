//frontend\sway\lib\screens\home_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sway/widgets/top_nav_bar.dart';
import 'package:sway/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> featuredProductImages = [];
  List<Map<String, dynamic>> categories = [];
  List<String> personalizedProducts = [];
  List<String> trendingProductImages = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the screen loads
  }

  Future<void> fetchData() async {
    try {
      // Example endpoints, replace with actual backend URLs
      String featuredProductsUrl =
          'http://your-backend-api-url/featured-products';
      String categoriesUrl = 'http://your-backend-api-url/categories';
      String personalizedProductsUrl =
          'http://your-backend-api-url/personalized-products';
      String trendingProductsUrl =
          'http://your-backend-api-url/trending-products';

      // Fetch featured products
      var featuredProductsResponse =
          await http.get(Uri.parse(featuredProductsUrl));
      if (featuredProductsResponse.statusCode == 200) {
        setState(() {
          featuredProductImages =
              List<String>.from(json.decode(featuredProductsResponse.body));
        });
      }

      // Fetch categories
      var categoriesResponse = await http.get(Uri.parse(categoriesUrl));
      if (categoriesResponse.statusCode == 200) {
        setState(() {
          categories = List<Map<String, dynamic>>.from(
              json.decode(categoriesResponse.body));
        });
      }

      // Fetch personalized products
      var personalizedProductsResponse =
          await http.get(Uri.parse(personalizedProductsUrl));
      if (personalizedProductsResponse.statusCode == 200) {
        setState(() {
          personalizedProducts =
              List<String>.from(json.decode(personalizedProductsResponse.body));
        });
      }

      // Fetch trending products
      var trendingProductsResponse =
          await http.get(Uri.parse(trendingProductsUrl));
      if (trendingProductsResponse.statusCode == 200) {
        setState(() {
          trendingProductImages =
              List<String>.from(json.decode(trendingProductsResponse.body));
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error scenarios as needed (e.g., show error message to the user)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(), // Include the TopNavBar here
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFeaturedProductsCarousel(),
            const SizedBox(height: 20),
            _buildCategoriesGrid(),
            const SizedBox(height: 20),
            _buildPersonalizedRecommendations(),
            const SizedBox(height: 20),
            _buildTrendingItems(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ), // Include the BottomNavBar here
    );
  }

  Widget _buildFeaturedProductsCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: featuredProductImages.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildCategoriesGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.2,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // Handle category tap
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(int.parse(categories[index]['color'])),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  IconData(categories[index]['icon'],
                      fontFamily: 'MaterialIcons'),
                  size: 40,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Text(
                  categories[index]['name'],
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPersonalizedRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personalized Recommendations',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: personalizedProducts.map((imageUrl) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Trending Items',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: trendingProductImages.map((imageUrl) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
