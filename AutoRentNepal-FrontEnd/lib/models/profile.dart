class ProfileUser {
/*
{
  "pk": 30,
  "email": "rochak@gmail.com",
  "phone_number": "9876543210",
  "username": "rochak",
  "full_name": "Rochak Piya"
} 
*/

  int? pk;
  String? email;
  String? phoneNumber;
  String? username;
  String? fullName;

  ProfileUser({
    this.pk,
    this.email,
    this.phoneNumber,
    this.username,
    this.fullName,
  });
  ProfileUser.fromJson(Map<String, dynamic> json) {
    pk = json['pk']?.toInt();
    email = json['email']?.toString();
    phoneNumber = json['phone_number']?.toString();
    username = json['username']?.toString();
    fullName = json['full_name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pk'] = pk;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['username'] = username;
    data['full_name'] = fullName;
    return data;
  }
}

class Profile {
/*
{
  "id": 2,
  "profile_image": null,
  "user": {
    "pk": 30,
    "email": "rochak@gmail.com",
    "phone_number": "9876543210",
    "username": "rochak",
    "full_name": "Rochak Piya"
  }
} 
*/

  int? id;
  String? profileImage;
  ProfileUser? user;

  Profile({
    this.id,
    this.profileImage,
    this.user,
  });
  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    profileImage = json['profile_image']?.toString();
    user = (json['user'] != null) ? ProfileUser.fromJson(json['user']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['profile_image'] = profileImage;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
