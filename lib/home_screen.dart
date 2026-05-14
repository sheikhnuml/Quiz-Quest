import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'course_menu.dart';
import 'login_screen.dart';
import 'user_history.dart';
import 'user_profile.dart';
import 'leaderboard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userBox = Hive.box('userBox');
    String name = userBox.get('currentName', defaultValue: 'Explorer');
    String email = userBox.get('currentEmail', defaultValue: 'user@quizquest.com');

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Quiz Quest',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          )
        ],
      ),

      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.indigo],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              accountName: Text(
                name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(email),
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.deepPurple),
                ),
              ),
            ),
            _drawerItem(Icons.history_rounded, 'My History', Colors.blue, () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (c) => const UserHistoryScreen()));
            }),

            _drawerItem(Icons.emoji_events_outlined, 'Leaderboard', Colors.amber, () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (c) => const LeaderboardScreen()));
            }),

            _drawerItem(Icons.person_outline_rounded, 'Profile', Colors.teal, () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (c) => const UserProfileScreen()));
            }),

            const Spacer(),
            const Divider(),
            _drawerItem(Icons.logout_rounded, 'Logout', Colors.red, () {
              userBox.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (c) => const LoginScreen()),
                    (route) => false,
              );
            }),
            const SizedBox(height: 10),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const Icon(Icons.rocket_launch_rounded, size: 80, color: Colors.white),
                  const SizedBox(height: 15),
                  Text(
                    'Welcome, $name!',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Ready to test your knowledge today?',
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  _mainButton(
                    context,
                    'START QUIZ',
                    Icons.play_circle_fill_rounded,
                    [Colors.orangeAccent, Colors.deepOrange],
                        () => Navigator.push(context, MaterialPageRoute(builder: (c) => const CourseMenuScreen())),
                  ),
                  const SizedBox(height: 20),
                  _mainButton(
                    context,
                    'VIEW HISTORY',
                    Icons.leaderboard_rounded,
                    [Colors.blueAccent, Colors.indigo],
                        () => Navigator.push(context, MaterialPageRoute(builder: (c) => const UserHistoryScreen())),
                  ),
                  const SizedBox(height: 20),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }

  Widget _mainButton(BuildContext context, String label, IconData icon, List<Color> gradientColors, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradientColors),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradientColors[1].withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(width: 20),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}