import 'package:flutter/material.dart';
import 'package:flutter_mini_project/screens/home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPage = 0;

  void _changePage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  final _listPage = [
    const HomeScreen(),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Create'),
    ),
    const Center(
      child: Text('Saved'),
    ),
    const Center(
      child: Text('Profile'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: SingleChildScrollView(
          child: _listPage[_selectedPage],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedPage,
        selectedItemColor: const Color.fromARGB(255, 23, 47, 69),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _changePage,
      ),
    );
  }
}
