import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app/business_logic/Learn_Cubit/learn_cubit.dart';
import 'package:course_app/business_logic/Learn_Cubit/learn_state.dart';
import 'package:course_app/models/2Courses/2Course_model.dart';
import 'package:course_app/presentation/widgets/3Learn_Widget/BestSellerClipper.dart';
import 'package:course_app/presentation/widgets/3Learn_Widget/CourseContent.dart';
import 'package:course_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Learn_View_Body extends StatelessWidget {
  Learn_View_Body({super.key, required this.courseModel});
  final CourseModel courseModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          Learn_Cubit()..fetchAllLearn(courseModel: courseModel),
      child: BlocConsumer<Learn_Cubit, Learn_States>(
        listener: (context, state) {},
        builder: (context, state) {
          Learn_Cubit learn_cubit = Learn_Cubit.get(context);

          return Scaffold(
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFF5F4EF),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        courseModel.courseImage.toString()),
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 50, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_left,
                                size: 30,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        ClipPath(
                          clipper: BestSellerClipper(),
                          child: Container(
                            color: kBestSellerColor,
                            padding: EdgeInsets.only(
                                left: 10, top: 5, right: 20, bottom: 5),
                            child: Text(
                              "BestCourse".toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(courseModel.courseName.toString(),
                            style: kHeadingextStyle),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: courseModel.courseType,
                                style: kHeadingextStyle.copyWith(fontSize: 32),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Course Content", style: kTitleTextStyle),
                                SizedBox(height: 30),
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return CourseContent(
                                        number: (index + 1).toString(),
                                        learnModel:
                                            learn_cubit.ListlearnModel[index],
                                      );
                                    },
                                    itemCount:
                                        learn_cubit.ListlearnModel.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
