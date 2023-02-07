import 'package:flutter/material.dart';
import 'package:keanggotaan_orbit/views/pages/home_page.dart';
import 'package:keanggotaan_orbit/views/pages/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutoLogin extends StatelessWidget {
  const AutoLogin({Key? key}) : super(key: key);

  Future<bool> Token() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
     return FutureBuilder<bool>(
      future: Token(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data! ? HomePage() : onboardingPage();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
