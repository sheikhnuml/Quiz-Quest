import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'login_screen.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameC = TextEditingController();
  final _ageC = TextEditingController();
  final _emailC = TextEditingController();
  final _phoneC = TextEditingController();
  final _subjectC = TextEditingController();
  final _passC = TextEditingController();

  bool _isObscure = true;

  @override
  void dispose() {
    _nameC.dispose(); _ageC.dispose(); _emailC.dispose();
    _phoneC.dispose(); _subjectC.dispose(); _passC.dispose();
    super.dispose();
  }

  void _showAestheticSnack(String message, IconData icon, Color color) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.indigo],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
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
                    child: const Icon(Icons.person_add_rounded, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'JOIN THE QUEST',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const Text(
                    'Create your profile to start learning',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildInput(_nameC, 'Full Name', Icons.person_outline),
                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(child: _buildInput(_ageC, 'Age', Icons.cake_outlined, type: TextInputType.number)),
                        const SizedBox(width: 15),
                        Expanded(child: _buildInput(_subjectC, 'Subject', Icons.book_outlined)),
                      ],
                    ),
                    const SizedBox(height: 15),

                    _buildInput(_emailC, 'Email Address', Icons.email_outlined, type: TextInputType.emailAddress),
                    const SizedBox(height: 15),

                    _buildInput(_phoneC, 'Phone Number', Icons.phone_android_outlined, type: TextInputType.phone),
                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _passC,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_open_rounded, color: Colors.deepPurple),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                          onPressed: () => setState(() => _isObscure = !_isObscure),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (v) => (v == null || v.length < 6) ? 'Password must be 6+ chars' : null,
                    ),

                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 8,
                          shadowColor: Colors.deepPurple.withOpacity(0.4),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var accounts = Hive.box('accountsBox');
                            if (accounts.containsKey(_emailC.text)) {
                              // Modern Snack for Error
                              _showAestheticSnack('Email already exists! Please login.', Icons.warning_amber_rounded, Colors.orange);
                            } else {
                              await accounts.put(_emailC.text, {
                                'name': _nameC.text,
                                'email': _emailC.text,
                                'password': _passC.text,
                                'age': _ageC.text,
                                'phone': _phoneC.text,
                                'subject': _subjectC.text,
                              });

                              _showAestheticSnack('Account created! Welcome to Quiz Quest.', Icons.check_circle_rounded, Colors.green);

                              Future.delayed(const Duration(seconds: 1), () {
                                if (mounted) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const LoginScreen()));
                                }
                              });
                            }
                          }
                        },
                        child: const Text('CREATE ACCOUNT', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                      ),
                    ),

                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const LoginScreen())),
                      child: const Text("Already a member? Login here", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String label, IconData icon, {TextInputType type = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
    );
  }
}