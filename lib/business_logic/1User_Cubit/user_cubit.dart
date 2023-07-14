import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:course_app/business_logic/1User_Cubit/user_state.dart';
import 'package:course_app/models/1authentication/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';

import '../../shared/network/cache_helper.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);

  FirebaseAuth Finstance = FirebaseAuth.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? photo;
  final ImagePicker _picker = ImagePicker();
  var FinaUrl = "";

//__________________________________________________________
  void Login_cubit({required Femail, required Fpassword}) {
    emit(LoginLoading());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: Femail,
      password: Fpassword,
    )
        .then((value) async {
      var user = FirebaseAuth.instance.currentUser;
      String Uid = await user!.uid;

      CacheHelper.saveData(
        key: 'User_UID',
        value: Uid,
      ).then((value) {
        CacheHelper.saveData(
          key: 'User_Email',
          value: Femail.toString(),
        );
      });
      emit(LoginSuceccful());
    }).catchError((error) {
      emit(Loginerror());

      // if (error.runtimeType == FirebaseAuthException) {
      //   FirebaseAuthException firebaseAuthException = error;
      //   if (firebaseAuthException == 'user-not-found') {
      //     print(firebaseAuthException.code.toString());
      //   }
      // }
      // emit(Loginerror());
      // if (error == 'auth/invalid-email') {
      //   emit(Loginerrorinvalid_email());

      //   print('Invalid email');
      // }
      // // } else if (error.code == 'user-not-found') {
      // //   emit(Loginerroruser_not_found());

      // //   print('Hi, User not found');
      // // } else if (error.code == 'wrong-password') {
      // //   emit(Loginerrorwrong_password());
      // //   print("Wrong Password");
      // // }
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialChangePasswordVisibilityState());
  }
  //______________________________________________________________

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      // uploadFile();
    } else {
      print('No image selected.');
    }

    emit(UploadImageState());
  }

  Future uploadFile({required UserModel FuserModel}) async {
    emit(SignUpLoading());

    if (photo == null) {
      Sign_Up_cubit(
          FuserModel: UserModel(
        userId: "",
        userName: FuserModel.userName,
        userEmail: FuserModel.userEmail,
        userPassword: FuserModel.userPassword,
        userYear: FuserModel.userYear,
        dataTime: FuserModel.dataTime,
        phoneNumber: FuserModel.phoneNumber,
        userimage: "",
        State: FuserModel.State,
      ));
      // emit(SignUpSuceccful());
    } else {
      final fileName = basename(photo!.path);
      final destination = 'files/UserFoto';

      try {
        final ref = firebase_storage.FirebaseStorage.instance
            .ref(destination)
            .child('file/${fileName}');
        await ref.putFile(photo!);
        FinaUrl = (await ref.getDownloadURL()).toString();
        Sign_Up_cubit(
            FuserModel: UserModel(
          userId: "",
          userName: FuserModel.userName,
          userEmail: FuserModel.userEmail,
          userPassword: FuserModel.userPassword,
          userYear: FuserModel.userYear,
          dataTime: FuserModel.dataTime,
          phoneNumber: FuserModel.phoneNumber,
          userimage: FinaUrl,
          State: FuserModel.State,
        ));
        // emit(SignUpSuceccful());
      } catch (e) {
        emit(SignUperror());
        print('error occured');
      }
    }
  }
  //_______________________________________________________

  void Sign_Up_cubit({required UserModel FuserModel}) {
    // emit(SignUpLoading());

    Finstance.createUserWithEmailAndPassword(
            email: FuserModel.userEmail.toString(),
            password: FuserModel.userPassword.toString())
        .then((value) async {
      var uId = FirebaseFirestore.instance.collection('Users').doc();
      // uploadFile();
      await CacheHelper.saveData(
        key: 'User_Email',
        value: FuserModel.userEmail.toString(),
      ).then((value) {});

      UserModel userModel = UserModel(
        userId: uId.id.toString(),
        userName: FuserModel.userName,
        userEmail: FuserModel.userEmail,
        userPassword: FuserModel.userPassword,
        userYear: FuserModel.userYear,
        dataTime: FuserModel.dataTime,
        phoneNumber: FuserModel.phoneNumber,
        userimage: FinaUrl,
        State: FuserModel.State,
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId.id)
          .set(userModel.toMap())
          .then((value) async {})
          .catchError((error) {
        print(error.toString());
      });
      var user = FirebaseAuth.instance.currentUser;
      String Uid = await user!.uid;

      await CacheHelper.saveData(
        key: 'User_UID',
        value: Uid,
      ).then((value) {
        emit(SignUpSuceccful());
      });
      // emit(SignUpSuceccful());
    }).catchError((error) {
      emit(SignUperror());

      // emit(SignUperror());
    });
  }

  //_____________________________________
  String selectedValue = "اولي ثانوي";
  void updateSelectedValue(String newValue) {
    selectedValue = newValue;
    emit(DropdownState());
  }
}
