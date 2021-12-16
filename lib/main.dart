import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/layou/home_screen.dart';
import 'package:social_app/modules/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/shared/blocs/App_Cubit/app_cubit.dart';
import 'package:social_app/shared/blocs/shoplogin_bloc/blocobservar.dart';
import 'package:bloc/bloc.dart';
import 'package:social_app/shared/end_point.dart';
import 'package:social_app/shared/remote/catch.helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await cachHelper.init();
  await Firebase.initializeApp();

  Widget widget  = HomeScreenLayout();
  uid = cachHelper.getData('uid');
  if( uid != null  )
    {
     widget = HomeScreenLayout() ;
    }else
      {
        widget = SocialLoginScreen() ;
      }
  runApp( MyApp(Startapp: widget,));
}

class MyApp extends StatelessWidget {
 late final Widget Startapp ;

 MyApp({required this.Startapp});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: 
      [
        BlocProvider(create: (context) => Appcubit()..getUserdata()..getpostdata()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme:  const AppBarTheme(
            backwardsCompatibility: false ,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white ,
            ),
            backgroundColor: Colors.white ,
            elevation: 0.0 ,
            titleTextStyle: TextStyle(
              color: Colors.black ,
              fontSize: 20.0 ,
              fontWeight: FontWeight.w600 ,
            ),
            iconTheme: IconThemeData(
              color: Colors.black ,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white ,
            unselectedItemColor: Colors.grey ,
            selectedItemColor: Colors.deepOrange ,
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.black ,
              fontSize: 18.0 ,

            ),
          ),
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.black12,
          appBarTheme:  AppBarTheme(
            backwardsCompatibility: false ,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black12 ,
            ),
            backgroundColor: Colors.black12 ,
            elevation: 0.0 ,
            titleTextStyle: TextStyle(
              color: Colors.white ,
              fontSize: 20.0 ,
              fontWeight: FontWeight.w600 ,
            ),
            iconTheme: IconThemeData(
              color: Colors.white ,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.black12 ,
            unselectedItemColor: Colors.grey ,
            selectedItemColor: Colors.deepOrange ,
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.white ,
              fontSize: 18.0 ,

            ),
          ),
        ),
        themeMode:  ThemeMode.light ,
        debugShowCheckedModeBanner: false,
        home:Startapp ,
      ),
    );
  }
}

