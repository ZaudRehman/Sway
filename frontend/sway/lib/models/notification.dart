//frontend\sway\lib\models\notification.dart
class NotificationModel {
  final String id;
  final String title;
  final String date;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.date,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      isRead: json['isRead'] ?? false,
    );
  }
}
