import 'dart:async';
import 'package:ecomplaintbharat/main.dart';
import 'package:ecomplaintbharat/sign_in.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // E-Complaint Bharat Logo
                    Image.asset(
                      'assets/logo.png', // Replace with your logo asset path
                      height: 237,
                      width: 332,
                    ),
                    const SizedBox(height: 20),

                    // "A Society Complaint App" text
                    const Text(
                      'A Society Complaint App',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // First row of icons (Save Trees, Road Sign, Ambulance)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/savetreesicon.png', // Replace with your icon asset path
                              height: 90,
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Column(
                          children: [
                            Image.asset(
                              'assets/roadiconpro.png', // Replace with your icon asset path
                              height: 60,
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Column(
                          children: [
                            Image.asset(
                              'assets/ambulanceicon.png', // Replace with your icon asset path
                              height: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Second row of icons (Accident, Toilet, Recycling)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/carcrashicon.png', // Replace with your icon asset path
                              height: 70,
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Column(
                          children: [
                            Image.asset(
                              'assets/toileticonpop.png', // Replace with your icon asset path
                              height: 50,
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Column(
                          children: [
                            Image.asset(
                              'assets/recycling.png', // Replace with your icon asset path
                              height: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Footer Text at the Bottom
              const Text(
                'Powered by LPU Students',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}