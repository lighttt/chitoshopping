import 'package:flutter/material.dart';

String _home;
String _imagePath;
int _duration;
Color _backGroundColor;
double _logoSize;

class SplashScreen extends StatefulWidget {
  SplashScreen(
      {@required String imagePath,
      @required String home,
      int duration,
      Color backGroundColor = Colors.white,
      double logoSize = 250.0}) {
    assert(duration != null);
    assert(home != null);
    assert(imagePath != null);

    _home = home;
    _duration = duration;
    _imagePath = imagePath;
    _backGroundColor = backGroundColor;
    _logoSize = 250.0;
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    if (_duration < 1000) _duration = 2000;
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    _animationController.forward();
    goToHome();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  Future<void> goToHome() async {
    await Future.delayed(Duration(milliseconds: _duration));
    Navigator.of(context).pushReplacementNamed(_home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _backGroundColor,
        body: FadeTransition(
            opacity: _animation,
            child: Center(
                child: SizedBox(
                    height: _logoSize, child: Image.asset(_imagePath)))));
  }
}
