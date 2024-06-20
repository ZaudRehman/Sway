//frontend\sway\lib\services\api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sway/models/user.dart';
import 'package:sway/models/product.dart';
import 'package:sway/models/notification.dart';
import 'package:sway/models/review.dart';
import 'package:sway/models/cart_item.dart';
import 'package:sway/models/order_details.dart';
import 'package:sway/models/recommendation.dart';
import 'package:sway/models/trending.dart';


class ApiService {
  static const String baseUrl = 'http://127.0.0.1:5000'; 

  static const String featuredProductsUrl = '$baseUrl/featured-products';
  static const String categoriesUrl = '$baseUrl/categories';
  static const String personalizedProductsUrl = '$baseUrl/personalized-products';
  static const String trendingProductsUrl = '$baseUrl/trending-products';
  static const String userUrl = '$baseUrl/user';
  static const String ordersUrl = '$baseUrl/orders';
  static const String addressesUrl = '$baseUrl/addresses';
  static const String productsUrl = '$baseUrl/products';
  static const String wishlistUrl = '$baseUrl/wishlist';
  static const String notificationsUrl = '$baseUrl/notifications';
  static const String signupUrl = '$baseUrl/signup';
  static const String loginUrl = '$baseUrl/login';
  static const String sendOtpUrl = '$baseUrl/send-otp';
  static const String verifyOtpUrl = '$baseUrl/verify-otp';

  // Fetch featured products from backend
  static Future<List<Product>> fetchFeaturedProducts() async {
    final response = await http.get(Uri.parse(featuredProductsUrl));
    if (response.statusCode == 200) {
      List<dynamic> productsJson = jsonDecode(response.body);
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load featured products');
    }
  }

