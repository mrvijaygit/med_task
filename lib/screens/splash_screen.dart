import 'package:flutter/material.dart';
import 'package:med_task/utils/ui_helper.dart';
import '../utils/globals.dart';
import '../utils/styles.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Future.delayed(const Duration(seconds: 1), () {});
      _getRoute();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  Future<void> _getRoute() async {
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const MyHomePage()),
              (route) => false
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: UiHelper.getSize(context).width,
        color: Globals.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.space_dashboard_rounded,
            color: Colors.white,
              size: 40,
            ),
            SizedBox(
              height: UiHelper.getSize(context).height * 0.02,
            ),
            Text('Trello Board',
            style: Styles.headingStyle2(
              color: Colors.white
            ))
          ],
        ),
      ),
    );
  }
}

