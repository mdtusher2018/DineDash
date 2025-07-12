import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Add this import

void main() {
  runApp(MaterialApp(home: AnimationDemo()));
}

class AnimationDemo extends StatefulWidget {
  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo> with TickerProviderStateMixin {
  late AnimationController _bgController;
  late Animation<double> _bgScale;

  late AnimationController _mobileController;
  late Animation<Offset> _mobileSlide;

  late AnimationController _userController;
  late Animation<Offset> _userSlide;

  late AnimationController _shrinkController;
  late Animation<double> _shrinkScale;



  @override
  void initState() {
    super.initState();

    _bgController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _bgScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _bgController, curve: Curves.ease),
    );

    _mobileController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _mobileSlide = Tween<Offset>(begin: Offset(0, -2), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _mobileController, curve: Curves.easeInOut),
    );

    _userController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _userSlide = Tween<Offset>(begin: Offset(-2, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _userController, curve: Curves.easeInOut),
    );

    _shrinkController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _shrinkScale = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(parent: _shrinkController, curve: Curves.easeInOut),
    );

    // Start all animations at once
    _bgController.forward();
    _mobileController.forward();
    _userController.forward();


  }

  @override
  void dispose() {
    _bgController.dispose();
    _mobileController.dispose();
    _userController.dispose();
    _shrinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
              Center(
              child: Positioned.fill(
                child: Lottie.asset(
                  'assets/animation image/animation.json',
                  repeat: false,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          // Background scale animation
          AnimatedBuilder(
            animation: _bgScale,
            builder: (_, child) {
              return Transform.scale(
                scale: _bgScale.value,
                child: child,
              );
            },
            child: Image.asset('assets/animation image/background.png'),
          ),
      
          // Mobile image sliding from top
          SlideTransition(
            position: _mobileSlide,
            child: AnimatedBuilder(
              animation: _shrinkScale,
              builder: (_, child) {
                return Transform.scale(scale: _shrinkScale.value, child: child);
              },
              child: Image.asset('assets/animation image/mobile.png'),
            ),
          ),
      
          // User image sliding from left and stopping a bit left of center
          SlideTransition(
            position: _userSlide,
            child: Transform.translate(
              offset: Offset(-40, 0),
              child: AnimatedBuilder(
                animation: _shrinkScale,
                builder: (_, child) {
                  return Transform.scale(scale: _shrinkScale.value, child: child);
                },
                child: Image.asset('assets/animation image/user.png'),
              ),
            ),
          ),
          Center(
              child: Positioned.fill(
                child: Lottie.asset(
                  'assets/animation image/animation.json',
                  repeat: false,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
        
        ],
      ),
    );
  }
}
