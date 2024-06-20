//frontend\sway\lib\models\review.dart
class Review {
  final String id;
  final String productId;
  final String title;
  final String body;
  final int rating;
  final String date;

  Review({
    required this.id,
    required this.productId,
    required this.title,
    required this.body,
    required this.rating,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      productId: json['productId'],
      title: json['title'],
      body: json['body'],
      rating: json['rating'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'body': body,
      'rating': rating,
      'date': DateTime.now()
          .toIso8601String(), // Use current date as ISO 8601 string
    };
  }
}
