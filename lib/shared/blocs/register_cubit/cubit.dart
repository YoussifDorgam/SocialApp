import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/creat_user_model.dart';
import 'package:social_app/shared/blocs/register_cubit/status.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class SocialRegistercubit extends Cubit<SocialRegisterStatus> {
  SocialRegistercubit() : super(SocialRegisterInitialStatus());

  static SocialRegistercubit get(context) => BlocProvider.of(context);

 /// method post&Register Screen
  void Register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLodingStatus());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value)
    {
      print(value.user!.email);
      print(value.user!.uid);
      UserCreate(
          email: email,
          name: name,
          phone: phone,
          uid: value.user!.uid);
    }).catchError((error)
    {
      emit(SocialRegisterErrorStatus(error.toString()));
    });
  }


  void UserCreate({
    required String email,
    required String name,
    required String phone,
    required String uid,
  })
  {
    CreateUserModel model = CreateUserModel(
      name: name ,
      email: email ,
      phone: phone ,
      Uid:  uid ,
      cover: '' ,
      isEmailverifision: false ,
      image: '' ,
      bio: ''
    );
    FirebaseFirestore.instance.collection('users').doc(uid).set(model.tomap())
        .then((value)
    {
      emit(SocialCreateUserSuccessStatus());
    }).catchError((error)
    {
      emit(SocialCreateUserErrorStatus(error.toString()));
    });

  }


  IconData iconData =Icons.visibility_outlined ;
  bool isoscureShow = true;
  void eyeisShow() {
    iconData = isoscureShow
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    isoscureShow = !isoscureShow;
    emit(IseyeRegisterShow());
  }
}
