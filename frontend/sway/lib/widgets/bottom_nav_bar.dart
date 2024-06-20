//frontend\sway\lib\widgets\bottom_nav_bar.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sway',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CategoriesScreen(),
    const RecommendationsScreen(),
    const TrendingScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sway'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view, color: Colors.black),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bolt_rounded, color: Colors.black),
          label: 'Recommendations',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up, color: Colors.black),
          label: 'Trending',
        ),
      ],
    );
  }
}

// Placeholder screens for each tab
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Screen'),
    );
  }
}

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Categories Screen'),
    );
  }
}

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Recommendations Screen'),
    );
  }
}

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Trending Screen'),
    );
  }
}
