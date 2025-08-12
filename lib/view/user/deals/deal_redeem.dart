
import 'package:dine_dash/view/res/commonWidgets.dart';
import 'package:dine_dash/view/user/deals/reminder_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Add this import


class DealRedeemPage extends StatefulWidget {
  @override
  _DealRedeemPageState createState() => _DealRedeemPageState();
}

class _DealRedeemPageState extends State<DealRedeemPage> with TickerProviderStateMixin {
  late AnimationController _bgController;
  late Animation<double> _bgScale;

  late AnimationController _mobileController;
  late Animation<Offset> _mobileSlide;

  late AnimationController _userController;
  late Animation<Offset> _userSlide;

  late AnimationController _shrinkController;
  late Animation<double> _shrinkScale;

//texts and others animations
late AnimationController _dealController;
late Animation<double> _fadeTitle;
late Animation<Offset> _slideTitle;
late Animation<Offset> _slideDetails;
late Animation<double> _fadeButton;


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



// texts and others animations
_dealController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

_fadeTitle = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(parent: _dealController, curve: Interval(0.0, 0.2, curve: Curves.easeIn)),
);
_slideTitle = Tween<Offset>(begin: Offset(0, 0), end: Offset.zero).animate(
  CurvedAnimation(parent: _dealController, curve: Interval(0.0, 0.2, curve: Curves.easeOut)),
);


_slideDetails = Tween<Offset>(begin: Offset(0, 0), end: Offset.zero).animate(
  CurvedAnimation(parent: _dealController, curve: Interval(0.2, 0.4, curve: Curves.easeOut)),
);


_fadeButton = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(parent: _dealController, curve: Interval(0.6, 1.0, curve: Curves.easeIn)),
);

// Delay to start deal section animation
Future.delayed(Duration(milliseconds: 1200), () {
  _dealController.forward();
});




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
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                    Positioned.fill(
                      child: Lottie.asset(
                        'assets/animation image/animation.json',
                        repeat: false,
                        fit: BoxFit.cover,
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
                Positioned.fill(
                  child: Lottie.asset(
                    'assets/animation image/animation.json',
                    repeat: false,
                    fit: BoxFit.cover,
                  ),
                ),
                  
              
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: FadeTransition(
                opacity: _fadeTitle,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 320),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SlideTransition(
                        position: _slideTitle,
                        child: commonText("Deal redeemed!", size: 21, isBold: true),
                      ),
                      SizedBox(height: 8),
                      SlideTransition(
                        position: _slideDetails,
                        child: commonText(
                          "Congratulations, you’ve discovered a new restaurant in your town!",
                          textAlign: TextAlign.center,
                          size: 16,
                        ),
                      ),
                      SizedBox(height: 16),
                  
                      Spacer(flex: 3),
                      FadeTransition(
                        opacity: _fadeButton,
                        child: commonButton("Continue",onTap: () {
                         navigateToPage(ReminderScreen(),replace: true);
                        },),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            )

        ],
      ),
    );
  }
}
