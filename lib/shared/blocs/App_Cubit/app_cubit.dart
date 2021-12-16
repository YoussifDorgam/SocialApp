import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/creat_user_model.dart';
import 'package:social_app/models/post_modek.dart';
import 'package:social_app/modules/chat_screen.dart';
import 'package:social_app/modules/home_screen.dart';
import 'package:social_app/modules/post_screen.dart';
import 'package:social_app/modules/setting_screen.dart';
import 'package:social_app/modules/users_scren.dart';
import 'package:social_app/shared/blocs/App_Cubit/app_status.dart';
import 'package:social_app/shared/end_point.dart';

class Appcubit extends Cubit<AppCubitStatus> {
  Appcubit() : super(AppInitialStatus());

  static Appcubit get(context) => BlocProvider.of(context);

  CreateUserModel? userModel;

  void getUserdata() {
    emit(AppGetUserLodingStatus());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      emit(AppGetUserSuccessStatus());
      userModel = CreateUserModel.fromjson(value.data());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetUserErrorStatus());
    });
  }

  var textcontrolar = TextEditingController();

  int currentindex = 0;

  List<Widget> Screens = [
    HomeScreen(),
    ChatScreen(),
    PostScreen(),
    UsersScreen(),
    SettingScreen(),
  ];

  void ChageBottomNavBar(int index) {
    if (index == 2) {
      PostScreen();
      emit(AppGoToPostScreenStatus());
    } else {
      currentindex = index;
      emit(AppChangeBottomNavBarStatus());
    }
  }

  // edit Profile Image
  File? profileimage;
  final ImagePicker picker = ImagePicker();

  Future<void> getprofileimage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      profileimage = File(PickedFile.path);
      emit(AppEditProfileImageSuccessStatus());
    } else {
      print('No image Selected.');
      emit(AppEditProfileImageErrorStatus());
    }
  }

  dynamic profilePic;

  // Uplode profile image
  void uplodeprofilimage(
    String? name,
    String? phone,
    String? bio,
    String? email,
    String? coverImage,
  ) {
    emit(AppUplodeImageProfileLodingStatus());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileimage!.path).pathSegments.last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profilePic = value;
        updateUserData(
            name: name,
            phone: phone,
            bio: bio,
            coverImage: coverImage,
            profileImage: value);
        print(value);
        emit(AppUplodeImageProfileSuccessStatus());
      }).catchError((error) {
        emit(AppUplodeImageProfileErrorStatus());
      });
    }).catchError((error) {
      emit(AppUplodeImageProfileErrorStatus());
    });
  }

  // edit cover image
  File? Coverimage;

  Future getCoverimage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      Coverimage = File(PickedFile.path);
      emit(AppEditCoverImageSuccessStatus());
    } else {
      print('No image Selected.');
      emit(AppEditCoverImageErrorStatus());
    }
  }

  // uplode cover image
  String? coverPic;

  void UplodeCoverimage(String? name, String? phone, String? bio, String? email,
      String? profile) {
    emit(AppUplodeImageCoverLodingStatus());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(Coverimage!.path).pathSegments.last}')
        .putFile(Coverimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          email: email,
          profileImage: profile,
          coverImage: value,
        );
        emit(AppUplodeImageCoverSuccessStatus());
      }).catchError((error) {
        emit(AppUplodeImageCoverErrorStatus());
      });
      emit(AppUplodeImageCoverSuccessStatus());
    }).catchError((error) {
      emit(AppUplodeImageCoverErrorStatus());
    });
  }

  // void updateUser({
  //   String? name,
  //   String? phone,
  //   String? bio,
  //   String? cover,
  //   String? imagepro,
  // }) {
  //   emit(AppUserLodingStatus());
  //   if (Coverimage != null) {
  //     UplodeCoverimage();
  //   } else if (profileimage != null) {
  //     uplodeprofilimage();
  //   } else if (Coverimage != null && profileimage != null) {
  //   } else {
  //     CreateUserModel model = CreateUserModel(
  //       name: name,
  //       email: userModel!.email,
  //       phone: phone,
  //       Uid: uid,
  //       isEmailverifision: false,
  //       cover: cover ?? userModel!.cover,
  //       image: imagepro ?? userModel!.image,
  //       bio: bio,
  //     );
  //     FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uid)
  //         .update(model.tomap())
  //         .then((value) {
  //       getUserdata();
  //     }).catchError((error) {
  //       print(error.toString());
  //       emit(AppUserErrorStatus());
  //     });
  //   }
  // }
  void updateUserData({
    String? name,
    String? phone,
    String? email,
    String? bio,
    String? coverImage,
    String? profileImage,
  }) {
    emit(AppUserLodingStatus());
    CreateUserModel model = CreateUserModel(
        Uid: uid,
        name: name,
        phone: phone,
        bio: bio,
        email: email,
        cover: coverImage,
        image: profileImage);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(model.tomap())
        .then((value) {
      getUserdata();
      emit(AppUserSuccessStatus());
    }).catchError((error) {
      print(error.toString());
      emit(AppUserErrorStatus());
    });
  }

