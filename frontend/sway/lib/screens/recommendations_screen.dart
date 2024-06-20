// lib/screens/recommendations_screen.dart

import 'package:flutter/material.dart';
import 'package:sway/models/recommendation.dart';
import 'package:sway/services/api_service.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  _RecommendationsScreenState createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  late Future<List<Recommendation>> _recommendationsFuture;

  @override
  void initState() {
    super.initState();
    _recommendationsFuture = ApiService().fetchRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendations'),
      ),
      body: FutureBuilder<List<Recommendation>>(
        future: _recommendationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load recommendations'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recommendations found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recommendation = snapshot.data![index];
                return ListTile(
                  leading: Image.network(recommendation.imageUrl),
                  title: Text(recommendation.name),
                  subtitle:
                      Text('\$${recommendation.price.toStringAsFixed(2)}'),
                  onTap: () {
                    // Navigate to product detail page
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
