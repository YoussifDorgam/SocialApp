import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_modek.dart';
import 'package:social_app/shared/blocs/App_Cubit/app_cubit.dart';
import 'package:social_app/shared/blocs/App_Cubit/app_status.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppCubitStatus>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = Appcubit.get(context);
        return ConditionalBuilder(
          condition: cubit.posts.isNotEmpty,
          builder: (BuildContext context) =>
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: const EdgeInsets.all(8.0),
                          child: Image.network(
                            'https://image.freepik.com/free-photo/impressed-young-man-points-away-shows-direction-somewhere-gasps-from-wonderment_273609-27041.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 160.0,
                          ),
                          elevation: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Communicate with friends',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildpostItem(cubit.posts[index], context, index),
                        separatorBuilder: (context, index) =>
                        const SizedBox(
                          height: 1.0,
                        ),
                        itemCount: cubit.posts.length),
                  ],
                ),
              ),
          fallback: (BuildContext context) =>
          const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildpostItem(PostModel model, context, index) =>
    Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
      elevation: 6.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(model.image!),
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          model.name!,
                          style: const TextStyle(height: 1.3),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 17.0,
                        )
                      ],
                    ),
                    Text(
                      model.date!,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          if(model.text != '')
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                model.text!,
                maxLines: 6,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                end: 5.0, start: 5.0, top: 10, bottom: 10),
            child: SizedBox(
              width: double.infinity,
              child: Wrap(children: const [
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 5.0),
                  child: Text(
                    '#flutter_devolibment',
                    style: TextStyle(color: Colors.blue, fontSize: 13.0),
                  ),
                ),
              ]),
            ),
          ),
          if(model.postimage != '')
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(model.postimage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 8.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.comment,
                          color: Colors.amberAccent,
                          size: 17,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Comment',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${Appcubit
                            .get(context)
                            .likes[index]}',
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(model.image!),
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: 1,
                    controller: Appcubit
                        .get(context)
                        .textcontrolar,
                    decoration: const InputDecoration(
                      hintText: 'Write a comment...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //    Appcubit.get(context).postComment(Appcubit.get(context).postId[index], text:Appcubit.get(context).textcontrolar.text,  );
                    // Appcubit.get(context).CreatComment(comment: Appcubit.get(context).textcontrolar.text);
                  },
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.send,
                          color: Colors.blue,
                          size: 17,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),

                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Appcubit.get(context).Likepost(Appcubit
                        .get(context)
                        .postId[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                          size: 17,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
