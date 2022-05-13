class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? imgUrl;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.imgUrl,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      imgUrl: map['imgUrl'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'imgUrl': imgUrl,
    };
  }
}
