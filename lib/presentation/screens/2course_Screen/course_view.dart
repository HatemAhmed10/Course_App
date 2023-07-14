import 'package:course_app/business_logic/course_cubit/course_cubit.dart';
import 'package:course_app/business_logic/course_cubit/course_state.dart';
import 'package:course_app/presentation/screens/1authentication/1welcome_Screen/welcome_view.dart';
import 'package:course_app/presentation/widgets/2Course_Widget/1wait_widget/Wait_View.dart';
import 'package:course_app/presentation/widgets/2Course_Widget/2Course_widget/1Course_View.dart';
import 'package:course_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/cache_helper.dart';

class course_view extends StatefulWidget {
  course_view({super.key});

  @override
  State<course_view> createState() => _course_viewState();
}

class _course_viewState extends State<course_view> {
  String MyEmail = "";
  Widget Body = Center(
      child: CircularProgressIndicator(
    color: kPrimaryColor,
  ));
  @override
  void initState() {
    super.initState();
    MyEmail = CacheHelper.getData(key: 'User_Email');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseCubit()
        ..Get_User_Model_IN_CacheHelper_and_check_true_or_false(Email: MyEmail),
      child: BlocConsumer<CourseCubit, CourseStates>(
        listener: (context, state) {
          if (state is check_true_state) {
            Body = Course_View(
              MyEmail: MyEmail,
              StudentYear:
                  CourseCubit.get(context).userModel!.userYear.toString(),
            );
          } else if (state is check_Flase_state) {
            Body = Wait_View(
              StudentName:
                  CourseCubit.get(context).userModel!.userName.toString(),
            );
          } else if (state is check_Not_Found_state) {
            CacheHelper.removeData(
              key: 'User_UID',
            ).then((value) {
              CacheHelper.removeData(
                key: 'User_Email',
              );
            });
            Body = Welcome_View();
          }
        },
        builder: (context, state) {
          // ignore: unused_local_variable
          CourseCubit FcourseCubit = CourseCubit.get(context);

          return Scaffold(
            body: Body,
            // body: Column(
            //   children: [
            //     Expanded(
            //         child: Container(
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             IconButton(
            //                 onPressed: () {
            //                   CacheHelper.removeData(
            //                     key: 'User_UID',
            //                   ).then((value) {
            //                     CacheHelper.removeData(
            //                       key: 'User_Email',
            //                     );
            //                     navigateAndFinish(context, Welcome_View());
            //                   });
            //                 },
            //                 icon: Icon(Icons.login_outlined)),
            //           ],
            //         ),
            //       ),
            //     )),
            //     Expanded(
            //         flex: 12,
            //         child: Container(color: Colors.yellow, child: Body)),
            //   ],
            // ),
          );
        },
      ),
    );
  }
}
