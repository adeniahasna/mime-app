import 'package:flutter/material.dart';
import '/resources/widgets/logo_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  /// Create a new instance of the MaterialApp
  static MaterialApp app() {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Logo(), SizedBox(height: 50)],
          ),
        ),
      ),
    );
  }
}
