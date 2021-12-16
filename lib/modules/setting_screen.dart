import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/edit_profil_screen.dart';
import 'package:social_app/shared/blocs/App_Cubit/app_cubit.dart';
import 'package:social_app/shared/blocs/App_Cubit/app_status.dart';
import 'package:social_app/shared/combonants/combonants.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppCubitStatus>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cUserModel = Appcubit.get(context).userModel;
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 250.0,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: const EdgeInsets.all(8.0),
                        child: Image.network(
                          '${cUserModel!.cover}',
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: 180.0,
                        ),
                        elevation: 0.0,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 64.0,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                          '${cUserModel.image}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 8.0),
                child: Text(
                  '${cUserModel.name}',
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 8.0),
                child: Text(
                  '${cUserModel.bio}',
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 8.0),
                            child: Text(
                              '100',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 8.0),
                            child: Text(
                              'Posts',
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 8.0),
                            child: Text(
                              '256',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 8.0),
                            child: Text(
                              'Photos',
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 8.0),
                            child: Text(
                              '10k',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 8.0),
                            child: Text(
                              'Followers',
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 8.0),
                            child: Text(
                              '60',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 8.0),
                            child: Text(
                              'Followings',
                              style:
                                  TextStyle(fontSize: 12.0, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: OutlinedButton(onPressed:(){}, child: const Text('Add Photo'),)),
                    const SizedBox(width: 10.0,),
                    OutlinedButton(onPressed:()
                    {
                      navegato(context, const EditProfileScreen());
                    }, child: const Icon(Icons.edit)),
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
