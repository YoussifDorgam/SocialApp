class PostModel {
  String? name;
  String? image;
  String? Uid;
  String? date;
  String? text;
  String? postimage;

  PostModel({
    this.name,
    this.Uid,
    this.image,
    this.date,
    this.text,
    this.postimage,
  });

  PostModel.fromjson(Map<String, dynamic>? json) {
    name = json!['name'];
    date = json['date'];
    image = json['image'];
    text = json['text'];
    postimage = json['postimage'];
    Uid = json['uid'];
  }

  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'date': date,
      'Uid': Uid,
      'image': image,
      'text': text,
      'postimage': postimage,
    };
  }
}


///////////////////////////
class commentmodel{

}
