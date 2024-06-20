//frontend\sway\lib\screens\settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sway/models/user.dart';
import 'package:sway/screens/manage_account_screen.dart';
import 'package:sway/providers/theme_provider.dart';
import 'package:sway/providers/language_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  String selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    selectedLanguage =
        Provider.of<LanguageProvider>(context, listen: false).language;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('General Settings'),
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              });
            },
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(selectedLanguage),
            onTap: () => _selectLanguage(context),
          ),
          const Divider(),
          const ListTile(
            title: Text('Account Settings'),
          ),
          ListTile(
            title: const Text('Manage Account'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ManageAccountScreen()), // Assume ManageAccountScreen is defined elsewhere
              );
            },
          ),
          const Divider(),
          const ListTile(
            title: Text('App Settings'),
          ),
          SwitchListTile(
            title: const Text('Notifications'),
            value: Provider.of<User>(context).notificationsEnabled,
            onChanged: (value) {
              setState(() {
                Provider.of<User>(context, listen: false)
                    .toggleNotifications(value);
              });
            },
          ),
        ],
      ),
    );
  }

  void _selectLanguage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: SingleChildScrollView(
          child: ListBody(
            children: ['English', 'Spanish', 'French', 'German']
                .map((lang) => RadioListTile(
                      title: Text(lang),
                      value: lang,
                      groupValue: selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value!;
                          Provider.of<LanguageProvider>(context, listen: false)
                              .setLanguage(value);
                        });
                        Navigator.pop(context);
                      },
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
