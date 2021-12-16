import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layou/home_screen.dart';
import 'package:social_app/modules/register_screen.dart';
import 'package:social_app/shared/blocs/shoplogin_bloc/cubit.dart';
import 'package:social_app/shared/blocs/shoplogin_bloc/status.dart';
import 'package:social_app/shared/combonants/combonants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/remote/catch.helper.dart';


class SocialLoginScreen extends StatelessWidget {
  var EmailControlar = TextEditingController();
  var PasswordConerolar = TextEditingController();
  var Formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialAppLogincubit() ,
      child: BlocConsumer<SocialAppLogincubit, SocialLoginStatus>(
        listener: (BuildContext context, state)
        {

          if(state is SocialLoginErrorStatus)
            {
              Fluttertoast.showToast(
                  msg: state.error,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          if(state is  SocialLoginSuccessStatus)
            {
              print(state.uid);
              cachHelper.Savedataa(key: 'uid', value: state.uid ).then((value)
              {
                NavegatandFinish(context, HomeScreenLayout());
              });
            }

        },
        builder: (BuildContext context, Object? state) {
          var cubit = SocialAppLogincubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Form(
                      key: Formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          const Text(
                            'Login naw you browse our hot offers',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          defulteditTextx(
                            Controlar: EmailControlar,
                            keyboardType: TextInputType.text,
                            Lable: 'Email Address',
                            prefix: Icons.email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is to Short';
                              }
                              return null;
                            },
                            onfiled: (value) {
                              print(value);
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defulteditTextx(
                            Controlar: PasswordConerolar,
                            keyboardType: TextInputType.text,
                            Lable: 'Password',
                            prefix: Icons.lock,
                            sufix: cubit.iconData,
                            obscureText: cubit.isoscureShow,
                            suffixPressed: () {
                              cubit.eyeisShow();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is to Short';
                              }
                              return null;
                            },
                            onfiled: (value) {
                              print(value);
                            },
                            onSubmit: (value) {
                              if (Formkey.currentState!.validate()) {
                                cubit.UserLogin(
                                    email: EmailControlar.text,
                                    password: PasswordConerolar.text);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! SocialLoginLodingStatus,
                            builder: (BuildContext context) => bottom(
                                width: double.infinity,
                                color: Colors.deepOrange,
                                onpressed: () {
                                  if (Formkey.currentState!.validate()) {
                                    cubit.UserLogin(
                                        email: EmailControlar.text,
                                        password: PasswordConerolar.text);
                                  }
                                },
                                text: 'Login'),
                            fallback: (BuildContext context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t Have an account yet ?',
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextButton(
                                onPressed: () {
                                  navegato(context, RegisterScreen());
                                },
                                child: const Text('Register'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
