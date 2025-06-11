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
        body: ListView(children: [
          WelcomeScreen2(),
        ]),
      ),
    );
  }
}

class WelcomeScreen2 extends StatelessWidget {
  const WelcomeScreen2({super.key});

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 134),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      color: Color(0xFF1A86E5),
                      fontSize: 42,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16), // Reduced from 23
                  const Text(
                    'Lets get started',
                    style: TextStyle(
                      color: Color(0xFF2C2C2C),
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w500, // Changed from w600
                    ),
                  ),
                  const SizedBox(height: 60), // Reduced from 75
                  const Text(
                    'Existing customer / Get started',
                    style: TextStyle(
                      color: Color(0xFF2C2C2C),
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w500, // Changed from w600
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => context.push('/login'),
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
                          'Sign in',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24), // Reduced from 27
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New customer?',
                        style: TextStyle(
                          color: Color(0xFF2C2C2C),
                          fontSize: 16,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w500, // Changed from w600
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => context.push('/register'),
                        child: Container(
                          width: 342,
                          height: 48,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFF1A86E5)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Sign up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF1A86E5),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}