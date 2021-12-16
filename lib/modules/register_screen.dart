import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layou/home_screen.dart';
import 'package:social_app/modules/login_screen.dart';
import 'package:social_app/shared/blocs/register_cubit/cubit.dart';
import 'package:social_app/shared/blocs/register_cubit/status.dart';
import 'package:social_app/shared/combonants/combonants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


class RegisterScreen extends StatelessWidget {
  var PasswordConerolar = TextEditingController();
  var NamedConerolar = TextEditingController();
  var EmailConerolar = TextEditingController();
  var PhoneConerolar = TextEditingController();
  var Formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegistercubit() ,
      child: BlocConsumer<SocialRegistercubit, SocialRegisterStatus>(
        listener: (BuildContext context, state) {
          // if (state is SocialRegisterSuccessStatus) {
          //   if (state.userRegisterModel.status == true) {
          //     print(state.userRegisterModel.status);
          //     print(state.userRegisterModel.message);
          //     print(state.userRegisterModel.data!.token);
          //     Fluttertoast.showToast(
          //         msg: state.userRegisterModel.message.toString(),
          //         toastLength: Toast.LENGTH_LONG,
          //         gravity: ToastGravity.BOTTOM,
          //         timeInSecForIosWeb: 5,
          //         backgroundColor: Colors.green,
          //         textColor: Colors.white,
          //         fontSize: 16.0);
          //     cachHelper.Savedataa(
          //             key: 'token', value: state.userRegisterModel.data!.token)
          //         .then((value) {
          //       token = state.userRegisterModel.data!.token!;
          //       print(value.toString());
          //       NavegatandFinish(context, SocialLayout());
          //       NamedConerolar.clear();
          //       PhoneConerolar.clear();
          //       EmailConerolar.clear();
          //       PasswordConerolar.clear();
          //       // confirmPassword.clear();
          //       // navigateAndKill(context, SocialLayout());
          //       Socialcubit.get(context).currentindex = 0;
          //       Socialcubit.get(context).gethomedata();
          //       Socialcubit.get(context).getSocialprofaileData();
          //       // SocialCubit.get(context).getFavoriteData();
          //       // SocialCubit.get(context).getCartData();
          //       // SocialCubit.get(context).getAddresses();
          //     }).catchError((error) {
          //       print(error.toString());
          //     });
          //   } else {
          //     Fluttertoast.showToast(
          //         msg: state.userRegisterModel.message.toString(),
          //         toastLength: Toast.LENGTH_LONG,
          //         gravity: ToastGravity.BOTTOM,
          //         timeInSecForIosWeb: 5,
          //         backgroundColor: Colors.red,
          //         textColor: Colors.white,
          //         fontSize: 16.0);
          //   }
          // }
          if(state is SocialCreateUserSuccessStatus)
            {
              NavegatandFinish(context, HomeScreenLayout());
            }
        },
        builder: (BuildContext context, Object? state) {
          var cubit = SocialRegistercubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
            ),
            body: Form(
              key: Formkey,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Text(
                          'Register naw you browse our hot offers',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defulteditTextx(
                          Controlar: NamedConerolar,
                          keyboardType: TextInputType.text,
                          Lable: 'Full Name',
                          prefix: Icons.person,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'PLease Inter your Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defulteditTextx(
                          Controlar: EmailConerolar,
                          keyboardType: TextInputType.text,
                          Lable: 'Email',
                          prefix: Icons.email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'PLease Inter your Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defulteditTextx(
                          Controlar: PhoneConerolar,
                          keyboardType: TextInputType.phone,
                          Lable: 'Phone',
                          prefix: Icons.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'PLease Inter your Phone';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defulteditTextx(
                          Controlar: PasswordConerolar,
                          keyboardType: TextInputType.text,
                          Lable: 'Password',
                          prefix: Icons.lock,
                          sufix: cubit.iconData,
                          obscureText: cubit.isoscureShow,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'PLease Inter your Password';
                            }
                            return null;
                          },
                          onfiled: (value) {
                            print(value);
                          },
                          onSubmit: (value) {
                            if (Formkey.currentState!.validate()) {
                              cubit.Register(
                                email: EmailConerolar.text,
                                password: PasswordConerolar.text,
                                name: NamedConerolar.text,
                                phone: PhoneConerolar.text ,
                              );

                            }
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: true,
                          builder: (context) =>  bottom(
                              width: double.infinity,
                              color: Colors.deepOrange,
                              onpressed: () {
                                if (Formkey.currentState!.validate()) {
                                  cubit.Register(
                                    email: EmailConerolar.text,
                                    password: PasswordConerolar.text,
                                    name: NamedConerolar.text,
                                    phone: PhoneConerolar.text ,
                                  );

                                }
                              },
                              text: 'REGISTER'),
                          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()) ,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Have an account yet ?',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {
                                navegato(context, SocialLoginScreen());
                              },
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ],
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
