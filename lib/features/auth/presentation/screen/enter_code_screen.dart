import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EnterCodeScreen extends StatelessWidget {
  const EnterCodeScreen({super.key});

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
                  top: 122,
                  child: Text(
                    'Enter Code',
                    style: TextStyle(
                      color: const Color(0xFF1A86E5),
                      fontSize: 42,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // Subtitle
                Positioned(
                  left: 24,
                  top: 187,
                  child: Text(
                    'Please enter the code sent to your email',
                    style: TextStyle(
                      color: const Color(0xFF2C2C2C),
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Code input fields
                Positioned(
                  left: 24,
                  top: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                      (index) => Container(
                        width: 75,
                        height: 75,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF5F5F5),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0xFFE3E3E3),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Plus Jakarta Sans',
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Continue button
                Positioned(
                  left: 24,
                  top: 467,
                  child: GestureDetector(
                    onTap: () {
                      // Handle code verification
                      context.push('/reset-password');
                    },
                    child: Container(
                      width: 342,
                      height: 48,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF363E50),
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