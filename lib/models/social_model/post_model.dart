class SocialPostModel {
  String? uID;
  String? name;
  String? datePost;
  String? postImage;
  String? text;
  String? image;

  SocialPostModel({
    this.uID,
    this.name,
    this.datePost,
    this.postImage,
    this.text,
    this.image,
  });

  SocialPostModel.fromJson(Map<String, dynamic> json) {
    uID = json['uID'];
    name = json['name'];
    datePost = json['datePost'];
    postImage = json['postImage'];
    text = json['text'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uID': uID,
      'name': name,
      'datePost': datePost,
      'postImage': postImage,
      'text': text,
      'image': image,
    };
  }
}
