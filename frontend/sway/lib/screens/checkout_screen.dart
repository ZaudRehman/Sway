//frontend\sway\lib\screens\checkout_screen.dart
import 'package:flutter/material.dart';
import 'package:sway/models/cart_item.dart'; // Import your CartItem model

class CheckoutScreen extends StatelessWidget {
  final List<CartItem>
      cartItems; // Assuming this list is populated somewhere in your app
  final double totalCost; // Total cost of items in the cart

  const CheckoutScreen({super.key, required this.cartItems, required this.totalCost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Shipping Address Section
            const Text(
              'Shipping Address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Add your form fields for shipping address here

            // Payment Method Section
            const SizedBox(height: 24),
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Add your payment method selection (e.g., radio buttons) here

            // Order Summary Section
            const SizedBox(height: 24),
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Display cart items with details
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(cartItems[index].imageUrl),
                  title: Text(cartItems[index].name),
                  subtitle: Text(
                      '${cartItems[index].quantity} x \$${cartItems[index].price.toStringAsFixed(2)}'),
                  trailing: Text(
                      '\$${(cartItems[index].price * cartItems[index].quantity).toStringAsFixed(2)}'),
                );
              },
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            // Display total cost
            Text(
              'Total: \$${totalCost.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // Terms and Conditions Section
            const SizedBox(height: 24),
            Row(
              children: [
                Checkbox(
                  value: false, // Example value
                  onChanged: (value) {
                    // Handle checkbox state change
                  },
                ),
                const Text('I agree to the Terms & Conditions'),
              ],
            ),

            // Place Order Button
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Logic to place the order
              },
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
