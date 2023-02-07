import 'package:flutter/material.dart';
import 'package:keanggotaan_orbit/helpers/color.dart';
import 'package:keanggotaan_orbit/providers/auth.dart';
import 'package:keanggotaan_orbit/views/widget/textfield_costum.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<AuthProvider>(
                builder: (context, state, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo2.png",
                        width: 300,
                      ),
                      Text(
                        "Hi, Welcome Back",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(height: 24),
                      TextFieldCustom(
                        label: "Email",
                        hintText: "Enter Your Email",
                        controller: state.emailLoginC,
                        errorText: state.emailLoginE,
                      ),
                      SizedBox(height: 12),
                      TextFieldCustom(
                          controller: state.passLoginC,
                          errorText: state.passLoginE,
                          label: "Password",
                          hintText: "Enter Your Password",
                          isPassword: true),
                      SizedBox(height: 12),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(height: 12),
                      RoundedLoadingButton(
                        child: Text('Login',
                            style: TextStyle(color: Colors.white)),
                        color: kDarkBlueColor,
                        controller: state.btnController,
                        onPressed: () {
                          state.Login(context);
                        },
                      ),
                      SizedBox(height: 12),
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
