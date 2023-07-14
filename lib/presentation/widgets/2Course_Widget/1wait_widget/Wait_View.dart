import 'package:course_app/shared/styles/assets_manager.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Wait_View extends StatelessWidget {
  String StudentName = "";

  Wait_View({
    required this.StudentName,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 400,
                child: Image(image: AssetImage(ImageAssets.wait))),
            SizedBox(
              height: 40,
            ),
            Text(
              "${StudentName} انتظر موافقه المسؤل",
              style: TextStyle(fontSize: 25, color: Color(0xffD6A4DE)),
            ),
          ],
        ),
      ),
    );
  }
}
