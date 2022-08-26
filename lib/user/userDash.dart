import 'dart:convert';

import 'package:patientapp/doctor/doctorListSpeciality.dart';
import 'package:patientapp/instant_consultation/instantBookingForm.dart';
import 'package:patientapp/screens/settingScreen.dart';
import 'package:patientapp/user/specialityCategory.dart';
import 'package:patientapp/user/symptoms.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../doctor/bookAppointment.dart';

class UserDashboard extends StatefulWidget {
  final String name;
  final String phone;
  // final String age;
  final String gender;
  final String ID;
  final String dob;
  UserDashboard(
      {Key? key,
      required this.name,
      required this.phone,
      required this.ID,
      // required this.age,
      required this.gender,
      required this.dob})
      : super(key: key);

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  var Age;
  late var userName = "";
  late var userEmail = "";
  late var userAge = "";
  late var userGender = "";
  late var userDOB = "";
  late var userCity = "";
  late var userPincode = "";
  late var userPhone = "";
  late var userHeight = "";
  late var userWeight = "";
  late var userBloodGroup = "";
  calculateAge() {
    print("Initiall dob is :${widget.dob}");
    String dob = widget.dob;
    int birthYear = int.parse(dob.substring(0, 4));
    int birthMonth = int.parse(dob.substring(5, 7));
    int birthtDay = int.parse(dob.substring(8, 10));
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthYear;
    print("Year is: $age");
    int month1 = currentDate.month;
    int month2 = birthMonth;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthtDay;
      if (day2 > day1) {
        age--;
      }
    }
    setState(() {
      Age = age;
    });
    Age = age;
    print("Age is ${age}");
    return age;
  }

  String? _uploadedFileURL;
  Future<String?> getUserID() async {
    print("Phone is ${widget.phone}");
    print("Inside Info");
    var client = http.Client();
    var user_Info = await client.get(Uri.parse(
        'https://doctor2-kylo.herokuapp.com/patient/info/${widget.phone}'));
    print(user_Info);
    if (user_Info.statusCode == 200) {
      final String responseBody = user_Info.body;
      // print('Decoded user info is: ${json.decode(responseBody)}');
      var _user = json.decode(responseBody);
      print("User Info is123456: ${_user}");
      if (_user['data'] != null) {
        setState(() {
          userName = _user['data']['name'];
          userEmail = _user['data']['email'];
          userGender = _user['data']['gender'];
          userDOB = _user['data']['dob'];
          userCity = _user['data']['city'];
          userPincode = _user['data']['pincode'].toString();
          userPhone = _user['data']['phone_number'].toString();
          userHeight = _user['data']['height'].toString();
          userWeight = _user['data']['weight'].toString();
          userBloodGroup = _user['data']['blood_group'];
          _uploadedFileURL = _user['data']['profile_url'];
          return _user;
        });
      }
    } else {
      return null;
    }
  }

  @override
  void initState() {
    calculateAge();
    getUserID();
    super.initState();
  }

//  @override
//   void dispose() {
//     calculateAge();
//     getUserID();
//     super.dispose();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Welcome, ${widget.name}",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            GestureDetector(
              child: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onTap: () {
                // await calculateAge(widget.dob as DateTime);
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => Setting(
                            phone: widget.phone,
                            name: userName,
                            age: Age.toString(),
                            gender: userGender,
                            ID: widget.ID,
                            // dob: widget.dob,
                            profile_url: _uploadedFileURL,
                          )),
                );
              },
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
        body: FutureBuilder(
            future: medicalAreas(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/img_2.png",
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Search By Speciality",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 15)
                            // TextButton(
                            //     onPressed: () {
                            //       DateTime now = DateTime.now();

                            //       String convertedDateTime =
                            //           "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";

                            //           print('${convertedDateTime}');
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) =>
                            //                   SpecialityCategory(
                            //                     phone: widget.phone,
                            //                   )));
                            //     },
                            //     child: Text("View All")) //todo:on press
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.push(context, MaterialRoutePage)
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorListAccSpeciality(name1: 'do Chi', name2: 'Xhintan Devani', name3: 'Naman Jain', name4: 'Ravi')
                                              ));
                                },
                                child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[200]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('General Physician',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () {
                                  // Navigator.push(context, MaterialRoutePage)
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorListAccSpeciality(name1: '')
                                              ));
                                },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[200]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Child Specialist',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () {
                                  // Navigator.push(context, MaterialRoutePage)
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorListAccSpeciality(name1: '')
                                              ));
                                },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[200]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Skin & Hair',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width - 40,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff3E64FF),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Text(
                              "View All",
                              style: TextStyle(fontSize: 15),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => userSymptoms(
                                            name: widget.name,
                                            phone: widget.phone,
                                            Id: widget.ID,
                                          )));
                            }),
                      ),
                      SizedBox(height: 15),
                      Row(children: <Widget>[
                        Expanded(
                            child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 151, 207, 235),
                        )),
                        Text("OR"),
                        Expanded(
                            child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 151, 207, 235),
                        )),
                      ]),
                      SizedBox(height: 15),
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width - 40,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff3E64FF),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Text(
                              "Instant Consultation",
                              style: TextStyle(fontSize: 15),
                            ),
                            onPressed: () async {
                              print(
                                  'object ${userName} ${userPhone} ${userEmail} ${userName} ${widget.ID}');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InstantBookingForm(
                                          name: userName,
                                          phone: userPhone,
                                          email: userEmail,
                                          patientId: widget.ID)));
                            }),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              }
            }));
  }

  card(String title, String img, String nooD) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.grey[200]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> medicalAreas() async {
  print("Inside Info");
  var client = http.Client();
  var doctor_Info = await client
      .get(Uri.parse('https://doctor2-kylo.herokuapp.com/medical_area/all'));
  print(doctor_Info.runtimeType);
  print(doctor_Info);
  print("Data Body of Medical Areas: ${doctor_Info.body}");
  return json.decode(doctor_Info.body);
}
