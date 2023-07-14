import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:course_app/business_logic/1User_Cubit/user_state.dart';
import 'package:course_app/models/1authentication/userModel.dart';

import '../../../../business_logic/1User_Cubit/user_cubit.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/routes.dart';
import '../../../../shared/styles/assets_manager.dart';
import '../../../screens/1authentication/2login_Screen/login_view.dart';
import '../../../screens/2course_Screen/course_view.dart';
import '../2login_widgets/already_have_an_account_acheck.dart';

// ignore: must_be_immutable
class SignUpForm extends StatelessWidget {
  SignUpForm({
    Key? key,
  }) : super(key: key);

  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  TextEditingController userYear = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is SignUpSuceccful) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('SignUp Suceccful'),
                duration: Duration(seconds: 3),
                backgroundColor:
                    kPrimaryColor, // Set the background color of the snackbar here
              ),
            );

            navigateAndFinish(context, course_view());
          } else if (state is SignUperror) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Register error "),
                duration: Duration(seconds: 3),
                backgroundColor:
                    Colors.red, // Set the background color of the snackbar here
              ),
            );
          }
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
                    keyboardType: TextInputType.name,
                    cursorColor: kPrimaryColor,
                    style: TextStyle(color: kPrimaryColor),
                    controller: userName,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Your Name",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        child: Icon(
                          Icons.text_decrease,
                          color: kPrimaryColor,
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),

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
                      hintText: "Your Email",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        child: Icon(
                          Icons.email,
                          color: kPrimaryColor,
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),

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
                  width: 350,
                  margin:
                      EdgeInsets.only(top: 6, bottom: 6, left: 28, right: 28),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: kPrimaryColor,
                    style: TextStyle(color: kPrimaryColor),
                    controller: userPassword,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Your Password",
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

                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      userCubit.photo == null
                          ? Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () {
                                  userCubit.imgFromGallery();
                                },
                                child: AspectRatio(
                                  aspectRatio: 3.6 / 4,
                                  child: ClipRRect(
                                    // borderRadius: BorderRadius.circular(32),
                                    child: Image.asset(
                                      ImageAssets.person,
                                      fit: BoxFit.cover,
                                      // width: 200,
                                      // height: 200,
                                    ),
                                  ),
                                ),
                                // child: CircleAvatar(
                                //   radius: 100, // set the radius of the avatar
                                //   backgroundImage: AssetImage(
                                //     ImageAssets.person,
                                //   ), // set the image for the avatar
                                //   backgroundColor: Color.fromARGB(0, 54, 46,
                                //       46), // make the background of the avatar transparent
                                //   child: ClipRRect(
                                //     borderRadius: BorderRadius.circular(12),
                                //     child: Image.asset(
                                //       ImageAssets.person,
                                //       fit: BoxFit.cover,
                                //       // width: 200,
                                //       // height: 200,
                                //     ),
                                //   ),
                                // ),
                              ),
                            )
                          : Expanded(
                              flex: 3,
                              child: InkWell(
                                onTap: () {
                                  userCubit.imgFromGallery();
                                },
                                child: CircleAvatar(
                                  radius: 70,
                                  child: ClipOval(
                                    child: Image.file(
                                      userCubit.photo!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      Spacer(),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          width: 115,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: DropdownButton<String>(
                            underline: null,
                            dropdownColor: kPrimaryColor.withOpacity(0.8),
                            value: userCubit.selectedValue,
                            onChanged: (newValue) {
                              userCubit
                                  .updateSelectedValue(newValue.toString());
                            },
                            items: <String>[
                              'اولي ثانوي',
                              'تانيه ثانوي',
                              'ثالثه ثانوي'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Column(
                                  children: [
                                    Text(
                                      value,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                    Container(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ConditionalBuilder(
                  condition: state is SignUpLoading,
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
                        Timestamp timestamp = Timestamp.now();

                        if (formKey.currentState!.validate()) {
                          userCubit.uploadFile(
                              FuserModel: UserModel(
                            userId: "",
                            userName: userName.text,
                            userEmail: userEmail.text,
                            userPassword: userPassword.text,
                            userYear: userCubit.selectedValue.toString(),
                            dataTime: timestamp,
                            phoneNumber: "212",
                            userimage: "",
                            State: false,
                          ));
                        }
                      },
                      child: Text(
                        "Sign Up".toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    navigateTo(context, login_view());
                    // Navigator.pushNamed(
                    //   context,
                    //   '/login_view',
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
