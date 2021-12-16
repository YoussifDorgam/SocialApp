class CreateUserModel {
  String? email;

  String? name;
  String? phone;
  String? image;
  String? bio;
  String? cover;
  String? Uid;

  bool? isEmailverifision;

  CreateUserModel({
    this.email,
    this.name,
    this.phone,
    this.Uid,
    this.image,
    this.bio,
    this.cover,
    this.isEmailverifision,
  });

  CreateUserModel.fromjson(Map<String, dynamic>? json) {
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    Uid = json['uid'];
  }

  Map<String, dynamic> tomap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'Uid': Uid,
      'image': image,
      'bio': bio,
      'cover': cover,
      'isEmailverifision': isEmailverifision,
    };
  }
}
