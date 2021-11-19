class SocialUserModel {
  String? uID;
  String? name;
  String? email;
  String? phone;
  String? cover;
  String? image;
  String? bio;
  bool? isEmailVerified;

  SocialUserModel({
    this.uID,
    this.name,
    this.email,
    this.phone,
    this.cover,
    this.image,
    this.bio,
    this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    uID = json['uID'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    cover = json['cover'];
    image = json['image'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uID': uID,
      'name': name,
      'email': email,
      'phone': phone,
      'cover': cover,
      'image': image,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
    };
  }
}
