import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ForgotPasswordScreen(),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                                color: const Color(0xFF222222),
                                fontSize: 14,
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 3,
                            child: Container(width: 6, height: 11, child: Stack()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Title
                Positioned(
                  left: 24,
                  top: 129,
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: const Color(0xFF1A86E5),
                      fontSize: 42,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w700,
                      height: 0.95,
                    ),
                  ),
                ),
                // Subtitle
                Positioned(
                  left: 24,
                  top: 226,
                  child: Text(
                    'Enter your email for the verification process, \nwe will send code to your email',
                    style: TextStyle(
                      color: const Color(0xFF2C2C2C),
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Email input field
                Positioned(
                  left: 24,
                  top: 300,  // Adjusted position
                  child: Container(
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
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter email',
                                hintStyle: TextStyle(
                                  color: const Color(0xFF2C2C2C),
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w500,
                                ),
                                border: InputBorder.none,
                              ),
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
                                color: const Color(0xFF2C2C2C),
                                fontSize: 14,
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Continue button
                Positioned(
                  left: 24,
                  top: 400,  // Adjusted position
                  child: GestureDetector(
                    onTap: () => context.push('/screen/enter_code_screen'),
                    child: Container(
                      width: 342,
                      height: 48,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1A86E5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Continue',
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
}