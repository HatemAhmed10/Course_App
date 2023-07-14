import 'package:course_app/models/1authentication/userModel.dart';
import 'package:course_app/presentation/screens/1authentication/1welcome_Screen/welcome_view.dart';
import 'package:course_app/shared/network/cache_helper.dart';
import 'package:course_app/shared/routes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LogOut_View extends StatelessWidget {
  LogOut_View({super.key, required this.userModel});
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 60),
            CircleAvatar(
              radius: 90,
              backgroundImage: NetworkImage(
                userModel.userimage.toString(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              userModel.userName.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              userModel.userEmail.toString(),
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 160),
            Row(
              children: [
                Spacer(),
                IconButton(
                  onPressed: () {
                    CacheHelper.removeData(
                      key: 'User_UID',
                    ).then((value) {
                      CacheHelper.removeData(
                        key: 'User_Email',
                      );
                      navigateAndFinish(context, Welcome_View());
                    });
                  },
                  icon: Icon(
                    Icons.logout,
                  ),
                ),
                Text(
                  "تسجيل خروج",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
