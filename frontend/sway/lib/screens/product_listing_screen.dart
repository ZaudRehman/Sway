//frontend\sway\lib\screens\product_listing_screen.dart
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sway/models/product.dart';

class ProductListingScreen extends StatelessWidget {
  const ProductListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductPaginationNotifier(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Listing'),
        ),
        body: const PagedListViewWidget(),
      ),
    );
  }
}

class PagedListViewWidget extends StatefulWidget {
  const PagedListViewWidget({super.key});

  @override
  _PagedListViewWidgetState createState() => _PagedListViewWidgetState();
}

class _PagedListViewWidgetState extends State<PagedListViewWidget> {
  final PagingController<int, Product> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<Product> newItems = await ApiService.fetchProducts(page: pageKey);
      final isLastPage = newItems.length < ApiService.itemsPerPage;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Product>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Product>(
        itemBuilder: (context, product, index) => _buildProductCard(product),
        firstPageErrorIndicatorBuilder: (context) => const Center(
          child: Text('Error fetching data'),
        ),
        noItemsFoundIndicatorBuilder: (context) => const Center(
          child: Text('No products found'),
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(product.imageUrl),
        title: Text(product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: \$${product.price.toStringAsFixed(2)}'),
            Text('Rating: ${product.rating}/5'),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Navigate to product details screen
            // Example: Navigator.pushNamed(context, '/product-details', arguments: product);
          },
          child: const Text('View Details'),
        ),
      ),
    );
  }
}

class ProductPaginationNotifier extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  void setProducts(List<Product> products) {
    _products = products;
    notifyListeners();
  }
}

class ApiService {
  static const String baseUrl = 'http://your-backend-api-url'; // Update with your API base URL
  static const int itemsPerPage = 10;

  static Future<List<Product>> fetchProducts({required int page}) async {
    final response = await http.get(Uri.parse('$baseUrl/products?page=$page'));

    if (response.statusCode == 200) {
      Iterable jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
