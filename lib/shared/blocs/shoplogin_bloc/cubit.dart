import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/blocs/shoplogin_bloc/status.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SocialAppLogincubit extends Cubit<SocialLoginStatus> {
  SocialAppLogincubit() : super(SocialLoginInitialStatus());

  static SocialAppLogincubit get(context) => BlocProvider.of(context);

  void UserLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLodingStatus());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginSuccessStatus(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorStatus(error.toString()));
    });
  }

  IconData iconData =Icons.visibility_outlined ;
  bool isoscureShow = true;

  void eyeisShow() {
    iconData = isoscureShow
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    isoscureShow = !isoscureShow;
    emit(IseyeShow());
  }
}
