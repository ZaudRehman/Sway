// lib/screens/trending_screen.dart

import 'package:flutter/material.dart';
import 'package:sway/models/trending.dart';
import 'package:sway/services/api_service.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  late Future<List<Trending>> _trendingFuture;

  @override
  void initState() {
    super.initState();
    _trendingFuture = ApiService().fetchTrendingProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending'),
      ),
      body: FutureBuilder<List<Trending>>(
        future: _trendingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load trending products'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No trending products found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final trending = snapshot.data![index];
                return ListTile(
                  leading: Image.network(trending.imageUrl),
                  title: Text(trending.name),
                  subtitle: Text('\$${trending.price.toStringAsFixed(2)}'),
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
