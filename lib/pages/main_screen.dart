import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soccer_predict_admin/controller/provider.dart';
import 'package:soccer_predict_admin/pages/add_delete.dart';
import 'package:soccer_predict_admin/pages/fixtures.dart';
import 'package:soccer_predict_admin/pages/results.dart';
import 'package:soccer_predict_admin/pages/standings.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Pages
    const bodies = [
      StandingsPage(),
      FixturesPage(),
      ResultsPage(),
      AddDeletePage()
    ];
    final pageNames = [
      'Standings',
      'Fixtures',
      'Results',
      'Update Info'
    ];
    // For Provider
    final indexBottomNavBar = ref.watch(indexBottomNavbarProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pageNames[indexBottomNavBar],
          style: TextStyle(
            color: Colors.grey[50],
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavBar,
        selectedItemColor: Colors.grey[300],
        unselectedItemColor: Colors.grey[500],
        backgroundColor: Colors.grey[700],
        onTap: (value) {
          ref.read(indexBottomNavbarProvider.notifier).update((state) => value);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'Standings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.event), label: 'Fixtures'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Results'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Update Info'),
        ],
      ),
      body: bodies[indexBottomNavBar]
    );
  }
}
