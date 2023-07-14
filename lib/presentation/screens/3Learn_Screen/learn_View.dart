import 'package:course_app/models/2Courses/2Course_model.dart';
import 'package:course_app/presentation/widgets/3Learn_Widget/Learn_View_Body.dart';
import 'package:flutter/material.dart';

class Learn_View extends StatelessWidget {
  Learn_View({super.key, required this.courseModel});
  final CourseModel courseModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Learn_View_Body(courseModel: courseModel),
    );
  }
}
