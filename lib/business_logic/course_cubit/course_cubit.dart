import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app/business_logic/course_cubit/course_state.dart';
import 'package:course_app/models/1authentication/userModel.dart';
import 'package:course_app/models/2Courses/2Course_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCubit extends Cubit<CourseStates> {
  CourseCubit() : super(CourseInitialState());

  static CourseCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  bool isOkay = false;

  void Get_User_Model_IN_CacheHelper_and_check_true_or_false(
      {required String Email}) {
    FirebaseFirestore.instance
        .collection('users')
        .where("userEmail", isEqualTo: "${Email}")
        .snapshots()
        .listen((event) {
      if (event.docs.isEmpty) {
        emit(check_Not_Found_state());
      } else {
        userModel = UserModel.fromJson(event.docs[0].data());
        if (userModel!.State == true) {
          emit(check_true_state());
        } else if (userModel!.State == false) {
          emit(check_Flase_state());
        }
      }
    });
  }
//_____________________________________________________________

  List<CourseModel> courseModel = [];
  fetchAllcourseModel({required String studentYear}) {
    emit(courseModelLoadingSuccess());
    try {
      courseModel.clear();
      FirebaseFirestore.instance
          .collection("Courses")
          .where("courseType", isEqualTo: studentYear.toString())
          .snapshots()
          .listen((event) {
        courseModel.clear();
        event.docs.forEach((element) {
          courseModel.add(CourseModel.fromJson(element.data()));
        });
        emit(courseModelSuccess());
      });
    } catch (e) {
      emit(courseModelError());
    }

    // emit(SubjectsSuccess());
  }

  //-----------------------------------------------
}
