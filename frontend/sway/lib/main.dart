//frontend\sway\lib\main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:sway/models/order_details.dart';
import 'services/product_service.dart';
import 'screens/auth_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/categories_screen.dart' as category;
import 'screens/chat_support_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/home_screen.dart' as home;
import 'screens/manage_account_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/order_confirmation_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/product_listing_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/review_ratings_screen.dart';
import 'screens/search_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/social_sharing_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/wishlist_screen.dart';
import 'package:sway/models/product.dart';
import 'package:sway/models/cart_item.dart';
import 'package:sway/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:sway/screens/recommendations_screen.dart';
import 'package:sway/screens/trending_screen.dart';
import 'package:sway/widgets/bottom_nav_bar.dart' as bottomnav;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String productId = 'some_product_id';

  MyApp({Key? key});

  Future<List<CartItem>> get cartItems async => await _fetchCartItems();
  Future<Product> get product async => await _fetchProduct(productId);
  Future<double> getTotalCost(List<CartItem> cartItems) async =>
      _calculateTotalCost(cartItems);
  Future<Order> getOrder(OrderDetails orderDetails) async =>
      await _fetchOrder(orderDetails);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProductService>(create: (_) => ProductService()),
      ],
      child: MaterialApp(
        title: 'Sway',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/auth': (context) =>
              AuthScreen(onLoginSuccess: _handleAuthenticationSuccess),
          '/home': (context) => _isLoggedIn
              ? MainScreen()
              : AuthScreen(onLoginSuccess: _handleAuthenticationSuccess),
          '/categories': (context) => const category.CategoriesScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/cart': (context) => const CartScreen(),
          '/wishlist': (context) => const WishlistScreen(),
          '/notifications': (context) => const NotificationsScreen(),
          '/search': (context) => const SearchScreen(),
          '/product-listing': (context) => const ProductListingScreen(),
          '/product-detail': (context) => FutureBuilder<Product>(
                future: product,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return ProductDetailScreen(product: snapshot.data!);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
          '/checkout': (context) => FutureBuilder<List<CartItem>>(
                future: cartItems,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return CheckoutScreen(
                        cartItems: snapshot.data!,
                        totalCost: _calculateTotalCost(snapshot.data!));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
          '/order-confirmation': (context) => FutureBuilder<Order>(
                future: getOrder(OrderDetails(
                    totalCost: 0, cartItems: [])), // Pass correct OrderDetails
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return OrderConfirmationScreen(order: snapshot.data!);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
          '/settings': (context) => const SettingsScreen(),
          '/social-sharing': (context) => FutureBuilder<Product>(
                future: product,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return SocialSharingScreen(product: snapshot.data!);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
          '/review-ratings': (context) => FutureBuilder<Product>(
                future: product,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return ReviewsRatingsScreen(product: snapshot.data!);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
          '/chat-support': (context) => const ChatSupportScreen(),
          '/manage-account': (context) => const ManageAccountScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
              builder: (context) => const NotFoundScreen());
        },
      ),
    );
  }

  Future<List<CartItem>> _fetchCartItems() async {
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:5000/api/cart/items'));

      if (response.statusCode == 200) {
        List<dynamic> cartItemsJson = json.decode(response.body);
        return cartItemsJson.map((item) => CartItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load cart items');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Product> _fetchProduct(String productId) async {
    try {
      final response = await http
          .get(Uri.parse('http://127.0.0.1:5000/api/products/$productId'));

      if (response.statusCode == 200) {
        Map<String, dynamic> productJson = json.decode(response.body);
        return Product.fromJson(productJson);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  double _calculateTotalCost(List<CartItem> cartItems) {
    return cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  Future<Order> _fetchOrder(OrderDetails orderDetails) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/api/orders'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(orderDetails.toJson()),
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> orderJson = json.decode(response.body);
        return Order.fromJson(orderJson);
      } else {
        throw Exception('Failed to create order');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  bool _isLoggedIn = false; 
  void _handleAuthenticationSuccess() {
    _isLoggedIn = true;
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const bottomnav.HomeScreen(),
    const bottomnav.CategoriesScreen(),
    const RecommendationsScreen(),
    const TrendingScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sway'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: bottomnav.BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('Page not found!'),
      ),
    );
  }
}