  // Fetch categories from backend
  static Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse(categoriesUrl));
    if (response.statusCode == 200) {
      List<dynamic> categoriesJson = jsonDecode(response.body);
      return categoriesJson.cast<String>();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Fetch personalized products from backend
  static Future<List<Product>> fetchPersonalizedProducts() async {
    final response = await http.get(Uri.parse(personalizedProductsUrl));
    if (response.statusCode == 200) {
      List<dynamic> productsJson = jsonDecode(response.body);
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load personalized products');
    }
  }

  // Fetch trending products from backend
  

  // Fetch user details from backend
  static Future<User> fetchUserDetails() async {
    final response = await http.get(Uri.parse(userUrl));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user details');
    }
  }

  // Fetch user's orders from backend
    static Future<List<Order>> fetchUserOrders(String userId) async {
    final response = await http.get(Uri.parse('$ordersUrl?userId=$userId'));
    if (response.statusCode == 200) {
      List<dynamic> ordersJson = jsonDecode(response.body);
      return ordersJson.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user orders');
    }
  }

  // Fetch user's saved addresses from backend
  static Future<List<Address>> fetchUserAddresses() async {
    final response = await http.get(Uri.parse(addressesUrl));
    if (response.statusCode == 200) {
      List<dynamic> addressesJson = jsonDecode(response.body);
      return addressesJson.map((json) => Address.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user addresses');
    }
  }

  // Search products based on query
  static Future<List<Product>> searchProducts(String query) async {
    final response = await http.get(Uri.parse('$productsUrl?query=$query'));
    if (response.statusCode == 200) {
      List<dynamic> productsJson = jsonDecode(response.body);
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search products');
    }
  }

  // Fetch wishlist items from backend
  static Future<List<Product>> fetchWishlist() async {
    final response = await http.get(Uri.parse(wishlistUrl));
    if (response.statusCode == 200) {
      List<dynamic> wishlistJson = jsonDecode(response.body);
      return wishlistJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch wishlist items');
    }
  }

  // Remove item from wishlist
  static Future<void> removeFromWishlist(String productId) async {
    final response = await http.delete(Uri.parse('$wishlistUrl/$productId'));
    if (response.statusCode != 204) {
      throw Exception('Failed to remove item from wishlist');
    }
  }

  // Fetch notifications from backend
  static Future<List<NotificationModel>> fetchNotifications() async {
    final response = await http.get(Uri.parse(notificationsUrl));
    if (response.statusCode == 200) {
      List<dynamic> notificationsJson = jsonDecode(response.body);
      return notificationsJson.map((json) => NotificationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch notifications');
    }
  }

  // Mark notification as read
  static Future<void> markNotificationAsRead(String notificationId) async {
    final response = await http.put(Uri.parse('$notificationsUrl/$notificationId/read'));
    if (response.statusCode != 204) {
      throw Exception('Failed to mark notification as read');
    }
  }

  // Delete notification from backend
  static Future<void> deleteNotification(String notificationId) async {
    final response = await http.delete(Uri.parse('$notificationsUrl/$notificationId'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete notification');
    }
  }

  // Fetch reviews for a product from backend
  static Future<List<Review>> fetchReviews(String productId) async {
    final response = await http.get(Uri.parse('$productsUrl/$productId/reviews'));
    if (response.statusCode == 200) {
      List<dynamic> reviewsJson = jsonDecode(response.body);
      return reviewsJson.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch reviews');
    }
  }

  // Post a new review for a product to backend
  static Future<void> postReview(String productId, Review review) async {
    final response = await http.post(
      Uri.parse('$productsUrl/$productId/reviews'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(review.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to post review');
    }
  }

  // Update user profile details on backend
  static Future<bool> updateUserProfile(User user) async {
    final response = await http.put(
      Uri.parse('$userUrl/profile'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': user.username,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Send message to backend for chat feature
  static Future<void> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/chat/send'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }

  // Submit contact form details to backend
  static Future<void> submitContactForm(String name, String email, String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/contact/submit'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'message': message,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit contact form');
    }
  }

  // User sign up request to backend
  static Future<void> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to login');
    }
  }

  static Future<void> signUp(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to sign up');
    }
  }

  static Future<void> sendOTP(String email) async {
    final url = Uri.parse('$baseUrl/auth/send-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send OTP');
    }
  }

  static Future<bool> verifyOTP(String email, String otp) async {
    final url = Uri.parse('$baseUrl/auth/verify-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'otp': otp}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Place an order with the provided order details
  static Future<OrderResponse> placeOrder(OrderDetails orderDetails) async {
    final url = Uri.parse(ordersUrl);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(orderDetails.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return OrderResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to place order');
    }
  }


  // Validate a coupon code and get discount details
  static Future<CouponResponse> validateCoupon(String couponCode) async {
    final url = Uri.parse('$baseUrl/coupons/$couponCode');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return CouponResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to validate coupon');
    }
  }

  // Apply a discount to cart items based on the provided amount
// Renamed method for applying a manual discount
  static Future<void> calculateManualDiscount(
      double discountAmount, List<CartItem> cartItems) async {
    if (cartItems.isEmpty) return; // No items to apply discount to

    final double discountPerItem = discountAmount / cartItems.length;

    for (var item in cartItems) {
      double discountedPrice = item.price - discountPerItem;
      if (discountedPrice < 0) {
        discountedPrice = 0; // Ensure price doesn't go negative
      }
      item.price = discountedPrice;
    }
  }

  static Future<List<CartItem>> getCartItems() async {
    final response =
        await http.get(Uri.parse('https://your-api.com/api/cart/items'));
    if (response.statusCode == 200) {
      List<dynamic> cartItemsJson = json.decode(response.body);
      return cartItemsJson.map((item) => CartItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load cart items');
    }
  }


  static Future<DiscountResponse> applyDiscount(String couponCode, List<CartItem> cartItems, double totalCost) async {
    final response = await http.post(
      Uri.parse('https://your-api.com/api/discount'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'couponCode': couponCode,
        'cartItems': cartItems.map((item) => item.toJson()).toList(),
        'totalCost': totalCost,
      }),
    );
    if (response.statusCode == 200) {
      return DiscountResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to apply discount');
    }
  }

  Future<List<Recommendation>> fetchRecommendations() async {
    final response = await http.get(Uri.parse('$baseUrl/recommendations'));

    if (response.statusCode == 200) {
      List<dynamic> recommendationsJson = json.decode(response.body);
      return recommendationsJson
          .map((json) => Recommendation.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load recommendations');
    }
  }

  Future<List<Trending>> fetchTrendingProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/trending'));

    if (response.statusCode == 200) {
      List<dynamic> trendingJson = json.decode(response.body);
      return trendingJson.map((json) => Trending.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load trending products');
    }
  }
}

class DiscountResponse {
  final bool isValid;
  final double newTotalCost;

  DiscountResponse({required this.isValid, required this.newTotalCost});

  factory DiscountResponse.fromJson(Map<String, dynamic> json) {
    return DiscountResponse(
      isValid: json['isValid'],
      newTotalCost: json['newTotalCost'],
    );
  }
}

class OrderResponse {
  final String orderId;
  final double totalAmount;
  final DateTime orderDate;
  final bool isSuccess;
  final Order order;

  OrderResponse({
    required this.orderId,
    required this.totalAmount,
    required this.orderDate,
    required this.isSuccess,
    required this.order
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      orderId: json['orderId'],
      totalAmount: json['totalAmount'].toDouble(),
      orderDate: DateTime.parse(json['orderDate']),
      isSuccess: json['isSuccess'],
      order: Order.fromJson(json['order']),
    );
  }
}

class CouponResponse {
  final String couponCode;
  final double discountAmount;
  final DateTime expiryDate;

  CouponResponse({
    required this.couponCode,
    required this.discountAmount,
    required this.expiryDate,
  });

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      couponCode: json['couponCode'],
      discountAmount: json['discountAmount'].toDouble(),
      expiryDate: DateTime.parse(json['expiryDate']),
    );
  }
}
