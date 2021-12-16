import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_modek.dart';
import 'package:social_app/shared/blocs/App_Cubit/app_cubit.dart';
import 'package:social_app/shared/blocs/App_Cubit/app_status.dart';

class PostScreen extends StatelessWidget
{
  var textcontrolar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit , AppCubitStatus>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state)
      {
        dynamic imagepost = Appcubit.get(context).userModel;
        dynamic model = Appcubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: const Text('Add post',),
            actions:
            [
              TextButton(onPressed: ()
              {
                var now = DateTime.now() ;
                if(Appcubit.get(context).creatpostimage == null)
                  {
                    Appcubit.get(context).CreatPost(
                      date: now.toString(),
                      text: textcontrolar.text,
                    );
                  }else
                    {
                      Appcubit.get(context).CreatPostImage(
                        date: now.toString(),
                        text: textcontrolar.text,
                      );
                    }

              }, child: const Text('POST',),),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children:
              [
                Row(
                  children: [
                     Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(imagepost!.image!),
                      ),
                    ),
                    const SizedBox(width: 5.0,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                         [
                          Text(
                            imagepost.name! ,
                            style: const TextStyle(
                              height: 1.3 ,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 10,
                      controller: textcontrolar,
                      decoration: const InputDecoration(
                        hintText: 'What is in your mind...' ,
                        border: InputBorder.none ,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0,),
                if(Appcubit.get(context).creatpostimage != null)
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 170.0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                        //  image: NetworkImage('https://image.freepik.com/free-photo/pumpkins-decorated-with-dry-maple-leaves_181624-18933.jpg') ,
                          image: FileImage(model.creatpostimage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: ()
                        {
                          Appcubit.get(context).deletpostimage();
                        },
                        icon: const CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.delete_forever,
                              size: 16.0,
                            ))),
                  ],
                ),
                const SizedBox(height: 20.0,),
                Row(
                  children:
                  [
                    Expanded(
                      child: TextButton(onPressed: ()
                      {
                        Appcubit.get(context).Crreatpostimage();
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        const [
                          Icon(Icons.image),
                          SizedBox(width: 5.0,),
                          Text(
                            'Add Image',
                          ),
                        ],
                      )),
                    ),
                    Expanded(child: TextButton(onPressed: (){}, child: const Text('# tags'))),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
