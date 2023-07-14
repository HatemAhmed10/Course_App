import 'package:flutter/material.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/routes.dart';
import '../../../screens/1authentication/2login_Screen/login_view.dart';
import '../../../screens/1authentication/3SignUp_Screen/SignUp_view.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: MaterialButton(
            color: kPrimaryColor,
            onPressed: () {
              navigateTo(context, login_view());
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            navigateTo(context, SignUp_View());

            // Navigator.pushNamed(
            //   context,
            //   '/SignUp_View',
            // );
            // Navigator.pushNamed(context, SignUp_View.routeName);

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return SignUpScreen();
            //     },
            //   ),
            // );
          },
          style: ElevatedButton.styleFrom(
              primary: kPrimaryLightColor, elevation: 0),
          child: Text(
            "Sign Up".toUpperCase(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
