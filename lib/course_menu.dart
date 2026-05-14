import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'quiz_screen.dart';

class CourseMenuScreen extends StatelessWidget {
  const CourseMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userBox = Hive.box('userBox');
    String name = userBox.get('currentName', defaultValue: 'Explorer');

    final List<Map<String, dynamic>> subjects = [
      {
        'n': 'Maths',
        'i': Icons.calculate_rounded,
        'colors': [Colors.blueAccent, Colors.blue.shade900],
        'desc': 'Logic & Numbers'
      },
      {
        'n': 'Computer',
        'i': Icons.terminal_rounded,
        'colors': [Colors.purpleAccent, Colors.deepPurple],
        'desc': 'Code & Hardware'
      },
      {
        'n': 'English',
        'i': Icons.translate_rounded,
        'colors': [Colors.orangeAccent, Colors.orange.shade900],
        'desc': 'Grammar & Vocab'
      },
      {
        'n': 'Urdu',
        'i': Icons.menu_book_rounded,
        'colors': [Colors.greenAccent, Colors.green.shade800],
        'desc': 'Adab & Culture'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('SELECT SUBJECT', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 40),
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey $name!',
                  style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Your quest starts here.',
                  style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(25),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.82,
              ),
              itemCount: subjects.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => QuizScreen(subject: subjects[i]['n']))
                  ),
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: subjects[i]['colors'],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: (subjects[i]['colors'][1] as Color).withOpacity(0.35),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                          ),
                          child: Icon(subjects[i]['i'], color: Colors.white, size: 40),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          subjects[i]['n'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          subjects[i]['desc'],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}