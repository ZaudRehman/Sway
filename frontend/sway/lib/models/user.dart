//frontend\sway\lib\models\user.dart
import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String id;
  String username;
  String email;
  String profilePictureUrl;
  String phoneNumber;
  List<Order> orders;
  List<Address> savedAddresses;
  bool _notificationsEnabled = true;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.profilePictureUrl,
    required this.phoneNumber,
    required this.orders,
    required this.savedAddresses,
  });

  // Factory constructor to create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    // Parse orders list from JSON
    List<Order> orders = [];
    if (json['orders'] != null) {
      orders = List<Order>.from(
          json['orders'].map((orderJson) => Order.fromJson(orderJson)));
    }

    // Parse saved addresses list from JSON
    List<Address> savedAddresses = [];
    if (json['savedAddresses'] != null) {
      savedAddresses = List<Address>.from(json['savedAddresses']
          .map((addressJson) => Address.fromJson(addressJson)));
    }

    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      profilePictureUrl: json['profilePictureUrl'],
      phoneNumber: json['phoneNumber'],
      orders: orders,
      savedAddresses: savedAddresses,
    );
  }

  bool get notificationsEnabled => _notificationsEnabled;

  void toggleNotifications(bool isEnabled) {
    _notificationsEnabled = isEnabled;
    notifyListeners();
  }

  void updateUser(String username, String email, String phoneNumber) {
    this.username = username;
    this.email = email;
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }
}

// Define Order class without ChangeNotifier mixin
class Order {
  final String orderId;
  final String productName;
  final int quantity;
  final double totalPrice;

  Order({
    required this.orderId,
    required this.productName,
    required this.quantity,
    required this.totalPrice,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      productName: json['productName'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'].toDouble(),
    );
  }
}

// Define Address class without ChangeNotifier mixin
class Address {
  final String addressId;
  final String street;
  final String city;
  final String state;
  final String postalCode;

  Address({
    required this.addressId,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressId: json['addressId'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
    );
  }
}

// Define UserData class for handling user-specific data and ChangeNotifier
class UserData with ChangeNotifier {
  String _username;
  String _email;
  String _phoneNumber;
  bool _notificationsEnabled;

  UserData({
    required String username,
    required String email,
    required String phoneNumber,
    required bool notificationsEnabled,
  })  : _username = username,
        _email = email,
        _phoneNumber = phoneNumber,
        _notificationsEnabled = notificationsEnabled;

  String get username => _username;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  bool get notificationsEnabled => _notificationsEnabled;

  void updateUser(String username, String email, String phoneNumber) {
    _username = username;
    _email = email;
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void toggleNotifications(bool isEnabled) {
    _notificationsEnabled = isEnabled;
    notifyListeners();
  }
}
