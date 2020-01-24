import 'dart:convert';

PoliceModel policeFromJson(String str) {
  final jsonData = json.decode(str);
  return PoliceModel.fromMap(jsonData);
}

String policeToJson(PoliceModel data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class PoliceModel {
  int id;
  String name;
  String gender;
  String dep;
  String image;
  int age;

  PoliceModel({
    this.id,
    this.name,
    this.gender,
    this.dep,
    this.image,
    this.age,
  });

  factory PoliceModel.fromMap(Map<String, dynamic> json) => new PoliceModel(
    id: json["id"],
    name: json["name"],
    gender: json["gender"],
    dep: json["dep"],
    image: json["image"],
    age: json["age"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "gender": gender,
    "dep": dep,
    "image": image,
    "age": age,
  };
}