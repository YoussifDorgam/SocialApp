import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/creat_user_model.dart';
import 'package:social_app/shared/blocs/App_Cubit/app_cubit.dart';
import 'package:social_app/shared/blocs/App_Cubit/app_status.dart';
import 'package:social_app/shared/combonants/combonants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';



class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    var nameControlar = TextEditingController();
    var bioControlar = TextEditingController();
    var phoneControlar = TextEditingController();

    return BlocConsumer<Appcubit, AppCubitStatus>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var userModel = Appcubit.get(context).userModel;
          var profileimage = Appcubit.get(context).profileimage;
          var coverimage = Appcubit.get(context).Coverimage;

          nameControlar.text = userModel!.name!;
          bioControlar.text = userModel.bio!;
          phoneControlar.text = userModel.phone!;

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit profile',
              ),
              actions: [
                TextButton(onPressed: ()
                {
                  Appcubit.get(context).updateUserData(
                  name: nameControlar.text,
                  phone: phoneControlar.text,
                  bio: bioControlar.text,
                  email: userModel.email,
                  profileImage: userModel.image,
                coverImage: userModel.cover
                );
                // if(state is UserSuccessState) {
                // pop(context);
                // }
                }, child: const Text('Update')),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children:
                [
                  if(state is AppUserLodingStatus)
                  const LinearProgressIndicator(),
                  SizedBox(
                    height: 250.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: const EdgeInsets.all(8.0),
                                child: coverimage == null ? Image.network(
                                  '${userModel.cover}',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  height: 180.0,
                                )  : Image.file(coverimage) as Widget ,
                                elevation: 0.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                    onPressed: ()
                                    {
                                      Appcubit.get(context).getCoverimage().then((value)
                                      {
                                          Appcubit.get(context)
                                              .UplodeCoverimage(
                                            userModel.name,
                                            userModel.phone,
                                            userModel.bio,
                                            userModel.email,
                                            userModel.cover,
                                          );
                                      });
                                    },
                                    icon: const CircleAvatar(
                                        radius: 15,
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 16.0,
                                        ))),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 64.0,
                                  child: CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: profileimage == null ? NetworkImage(
                                      '${userModel.image}',
                                    ) : FileImage(profileimage) as ImageProvider ,
                                  ),
                                ),
                                IconButton(
                                    onPressed: ()
                                    {
                                      Appcubit.get(context).getprofileimage().then((value)
                                      {
                                        Appcubit.get(context)
                                            .uplodeprofilimage(
                                          userModel.name,
                                          userModel.phone,
                                          userModel.bio,
                                          userModel.email,
                                          userModel.image,
                                        );
                                      });
                                    },
                                    icon: const CircleAvatar(
                                        radius: 15,
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 16.0,
                                        ))),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  TextButton(onPressed: ()
                  {

                  }, child: Text('Uplode Image') ),
                  const SizedBox(height: 20.0,),
                  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: defulteditTextx(
                      Controlar: nameControlar,
                      keyboardType: TextInputType.name,
                      Lable: 'Name',
                      prefix: Icons.supervised_user_circle_outlined),
                ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: defulteditTextx(
                        Controlar: bioControlar,
                        keyboardType: TextInputType.text,
                        Lable: 'bio',
                        prefix: Icons.insert_emoticon_outlined),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: defulteditTextx(
                        Controlar: phoneControlar,
                        keyboardType: TextInputType.phone,
                        Lable: 'Phone number',
                        prefix: Icons.phone),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
