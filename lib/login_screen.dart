import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'home_screen.dart';
import 'user_details.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  // --- Step 1: New variable for Remember Me ---
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  // --- Step 2: Load saved data on Startup ---
  void _loadSavedCredentials() {
    var userBox = Hive.box('userBox');
    String? savedEmail = userBox.get('rememberedEmail');
    String? savedPass = userBox.get('rememberedPassword');

    if (savedEmail != null && savedPass != null) {
      setState(() {
        _emailC.text = savedEmail;
        _passC.text = savedPass;
        _rememberMe = true;
      });
    }
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
              BoxShadow(color: color.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5)),
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

  void _login() async {
    if (_formKey.currentState!.validate()) {
      var accounts = Hive.box('accountsBox');
      var userBox = Hive.box('userBox');

      var userData = accounts.get(_emailC.text);

      if (userData != null && userData['password'] == _passC.text) {
        userBox.put('currentEmail', _emailC.text);
        userBox.put('currentName', userData['name']);

        // --- Step 3: Save or Clear Credentials based on Checkbox ---
        if (_rememberMe) {
          userBox.put('rememberedEmail', _emailC.text);
          userBox.put('rememberedPassword', _passC.text);
        } else {
          userBox.delete('rememberedEmail');
          userBox.delete('rememberedPassword');
        }

        _showAestheticSnack('Welcome back, ${userData['name']}!', Icons.waving_hand_rounded, Colors.green);

        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
          }
        });
      } else {
        _showAestheticSnack('Invalid Email or Password!', Icons.error_outline_rounded, Colors.redAccent);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Header Section (Unchanged) ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 80),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.indigo],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.2))),
                    child: const Icon(Icons.explore_rounded, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text('QUIZ QUEST', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 3)),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text('Welcome Back!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 40),

                    TextFormField(
                      controller: _emailC,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: const Icon(Icons.email_outlined, color: Colors.deepPurple),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (v) => v!.isEmpty ? 'Please enter your email' : null,
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _passC,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded, color: Colors.deepPurple),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                          onPressed: () => setState(() => _isObscure = !_isObscure),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (v) => v!.isEmpty ? 'Please enter your password' : null,
                    ),

                    // --- Step 4: Remember Me Checkbox UI ---
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          activeColor: Colors.deepPurple,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                        const Text('Remember Me', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                      ],
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 8,
                          shadowColor: Colors.deepPurple.withOpacity(0.5),
                        ),
                        child: const Text('LOGIN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("New to the quest?"),
                        TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const UserDetailsScreen())),
                          child: const Text("Register Now", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}