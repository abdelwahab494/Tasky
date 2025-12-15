import 'dart:ui';
import 'package:tasky/core/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _scaleController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 800),
  );
  late final Animation<double> _scaleAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.bounceOut));

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    final String? username = await PrefHelper.getName();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (c) => username == null ? WelcomeScreen() : RootScreen(),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -70,
            child: Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DarkColors.primary.withOpacity(0.40),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 140, sigmaY: 140),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DarkColors.primary.withOpacity(0.40),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          // Center(
          //   child: SvgPicture.asset("assets/images/logo.svg", width: 120),
          // ).animate().scale(
          //   begin: Offset(0, 0),
          //   end: Offset(1, 1),
          //   duration: Duration(milliseconds: 1),
          // ),
          ScaleTransition(
            scale: _scaleAnimation,
            child: Center(
              child: SvgPicture.asset("assets/images/logo.svg", width: 120),
            ),
          ),
        ],
      ),
    );
  }
}
