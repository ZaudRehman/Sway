//frontend\sway\lib\screens\order_confirmation_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting (optional)
import 'package:sway/models/order.dart'; // Import your Order model

class OrderConfirmationScreen extends StatelessWidget {
  final Order order; // Assuming Order class is defined with necessary fields

  const OrderConfirmationScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Order Details Section
            const Text(
              'Order Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Display ordered items
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(order.items[index].imageUrl),
                  title: Text(order.items[index].name),
                  subtitle: Text('Quantity: ${order.items[index].quantity}'),
                );
              },
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            // Estimated Delivery Date and Tracking Link
            const Text(
              'Estimated Delivery Date',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('MMMM dd, yyyy').format(order.estimatedDeliveryDate),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Implement tracking logic or open tracking link
              },
              child: const Text(
                'Track Order',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 24),
            // Order Number and Status
            const Text(
              'Order Number',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              order.orderNumber,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Order Status: ${order.status}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            // Contact Support and Share Order buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement contact support logic
                  },
                  child: const Text('Contact Support'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement share order logic
                  },
                  child: const Text('Share Order'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
