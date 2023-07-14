import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_app/business_logic/course_cubit/course_cubit.dart';
import 'package:course_app/business_logic/course_cubit/course_state.dart';
import 'package:course_app/presentation/screens/1authentication/4LogOut_Screen/logOut_view.dart';
import 'package:course_app/presentation/screens/3Learn_Screen/learn_View.dart';
import 'package:course_app/presentation/widgets/1authentication/1welcome_widgets/background.dart';
import 'package:course_app/shared/constants.dart';
import 'package:course_app/shared/routes.dart';
import 'package:course_app/shared/styles/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: must_be_immutable
class Course_View extends StatelessWidget {
  Course_View({super.key, required this.MyEmail, required this.StudentYear});
  String MyEmail = "";
  String StudentYear = "";
  @override
  Widget build(BuildContext context) {
    return Background(
      child: BlocProvider(
        create: (context) => CourseCubit()
          ..fetchAllcourseModel(studentYear: StudentYear)
          ..Get_User_Model_IN_CacheHelper_and_check_true_or_false(
              Email: MyEmail.toString()),
        child: BlocConsumer<CourseCubit, CourseStates>(
          listener: (context, state) {},
          builder: (context, state) {
            CourseCubit courseCubit = CourseCubit.get(context);

            return Container(
              color: kPrimaryColor.withOpacity(0.2),
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 50, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.menu),
                        courseCubit.userModel == null ||
                                courseCubit.userModel!.userimage == ""
                            ? InkWell(
                                onTap: () {
                                  navigateTo(
                                    context,
                                    LogOut_View(
                                        userModel: courseCubit.userModel!),
                                  );
                                },
                                child: CircleAvatar(
                                  //  backgroundColor:
                                  //        Color.fromARGB(0, 54, 46, 46),
                                  child: ClipOval(
                                    child: Image.asset(
                                      ImageAssets.person,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  // child: Text(
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  navigateTo(
                                    context,
                                    LogOut_View(
                                        userModel: courseCubit.userModel!),
                                  );
                                },
                                child: CircleAvatar(
                                  //  backgroundColor:
                                  //        Color.fromARGB(0, 54, 46, 46),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: courseCubit.userModel!.userimage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),

                                    // child: Image.network(
                                    //   courseCubit.userModel!.userimage
                                    //       .toString(),
                                    //   fit: BoxFit.cover,
                                    //   width: double.infinity,
                                    //   height: double.infinity,
                                    // ),
                                  ),
                                  // child: Text(
                                ),
                              ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text("Hey ${courseCubit.userModel?.userName},",
                        style: kHeadingextStyle),
                    Text("Find a course you want to learn",
                        style: kSubheadingextStyle),
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: StaggeredGridView.countBuilder(
                        padding: EdgeInsets.all(0),
                        crossAxisCount: 2,
                        itemCount: courseCubit.courseModel.length,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              navigateTo(
                                  context,
                                  Learn_View(
                                    courseModel: courseCubit.courseModel[index],
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              height: index.isEven ? 250 : 260,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                image: courseCubit
                                            .courseModel[index].courseImage
                                            .toString() ==
                                        ""
                                    ? DecorationImage(
                                        image: AssetImage(ImageAssets.person),
                                        fit: BoxFit.contain,
                                        alignment: Alignment.topCenter,
                                      )
                                    : DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            courseCubit
                                                .courseModel[index].courseImage
                                                .toString()),
                                        fit: BoxFit.contain,
                                        alignment: Alignment.topCenter,
                                      ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    courseCubit.courseModel[index].courseName
                                        .toString(),
                                    style: kTitleTextStyle,
                                  ),
                                  Text(
                                    '${courseCubit.courseModel[index].courseType}',
                                    style: TextStyle(
                                      color: kPrimaryColor.withOpacity(.9),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
