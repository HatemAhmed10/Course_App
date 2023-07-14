import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/1User_Cubit/user_cubit.dart';
import '../../../../business_logic/1User_Cubit/user_state.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/routes.dart';
import '../../../screens/1authentication/3SignUp_Screen/SignUp_view.dart';
import '../../../screens/2course_Screen/course_view.dart';
import 'already_have_an_account_acheck.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

// ignore: must_be_immutable
class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var loginKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: loginKey,
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is LoginSuceccful) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login Suceccful'),
                duration: Duration(seconds: 3),
                backgroundColor:
                    kPrimaryColor, // Set the background color of the snackbar here
              ),
            );
            navigateAndFinish(context, course_view());
          } else if (state is Loginerror) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Login error "),
                duration: Duration(seconds: 3),
                backgroundColor:
                    Colors.red, // Set the background color of the snackbar here
              ),
            );
          }

          // } else if (state is Loginerrorinvalid_email) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text('Invalid Email'),
          //       duration: Duration(seconds: 3),
          //       backgroundColor: Colors
          //           .blue, // Set the background color of the snackbar here
          //     ),
          //   );
          // } else if (state is Loginerroruser_not_found) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text('User not found'),
          //       duration: Duration(seconds: 3),
          //       backgroundColor: Colors
          //           .blue, // Set the background color of the snackbar here
          //     ),
          //   );
          // } else if (state is Loginerrorwrong_password) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text('Wrong Password'),
          //       duration: Duration(seconds: 3),
          //       backgroundColor: Colors
          //           .blue, // Set the background color of the snackbar here
          //     ),
          //   );
          // } else if (state is Loginerror) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text('Login error '),
          //       duration: Duration(seconds: 3),
          //       backgroundColor: Colors
          //           .blue, // Set the background color of the snackbar here
          //     ),
          //   );
          // }
        },
        builder: (context, state) {
          UserCubit userCubit = UserCubit.get(context);

          return Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  width: 350,
                  margin:
                      EdgeInsets.only(top: 6, bottom: 6, left: 28, right: 28),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: kPrimaryColor,
                    style: TextStyle(color: kPrimaryColor),
                    controller: userEmail,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Your email",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        child: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.grey),

                      fillColor: kPrimaryColor
                          .withOpacity(0.3), // Set the background color here
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide(
                          color: kPrimaryColor.withOpacity(
                              0.3), // Set the normal border color here
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide(
                          color:
                              kPrimaryColor, // Set the focused border color here
                          width: 2.0,
                        ),
                      ),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide(
                          color: Colors.red, // Set the error border color here
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 6, bottom: 6, left: 28, right: 28),
                  width: 350,
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: kPrimaryColor,
                    style: TextStyle(color: kPrimaryColor),
                    controller: userPassword,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Your password",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        child: Icon(
                          Icons.lock_outline,
                          color: kPrimaryColor,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          userCubit.changePasswordVisibility();
                        },
                        icon: Icon(
                          userCubit.suffix,
                        ),
                        color: kPrimaryColor,
                      ),

                      hintStyle: TextStyle(color: Colors.grey),

                      fillColor: kPrimaryColor
                          .withOpacity(0.3), // Set the background color here
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide(
                          color: kPrimaryColor.withOpacity(
                              0.3), // Set the normal border color here
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide(
                          color:
                              kPrimaryColor, // Set the focused border color here
                          width: 2.0,
                        ),
                      ),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide(
                          color: Colors.red, // Set the error border color here
                          width: 2.0,
                        ),
                      ),
                    ),
                    obscureText: userCubit.isPassword,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Text';
                      }
                      return null;
                    },
                  ),
                ),
                ConditionalBuilder(
                  condition: state is LoginLoading,
                  builder: (context) => CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                  fallback: (context) => Container(
                    width: 350,
                    margin:
                        EdgeInsets.only(top: 6, bottom: 6, left: 28, right: 28),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: MaterialButton(
                      // minWidth: 150,
                      height: 60,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          userCubit.Login_cubit(
                              Femail: userEmail.text,
                              Fpassword: userPassword.text);
                        }
                      },
                      child: Text(
                        "Login".toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                AlreadyHaveAnAccountCheck(
                  press: () {
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
