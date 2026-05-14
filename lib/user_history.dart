import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'review_screen.dart';
import 'quiz_data.dart';

class UserHistoryScreen extends StatelessWidget {
  const UserHistoryScreen({super.key});

  void _showAestheticSnack(BuildContext context, String message, IconData icon, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.95),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _confirmDelete(BuildContext context, Box box, dynamic key) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: const Text('Delete Record?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to remove this quiz record? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              box.delete(key);
              Navigator.pop(c);

              _showAestheticSnack(context, 'Record deleted successfully', Icons.delete_sweep_rounded, Colors.redAccent);
            },
            child: const Text('DELETE'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userBox = Hive.box('userBox');
    String currentEmail = userBox.get('currentEmail', defaultValue: '');

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('MY PROGRESS', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
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
            child: const Column(
              children: [
                Icon(Icons.history_edu_rounded, size: 60, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  'Quest History',
                  style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Long press to delete a record',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box('historyBox').listenable(),
              builder: (context, Box box, _) {
                final Map<dynamic, dynamic> rawMap = box.toMap();
                final list = rawMap.entries
                    .where((e) => e.value['email'] == currentEmail)
                    .toList()
                    .reversed
                    .toList();

                if (list.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_fix_off_rounded, size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 20),
                        const Text(
                          'No records found yet!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (c, i) {
                    final record = list[i].value;
                    final dynamic recordKey = list[i].key;
                    final Color subjectColor = _getSubjectColor(record['subject']);

                    return InkWell(
                      onTap: () {
                        if (record['answers'] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewScreen(
                                subject: record['subject'],
                                questions: QuizData.questions[record['subject']]!,
                                userAnswers: List<int>.from(record['answers']),
                              ),
                            ),
                          );
                        }
                      },
                      onLongPress: () => _confirmDelete(context, box, recordKey),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          leading: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: subjectColor.withOpacity(0.1), shape: BoxShape.circle),
                            child: Icon(_getSubjectIcon(record['subject']), color: subjectColor, size: 30),
                          ),
                          title: Text(record['subject'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          subtitle: Text('Date: ${record['date']}', style: const TextStyle(color: Colors.grey)),
                          trailing: Text(
                            '${record['score']}/10',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: record['score'] >= 7 ? Colors.green : Colors.orange,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getSubjectColor(String subject) {
    switch (subject) {
      case 'Maths': return Colors.blue;
      case 'Computer': return Colors.purple;
      case 'English': return Colors.orange;
      case 'Urdu': return Colors.green;
      default: return Colors.deepPurple;
    }
  }

  IconData _getSubjectIcon(String subject) {
    switch (subject) {
      case 'Maths': return Icons.calculate_rounded;
      case 'Computer': return Icons.terminal_rounded;
      case 'English': return Icons.translate_rounded;
      case 'Urdu': return Icons.menu_book_rounded;
      default: return Icons.quiz_rounded;
    }
  }
}