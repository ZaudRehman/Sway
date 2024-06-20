//frontend\sway\lib\screens\social_sharing_screen.dart
import 'package:flutter/material.dart';
import 'package:sway/models/product.dart'; // Import Product model
import 'package:share_plus/share_plus.dart'; // For social sharing functionality

class SocialSharingScreen extends StatelessWidget {
  final Product
      product; // Assume Product class is defined with necessary fields

  const SocialSharingScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display product details
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Image.network(
              product.imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Social sharing buttons
            ElevatedButton.icon(
              onPressed: () => _shareOnSocialMedia('Facebook'),
              icon: const Icon(Icons.facebook),
              label: const Text('Share on Facebook'),
            ),
            ElevatedButton.icon(
              onPressed: () => _shareOnSocialMedia('Twitter'),
              icon: const Icon(Icons.camera_front),
              label: const Text('Share on Twitter'),
            ),
            ElevatedButton.icon(
              onPressed: () => _shareOnSocialMedia('WhatsApp'),
              icon: const Icon(Icons.chat),
              label: const Text('Share on WhatsApp'),
            ),
          ],
        ),
      ),
    );
  }

  // Method to share product on social media using SharePlus package
  void _shareOnSocialMedia(String platform) {
    String message =
        'Check out this amazing product: ${product.name}\n${product.description}\n${product.imageUrl}';

    if (platform == 'Facebook') {
      Share.share(message, subject: 'Share Product');
    } else if (platform == 'Twitter') {
      Share.share(message, subject: 'Share Product via Twitter');
    } else if (platform == 'WhatsApp') {
      Share.share(message, subject: 'Share Product via WhatsApp');
    }
  }
}
