import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameC;
  late TextEditingController _phoneC;
  late TextEditingController _subjectC;
  late TextEditingController _passC;
  late String _email;

  @override
  void initState() {
    super.initState();
    var userBox = Hive.box('userBox');
    var accounts = Hive.box('accountsBox');

    _email = userBox.get('currentEmail');
    var userData = accounts.get(_email);

    _nameC = TextEditingController(text: userData['name']);
    _phoneC = TextEditingController(text: userData['phone'] ?? '');
    _subjectC = TextEditingController(text: userData['subject'] ?? '');
    _passC = TextEditingController(text: userData['password']);
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

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      var accounts = Hive.box('accountsBox');
      var userBox = Hive.box('userBox');

      await accounts.put(_email, {
        'name': _nameC.text,
        'email': _email,
        'password': _passC.text,
        'phone': _phoneC.text,
        'subject': _subjectC.text,
        'age': accounts.get(_email)['age'],
      });

      await userBox.put('currentName', _nameC.text);

      if (mounted) {
        _showAestheticSnack('Profile Updated Successfully!', Icons.verified_user_rounded, Colors.teal);

        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) Navigator.pop(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('MY PROFILE', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 60, color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 15),
                  Text(_email, style: const TextStyle(color: Colors.white70, fontSize: 16)),
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
                    _buildEditField(_nameC, 'Full Name', Icons.person_outline),
                    const SizedBox(height: 15),
                    _buildEditField(_phoneC, 'Phone Number', Icons.phone_android_outlined, type: TextInputType.phone),
                    const SizedBox(height: 15),
                    _buildEditField(_subjectC, 'Favorite Subject', Icons.book_outlined),
                    const SizedBox(height: 15),
                    _buildEditField(_passC, 'Password', Icons.lock_outline, obscure: false),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 5,
                        ),
                        onPressed: _updateProfile,
                        child: const Text('SAVE CHANGES', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
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

  Widget _buildEditField(TextEditingController controller, String label, IconData icon, {TextInputType type = TextInputType.text, bool obscure = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (v) => (v == null || v.isEmpty) ? 'Cannot be empty' : null,
    );
  }
}