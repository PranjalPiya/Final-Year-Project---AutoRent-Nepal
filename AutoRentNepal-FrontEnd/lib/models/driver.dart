class Driver {
/*
{
  "id": 1,
  "name": "Shyam Kumar",
  "age": "35",
  "image": "/media/DriverImages/default.png",
  "phone": "9876543230",
  "about": "Shyam Kumar is an excellent driver with driving experience of more than 10 years."
} 
*/

  int? id;
  String? name;
  String? age;
  String? image;
  String? phone;
  String? about;

  Driver({
    this.id,
    this.name,
    this.age,
    this.image,
    this.phone,
    this.about,
  });
  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    age = json['age']?.toString();
    image = json['image']?.toString();
    phone = json['phone']?.toString();
    about = json['about']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['image'] = image;
    data['phone'] = phone;
    data['about'] = about;
    return data;
  }
}
