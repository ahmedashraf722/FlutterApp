class SocialUserModel {
  String? uID;
  String? name;
  String? email;
  String? phone;
  bool? isEmailVerified;

  SocialUserModel({
    this.uID,
    this.name,
    this.email,
    this.phone,
    this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    uID = json['uID'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uID': uID,
      'name': name,
      'email': email,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
    };
  }
}
