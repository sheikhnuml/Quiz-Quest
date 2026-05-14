import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  final String subject;
  final List<Map<String, dynamic>> questions;
  final List<int> userAnswers;

  const ReviewScreen({
    super.key,
    required this.subject,
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        title: Text('$subject Review',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2)),
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
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: const Icon(Icons.fact_check_rounded, color: Colors.white, size: 50),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Quest Summary',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Analyze your performance below',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final q = questions[index];
                final int correctIdx = q['answer'];
                final int userIdx = userAnswers[index];
                final bool isCorrect = userIdx == correctIdx;

                return Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isCorrect ? Colors.green[100] : Colors.red[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Question ${index + 1}',
                              style: TextStyle(
                                color: isCorrect ? Colors.green[800] : Colors.red[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Spacer(),
                          if (userIdx == -1)
                            const Icon(Icons.timer_off_outlined, color: Colors.orange, size: 18),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        q['question'],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.3),
                      ),
                      const SizedBox(height: 20),

                      ...List.generate(4, (optIdx) {
                        Color? tileColor;
                        Color? borderColor;
                        IconData? icon;

                        if (optIdx == correctIdx) {
                          tileColor = Colors.green[50];
                          borderColor = Colors.green[200];
                          icon = Icons.check_circle_rounded;
                        } else if (optIdx == userIdx && !isCorrect) {
                          tileColor = Colors.red[50];
                          borderColor = Colors.red[200];
                          icon = Icons.cancel_rounded;
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                          decoration: BoxDecoration(
                            color: tileColor ?? Colors.grey[50],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: borderColor ?? Colors.grey[200]!,
                              width: tileColor != null ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  q['options'][optIdx],
                                  style: TextStyle(
                                    color: tileColor != null
                                        ? (optIdx == correctIdx ? Colors.green[900] : Colors.red[900])
                                        : Colors.black87,
                                    fontWeight: tileColor != null ? FontWeight.bold : FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              if (icon != null)
                                Icon(icon, color: optIdx == correctIdx ? Colors.green : Colors.red, size: 22),
                            ],
                          ),
                        );
                      }),

                      if (userIdx == -1)
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 14),
                              SizedBox(width: 8),
                              Text(
                                'Time ran out! No answer was selected.',
                                style: TextStyle(color: Colors.orange, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                    ],
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