//////////////////////////////////////////////////////////////////////////////////////
  File? creatpostimage;

  void deletpostimage() {
    creatpostimage = null;
    emit(deletpost());
  }

  Future Crreatpostimage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      creatpostimage = File(PickedFile.path);
      emit(AppEditCoverImageSuccessStatus());
    } else {
      print('No image Selected.');
      emit(AppEditCoverImageErrorStatus());
    }
  }

  void CreatPostImage({required String text, required String date}) {
    emit(AppUplodePostImageLodingStatus());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(creatpostimage!.path).pathSegments.last}')
        .putFile(creatpostimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        CreatPost(
          text: text,
          date: date,
          imagepost: value,
        );
      }).catchError((error) {
        emit(AppUplodePostImageErrorStatus());
      });
    }).catchError((error) {
      emit(AppUplodePostImageErrorStatus());
    });
  }

  void CreatPost({
    String? text,
    String? date,
    String? imagepost,
  }) {
    emit(AppUplodePostImageLodingStatus());
    PostModel model = PostModel(
      Uid: uid,
      name: userModel!.name,
      image: userModel!.image,
      text: text,
      date: date,
      postimage: imagepost ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.tomap())
        .then((value) {
      emit(AppUplodePostImageSuccessStatus());
    }).catchError((error) {
      print(error.toString());
      emit(AppUplodePostImageErrorStatus());
    });
  }

///////////////////////////////////////////////////////////////////////////////////////
  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<int> comment = [];

  void getpostdata() {
    emit(AppGetPostsLodingStatus());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('like')
            .get().then((value) {
         // comment.add(value.docs.length);
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromjson(element.data()));
        });
      });
      emit(AppGetPostsSuccessStatus());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetPostsErrorStatus());
    });
  }

  void Likepost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('like')
        .doc(userModel!.Uid)
        .set({
      'like': true,
    }).then((value) {
      emit(AppLikePostSuccessStatus());
    }).catchError((error) {
      emit(AppLikePostErrorStatus());
    });
  }

  /////////////////////////////////////////////////////////////////////////////////
//   void postComment(String postId, {String? CommentId, required String text}) {
//     FirebaseFirestore.instance
//         .collection('posts')
//         .doc(CommentId)
//         .collection('comment')
//         .doc(userModel!.Uid)
//         .set({
//       'comment': text,
//     }).then((value) {
//       emit(AppCommentPostSuccessStatus());
//     }).catchError((error) {
//       emit(AppCommentPostErrorStatus());
//     });
//   }
//
//   List<PostModel> commentdata = [];
//
//   void getcommentdata() {
//     emit(AppGetPostsLodingStatus());
//     FirebaseFirestore.instance
//         .collection('posts')
//         .doc(uid)
//         .collection('comment')
//         .get()
//         .then((value) {
//       value.docs.forEach((element) {
//         element.reference.collection('likes').get().then((value) {
//           commentdata.add(PostModel.fromjson(element.data()));
//         });
//       });
//       emit(AppGetPostsSuccessStatus());
//     }).catchError((error) {
//       print(error.toString());
//       emit(AppGetPostsErrorStatus());
//     });
//   }
//
//   void CreatComment({
//     required String comment,
//   }) {
//     emit(AppUplodeCommentLodingStatus());
//     PostModel model = PostModel(
//       comment: comment,
//     );
//     FirebaseFirestore.instance
//         .collection('posts')
//         .doc()
//         .collection('commentS')
//         .add(model.tomap())
//         .then((value) {
//       emit(AppUplodeCommentSuccessStatus());
//     }).catchError((error) {
//       print(error.toString());
//       emit(AppUplodeCommentErrorStatus());
//     });
//   }
 }
