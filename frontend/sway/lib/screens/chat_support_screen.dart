//frontend\sway\lib\screens\chat_support_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:expandable/expandable.dart';
import 'package:sway/services/api_service.dart'; 

class ChatSupportScreen extends StatefulWidget {
  const ChatSupportScreen({super.key});

  @override
  _ChatSupportScreenState createState() => _ChatSupportScreenState();
}

class _ChatSupportScreenState extends State<ChatSupportScreen> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: 'user_id');

  @override
  void initState() {
    super.initState();

  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: _messages.length.toString(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });


    ApiService.sendMessage(message.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Chat'),
                Tab(text: 'FAQ'),
                Tab(text: 'Contact'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildChatTab(),
                  _buildFAQTab(),
                  _buildContactTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatTab() {
    return Chat(
      messages: _messages,
      onSendPressed: _handleSendPressed,
      user: _user,
    );
  }

  Widget _buildFAQTab() {
    return ListView(
      children: [
        _buildFAQItem('How to place an order?', 'To place an order, follow these steps...'),
        _buildFAQItem('How to track my order?', 'To track your order, go to...'),
    
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return ExpandablePanel(
      header: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(question, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      collapsed: Container(),
      expanded: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(answer),
      ),
    );
  }

  Widget _buildContactTab() {
    final formKey = GlobalKey<FormState>();
    String name = '';
    String email = '';
    String message = '';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) {
                name = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onSaved: (value) {
                email = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Message'),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
              onSaved: (value) {
                message = value!;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  // Send the contact form data to your backend
                  ApiService.submitContactForm(name, email, message);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message sent!')));
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
