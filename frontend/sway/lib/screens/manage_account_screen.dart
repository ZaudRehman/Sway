//frontend\sway\lib\screens\manage_account_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sway/models/user.dart';
import 'package:sway/services/api_service.dart';

class ManageAccountScreen extends StatefulWidget {
  const ManageAccountScreen({super.key});

  @override
  _ManageAccountScreenState createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _email;
  late String _phoneNumber;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<User>(context, listen: false);
    _username = user.username;
    _email = user.email;
    _phoneNumber = user.phoneNumber;
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final user = Provider.of<User>(context, listen: false);
      user.updateUser(_username, _email, _phoneNumber);

      ApiService.updateUserProfile(user).then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update profile')),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _username,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                initialValue: _phoneNumber,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
