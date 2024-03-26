import "package:another_flutter_splash_screen/another_flutter_splash_screen.dart";
import 'package:flutter/material.dart';
import "package:flutter/widgets.dart";
import 'package:map/home.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // late SharedPreferences prefs;
  // @override
  // void initState() {
  //   super.initState();
  //   initializeApp();
  // }

  // Future<void> initializeApp() async {
  //   prefs = await SharedPreferences.getInstance();

  //   final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  //   final user = FirebaseAuth.instance.currentUser;

  //   if (isLoggedIn && user != null) {
  //     // User is already signed in, navigate to HomeScreen
  //     navigateWithFadeTransition(context, HomeScreen());
  //   } else {
  //     // User is not signed in, navigate to LoginPage after splash
  //     navigateWithFadeTransition(context, JustLogin());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: FlutterSplashScreen.gif(
          useImmersiveMode: true,
          gifPath: 'assets/map-pin.gif',
          gifWidth: MediaQuery.of(context).size.width,
          gifHeight: MediaQuery.of(context).size.height,
          duration: const Duration(seconds: 3),
          // nextScreen: JustLogin(),
          // onEnd: () => navigateWithFadeTransition(context, JustLogin()),
          onEnd: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
    );
  }
}