import 'dart:convert';

PatientModel patientModelFromJson(String str) => PatientModel.fromJson(json.decode(str));

String patientModelToJson(PatientModel data) => json.encode(data.toJson());


class UserInfo {
  late String status;
  late List<PatientModel> result = [];

  UserInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    print("Json status is: ${status}");
    print("Agains Json is: ${json['data']}");
    if (json['data'] != null) {
      json['data'].forEach((v) {
        result.add(new PatientModel.fromJson(v));
      });
    }
  }
}

class PatientModel {

  String name;
  String email;
  String gender;
  String dob;
  String city;
  String pincode;
  String phoneNumber;
  String height;
  String weight;
  String bloodGroup;
  PatientModel({
    required this.name,
    required this.email,
    required this.gender,
    required this.dob,
    required this.phoneNumber,
    required this.city,
    required this.pincode,
    required this.height,
    required this.weight,
    required this.bloodGroup,
  });


  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
    name: json["name"]!=null? json["name"]:"",
    email: json["email"]!=null? json["email"]:"",
    gender: json["gender"]!=null?json["gender"]:"",
    dob: json["dob"]!=null?json["dob"].toString():"",
    phoneNumber: json["phone_number"]!=null?json["phone_number"]:"",
    city: json["city"]!=null? json["city"]:"",
    pincode: json["pincode"]!=null?json["pincode"]:"",
    height: json["height"]!=null?json["height"]:"",
    weight: json["weight"]!=null? json["weight"]:"",
    bloodGroup: json["blood_group"]!=null?json["blood_group"]:"",
  );



  
  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "gender": gender,
    "dob": dob,
    "phone_number": phoneNumber,
    "city": city,
    "pincode": pincode,
    "height": height,
    "weight": weight,
    "blood_group": bloodGroup,
  };
}
