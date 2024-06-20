//frontend\sway\lib\screens\notification_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Import ApiService
import 'package:sway/models/notification.dart'; // Import Notification model

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> _notifications = []; // List to store notifications

  @override
  void initState() {
    super.initState();
    // Fetch notifications when screen initializes
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      List<NotificationModel> notifications =
          await ApiService.fetchNotifications();
      setState(() {
        _notifications = notifications;
      });
    } catch (e) {
      print('Error fetching notifications: $e');
      // Handle error, e.g., show error message to user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: _notifications.isEmpty
          ? const Center(
              child: Text('No notifications to display.'),
            )
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationItem(_notifications[index]);
              },
            ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    return ListTile(
      title: Text(notification.title),
      subtitle: Text(notification.date),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          _deleteNotification(notification);
        },
      ),
      onTap: () {
        _markNotificationAsRead(notification);
        // Navigate to detailed notification screen or perform other actions
      },
    );
  }

  void _markNotificationAsRead(NotificationModel notification) async {
    try {
      await ApiService.markNotificationAsRead(notification.id);
      setState(() {
        notification.isRead = true;
      });
    } catch (e) {
      print('Error marking notification as read: $e');
      // Handle error, e.g., show error message to user
    }
  }

  void _deleteNotification(NotificationModel notification) async {
    try {
      await ApiService.deleteNotification(notification.id);
      setState(() {
        _notifications.remove(notification);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notification deleted.'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error deleting notification: $e');
      // Handle error, e.g., show error message to user
    }
  }
}
