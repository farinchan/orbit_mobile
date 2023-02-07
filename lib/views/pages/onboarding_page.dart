import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keanggotaan_orbit/helpers/color.dart';

class onboardingPage extends StatelessWidget {
  const onboardingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: kDarkBlueColor,
                  ),
                  Image.asset("assets/wave.png"),
                  Text("Selamat Datang di",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 18),
                  Image.asset(
                    "assets/Contoh.png",
                    width: 320,
                  ),
                  SizedBox(height: 18),
                  InkWell(
                    onTap: () => context.goNamed("login"),
                    child: Container(
                      height: 45,
                      width: 300,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: kDarkBlueColor,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  SizedBox(height: 18),
                  InkWell(
                    onTap: () => context.goNamed("register"),
                    child: Container(
                      height: 45,
                      width: 300,
                      child: Center(
                        child: Text(
                          "Daftar",
                          style: TextStyle(
                              color: kDarkBlueColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: kDarkBlueColor, width: 3),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Powered By",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 12),
                  Image.asset(
                    "assets/logo_orbit.png",
                    width: 80,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
