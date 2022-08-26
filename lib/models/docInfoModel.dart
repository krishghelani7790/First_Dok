// To parse this JSON data, do
//
//     final docInfoModel = docInfoModelFromJson(jsonString);

import 'dart:convert';

DocInfoModel docInfoModelFromJson(String str) => DocInfoModel.fromJson(json.decode(str));

String docInfoModelToJson(DocInfoModel data) => json.encode(data.toJson());

class DocInfoModel {
  String name;
  String email;
  String gender;
  String age;
  String phoneNumber;
  String city;
  String pincode;
  String medicalAreas;
  String workingHours;
  String highestQualification;
  String experienceYears;
  String approvalRating;

  DocInfoModel({
    required this.name,
    required this.email,
    required this.gender,
    required this.age,
    required this.phoneNumber,
    required this.city,
    required this.pincode,
    required this.medicalAreas,
    required this.workingHours,
    required this.highestQualification,
    required this.experienceYears,
    required this.approvalRating,
  });
  factory DocInfoModel.fromJson(Map<String, dynamic> json) => DocInfoModel(
    name: json["name"],
    email: json["email"],
    gender: json["gender"],
    age: json["age"],
    phoneNumber: json["phone_number"],
    city: json["city"],
    pincode: json["pincode"],
    medicalAreas: json["medical_areas"],
    workingHours: json["working_hours"],
    highestQualification: json["highest_qualification"],
    experienceYears: json["experience_years"],
    approvalRating: json["approval_rating"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "gender": gender,
    "age": age,
    "phone_number": phoneNumber,
    "city": city,
    "pincode": pincode,
    "medical_areas": medicalAreas,
    "working_hours": workingHours,
    "highest_qualification": highestQualification,
    "experience_years": experienceYears,
    "approval_rating": approvalRating,
  };
}
