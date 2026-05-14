import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  List<Map<String, dynamic>> _getAllSubjectAttempts(String subject) {
    var accounts = Hive.box('accountsBox');
    var history = Hive.box('historyBox');
    List<Map<String, dynamic>> allAttempts = [];

    for (var record in history.values) {
      if (record['subject'] == subject) {
        var user = accounts.get(record['email']);
        String name = user != null ? user['name'] : 'Unknown';

        allAttempts.add({
          'name': name,
          'email': record['email'],
          'score': record['score'],
          'date': record['date'],
          'answers': record['answers'],
        });
      }
    }

    allAttempts.sort((a, b) => b['score'].compareTo(a['score']));
    return allAttempts;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('LEADERBOARD', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.amber,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            tabs: [
              Tab(text: 'MATHS'),
              Tab(text: 'COMPUTER'),
              Tab(text: 'ENGLISH'),
              Tab(text: 'URDU'),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: const Column(
                children: [
                  Icon(Icons.emoji_events_rounded, size: 60, color: Colors.amber),
                  SizedBox(height: 10),
                  Text(
                    'Subject Rankings',
                    style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildRankList('Maths'),
                  _buildRankList('Computer'),
                  _buildRankList('English'),
                  _buildRankList('Urdu'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankList(String subject) {
    final attempts = _getAllSubjectAttempts(subject);

    if (attempts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.quiz_outlined, size: 60, color: Colors.grey[300]),
            const SizedBox(height: 10),
            Text('No attempts for $subject yet!', style: const TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      itemCount: attempts.length,
      itemBuilder: (context, index) {
        final attempt = attempts[index];
        bool isTop3 = index < 3;

        return Container(
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
            leading: CircleAvatar(
              backgroundColor: index == 0
                  ? Colors.amber
                  : index == 1
                  ? Colors.grey[300]
                  : index == 2
                  ? Colors.orange[300]
                  : Colors.deepPurple[50],
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isTop3 ? Colors.black87 : Colors.deepPurple,
                ),
              ),
            ),
            title: Text(
              attempt['name'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),

            subtitle: Text(
              'Played on: ${attempt['date']}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${attempt['score']}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                const Text('Score', style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
        );
      },
    );
  }
}