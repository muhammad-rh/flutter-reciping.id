class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? imgUrl;
  String? occupation;
  String? city;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.imgUrl,
    this.occupation,
    this.city,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      imgUrl: map['imgUrl'],
      occupation: map['occupation'],
      city: map['city'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'imgUrl': imgUrl,
      'occupation': occupation,
      'city': city,
    };
  }
}
