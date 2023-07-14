import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app/business_logic/Learn_Cubit/learn_state.dart';
import 'package:course_app/models/2Courses/2Course_model.dart';
import 'package:course_app/models/3Learn/3LearnModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Learn_Cubit extends Cubit<Learn_States> {
  Learn_Cubit() : super(LearnInitialState());

  static Learn_Cubit get(context) => BlocProvider.of(context);

  List<LearnModel> ListlearnModel = [];

  fetchAllLearn({required CourseModel courseModel}) {
    emit(LearnLoadingSuccess());
    ListlearnModel.clear();
    FirebaseFirestore.instance
        .collection('Learn')
        .doc(courseModel.courseId)
        .collection("lessons")
        .orderBy("LearndataTime")
        .snapshots()
        .listen((event) {
      ListlearnModel.clear();
      event.docs.forEach((element) {
        ListlearnModel.add(LearnModel.fromJson(element.data()));
      });
      emit(LearnSuccess());
    });
  }
}
