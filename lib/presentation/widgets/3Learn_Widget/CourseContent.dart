import 'package:course_app/models/3Learn/3LearnModel.dart';
import 'package:course_app/presentation/screens/3Learn_Screen/learn_details.dart';
import 'package:course_app/shared/constants.dart';
import 'package:course_app/shared/routes.dart';
import 'package:flutter/material.dart';

class CourseContent extends StatelessWidget {
  CourseContent({super.key, required this.learnModel, required this.number});
  final LearnModel learnModel;
  final String? number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: () {
          navigateTo(
              context,
              Learn_Details(
                learnModel: learnModel,
              ));
        },
        child: Row(
          children: <Widget>[
            Text(
              number!,
              style: kHeadingextStyle.copyWith(
                color: kTextColor.withOpacity(.15),
                fontSize: 32,
              ),
            ),
            SizedBox(width: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: learnModel.LearnName.toString(),
                    style: kSubtitleTextSyule.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kGreenColor,
              ),
              child: Icon(
                  learnModel.LearnType == "Video"
                      ? Icons.play_arrow
                      : Icons.picture_as_pdf,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
