import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layou/home_screen.dart';
import 'package:social_app/modules/login_screen.dart';
import 'package:social_app/modules/post_screen.dart';
import 'package:social_app/modules/register_screen.dart';
import 'package:social_app/shared/blocs/App_Cubit/app_cubit.dart';
import 'package:social_app/shared/blocs/App_Cubit/app_status.dart';
import 'package:social_app/shared/blocs/shoplogin_bloc/cubit.dart';
import 'package:social_app/shared/blocs/shoplogin_bloc/status.dart';
import 'package:social_app/shared/combonants/combonants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/remote/catch.helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppCubitStatus>(
      listener: (BuildContext context, state) {
        if (state is AppGoToPostScreenStatus) {
          navegato(context, PostScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = Appcubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: const Text(
              'Social App', style: TextStyle(color: Colors.black),),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.ChageBottomNavBar(index);
            },
            type: BottomNavigationBarType.fixed,
            items:
            const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_sharp), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.post_add_outlined), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on), label: 'Users'),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Setting',),
            ],),
          body: cubit.Screens[cubit.currentindex],
        );
      },
    );
  }
}
