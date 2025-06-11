import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/services/secure_storage_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['token'];
        await SecureStorageService.saveToken(token);
        if (mounted) {
          context.go('/items-found');
        }
      } else {
        setState(() {
          _error = 'Invalid email or password';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'An error occurred. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                // Back button
                Positioned(
                  left: 25,
                  top: 65,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 292,
                      height: 18,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 29,
                            top: 0,
                            child: Text(
                              'Back',
                              style: TextStyle(
                                color: const Color(0xFF2C2C2C),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Title
                Positioned(
                  left: 24,
                  top: 122,
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: const Color(0xFF1A86E5),
                      fontSize: 42,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // Subtitle
                Positioned(
                  left: 24,
                  top: 187,
                  child: Text(
                    'Please sign in to continue',
                    style: TextStyle(
                      color: const Color(0xFF2C2C2C),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Form
                Positioned(
                  left: 24,
                  top: 250,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email input
                        Container(
                          width: 342,
                          height: 76,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 28,
                                child: Container(
                                  width: 342,
                                  height: 48,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFF5F5F5),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: const Color(0xFFE1E1E1),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 16,
                                top: 40,
                                child: SizedBox(
                                  width: 278,
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      hintText: 'myemail@gmail.com',
                                      hintStyle: TextStyle(
                                        color: const Color(0xFF2C2C2C),
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox(
                                  width: 287,
                                  child: Text(
                                    'Email',
                                    style: TextStyle(
                                      color: const Color(0xFF222222),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        // Password input
                        Container(
                          width: 342,
                          height: 76,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 28,
                                child: Container(
                                  width: 342,
                                  height: 48,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFF5F5F5),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: const Color(0xFFE1E1E1),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 16,
                                top: 40,
                                child: SizedBox(
                                  width: 278,
                                  child: TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: '•••••••••',
                                      hintStyle: TextStyle(
                                        color: const Color(0xFF2C2C2C),
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: SizedBox(
                                  width: 287,
                                  child: Text(
                                    'Password',
                                    style: TextStyle(
                                      color: const Color(0xFF222222),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Sign in button
                Positioned(
                  left: 24,
                  top: 438,
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _signIn();
                      }
                    },
                    child: Container(
                      width: 342,
                      height: 48,
                      decoration: ShapeDecoration(
                        color: _isLoading ? Colors.grey : const Color(0xFF1A86E5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Center(
                              child: Text(
                                'Sign in',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}