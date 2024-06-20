//frontend\sway\lib\screens\review_ratings_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Import ApiService
import 'package:sway/models/product.dart'; // Import Product model
import 'package:sway/models/review.dart';

class ReviewsRatingsScreen extends StatefulWidget {
  final Product
      product; // Assume Product class is defined with necessary fields

  const ReviewsRatingsScreen({super.key, required this.product});

  @override
  _ReviewsRatingsScreenState createState() => _ReviewsRatingsScreenState();
}

class _ReviewsRatingsScreenState extends State<ReviewsRatingsScreen> {
  List<Review> _reviews = []; // List to store reviews
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Fetch reviews when screen initializes
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      List<Review> reviews = await ApiService.fetchReviews(widget.product.id);
      setState(() {
        _reviews = reviews;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching reviews: $e');
      // Handle error, e.g., show error message to user
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews & Ratings'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _reviews.isEmpty
              ? const Center(
                  child: Text('No reviews yet. Be the first to write one!'))
              : ListView.builder(
                  itemCount: _reviews.length,
                  itemBuilder: (context, index) {
                    return _buildReviewItem(_reviews[index]);
                  },
                ),
    );
  }

  Widget _buildReviewItem(Review review) {
    return ListTile(
      title: Text(review.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Rating: ${review.rating}'),
              const SizedBox(width: 10),
              Text('Date: ${review.date}'),
            ],
          ),
          const SizedBox(height: 8),
          Text(review.body),
        ],
      ),
    );
  }
}
