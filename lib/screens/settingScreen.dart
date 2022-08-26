import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:patientapp/screens/getPrescription.dart';
import 'package:patientapp/screens/myBookings.dart';
import 'package:patientapp/screens/updateProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;
import 'dart:convert' as convert;

import '../user/userAuth.dart';

class Setting extends StatefulWidget {
  final String? phone;
  final String? name;
  final String? age;
  final String? gender;
  final String? ID;
  String? profile_url;
  // String? dob;
  Setting({
    Key? key,
    this.phone,
    this.name,
    this.age,
    this.gender,
    this.ID,
    // this.dob,
    this.profile_url,
  }) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
  String? _uploadedFileURL;
  final _formkey = GlobalKey<FormState>();
  late FocusNode focusNode;
  late File _image;
  var index = 0;
  bool img = false;
  final picker = ImagePicker();

  getUserData() async {
    var url1 =
        "https://doctor2-kylo.herokuapp.com/patient/info/${widget.phone}";
    var userInfoResponse = await http.get(Uri.parse(url1));
    print("Status Code from User is: ${userInfoResponse.statusCode}");
    print("Data body of User Response is: ${userInfoResponse.body}");
    if (userInfoResponse.statusCode == 200) {
      final String responseBody = userInfoResponse.body;
      print('Decoded user info is: ${convert.json.decode(responseBody)}');
      var user = convert.json.decode(responseBody);
      // setState(() {
      //   userName = _user['data']['name'];
      //   userGender = _user['data']['gender'];
      //   // userAge = _user['data']['age'];
      //   userEmail = _user['data']['email'];
      //   userBloodGroup = _user['data']['blood_group'];
      //   userWeight = _user['data']['weight'].toString();
      //   userHeight = _user['data']['height'].toString();
      //   userDOB = _user['data']['dob'].toString().substring(0, 10);
      //   userPincode = _user['data']['pincode'].toString();
      //   userCity = _user['data']['city'];
      //   userPhone = _user['data']['phone_number'].toString();
      // });
      return user;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    // getUserData();
    print('image ${widget.profile_url} ${widget.age}');
    if (widget.profile_url != "no-image") {
      _uploadedFileURL = widget.profile_url;
    }
    if (widget.age != null) {
      userAge = widget.age!;
    } else {
      userAge = "0";
    }
    // controller = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var path;
    // print("Dob of user is :${widget.dob.toString().substring(0, 10)}");
    print("User ID in setting page is: ${widget.ID}");
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              // color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.black,
          ),
          title: Text(
            "Settings",
            style:
                GoogleFonts.museoModerno(fontSize: 18.0, color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: FutureBuilder(
            future: getUserData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.data != null){
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                            child: InkWell(
                                // onTap: getImage,
                                child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: _uploadedFileURL == null
                                        ? NetworkImage(
                                            "https://i.ibb.co/XVrzkbc/avatardefault-92824.png")
                                        : NetworkImage(
                                            "${_uploadedFileURL}")))),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "${snapshot.data['data']['name']}",
                                style: TextStyle(
                                    fontFamily: "Museo",
                                    color: Color(0xff6B779A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${snapshot.data['data']['gender'] == '' ? 'Male' : snapshot.data['data']['gender']} , ${userAge} years",
                                style: TextStyle(
                                    fontFamily: "Museo",
                                    color: Color(0xff6B779A),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Patient_Id is in settings: ${widget.ID}");
                            print(
                                "Updated user Name is: ${userName} ${userEmail} ${userWeight} ${userHeight}");
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => UpdateProfile(
                                        name: snapshot.data['data']['name'],
                                        phone: (snapshot.data['data']['phone_number']).toString(),
                                        email: snapshot.data['data']['email'],
                                        age: userAge,
                                        weight: (snapshot.data['data']['weight']).toString() == null ? '' : (snapshot.data['data']['weight']).toString(),
                                        height: (snapshot.data['data']['height']).toString() == null ? '' : (snapshot.data['data']['height']).toString(),
                                        bloodGroup: snapshot.data['data']['blood_group'],
                                        dob: (snapshot.data['data']['dob']).toString(),
                                        pincode: (snapshot.data['data']['pincode']).toString() == null ? '' : (snapshot.data['data']['pincode']).toString(),
                                        city: snapshot.data['data']['city'],
                                        gender: snapshot.data['data']['gender'] == null ? 'Male' : snapshot.data['data']['gender'],
                                        Id: (snapshot.data['data']['_id']).toString(),
                                        profile_url: _uploadedFileURL,
                                      )),
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: IgnorePointer(
                              child: TextFormField(
                                // autofocus: true,
                                readOnly: true,

                                // focusNode: focusNode,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                decoration: InputDecoration(
                                  hintText: "Update Profile",
                                  hintStyle: TextStyle(
                                      fontFamily: "Museo",
                                      color: Colors.grey.shade900,
                                      // fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                  isDense: true,
                                  suffixIcon:
                                      const Icon(Icons.arrow_right_rounded),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF0099FF)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('ew ${snapshot.data['data']['_id']}');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyBookings(
                                          Id: snapshot.data['data']['_id'],
                                        )));
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: IgnorePointer(
                              child: TextFormField(
                                // autofocus: true,
                                readOnly: true,

                                // focusNode: focusNode,
                                // keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                decoration: InputDecoration(
                                  hintText: "My Bookings",
                                  hintStyle: TextStyle(
                                      fontFamily: "Museo",
                                      color: Colors.grey.shade900,
                                      // fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                  isDense: true,
                                  suffixIcon:
                                      const Icon(Icons.arrow_right_rounded),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF0099FF)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GetDoctorPrescription(
                                          patinetID: snapshot.data['data']['_id'],
                                        )));
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: IgnorePointer(
                              child: TextFormField(
                                // autofocus: true,
                                readOnly: true,

                                // focusNode: focusNode,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                decoration: InputDecoration(
                                  hintText: "Download Prescription",
                                  hintStyle: TextStyle(
                                      fontFamily: "Museo",
                                      color: Colors.grey.shade900,
                                      // fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                  isDense: true,
                                  suffixIcon:
                                      const Icon(Icons.arrow_right_rounded),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF0099FF)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              print("Something");
                              index++;
                              print("Index : $index");
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: IgnorePointer(
                              child: TextFormField(
                                // autofocus: true,
                                readOnly: true,

                                // focusNode: focusNode,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                decoration: InputDecoration(
                                  hintText: "About",
                                  hintStyle: TextStyle(
                                      fontFamily: "Museo",
                                      color: Colors.grey.shade900,
                                      // fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                  isDense: true,
                                  suffixIcon:
                                      const Icon(Icons.arrow_right_rounded),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF0099FF)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              print("Something");
                              index++;
                              print("Index : $index");
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: IgnorePointer(
                              child: TextFormField(
                                // autofocus: true,
                                readOnly: true,

                                // focusNode: focusNode,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                decoration: InputDecoration(
                                  hintText: "Privacy Policy",
                                  hintStyle: TextStyle(
                                      fontFamily: "Museo",
                                      color: Colors.grey.shade900,
                                      // fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                  isDense: true,
                                  suffixIcon:
                                      const Icon(Icons.arrow_right_rounded),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF0099FF)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              print("Something");
                              index++;
                              print("Index : $index");
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: IgnorePointer(
                              child: TextFormField(
                                // autofocus: true,
                                readOnly: true,

                                // focusNode: focusNode,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                decoration: InputDecoration(
                                  hintText: "FAQ",
                                  hintStyle: TextStyle(
                                      fontFamily: "Museo",
                                      color: Colors.grey.shade900,
                                      // fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                  isDense: true,
                                  suffixIcon:
                                      const Icon(Icons.arrow_right_rounded),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF0099FF)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut().then((value) => {
                                print('Logout'),
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()))
                                
                              });
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: IgnorePointer(
                              child: TextFormField(
                                // autofocus: true,
                                readOnly: true,

                                // focusNode: focusNode,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                decoration: InputDecoration(
                                  hintText: "Sign Out",
                                  hintStyle: TextStyle(
                                      fontFamily: "Museo",
                                      color: Colors.grey.shade900,
                                      // fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                  isDense: true,
                                  suffixIcon:
                                      const Icon(Icons.arrow_right_rounded),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF0099FF)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
             }
             else if(snapshot.hasError){
               return Container(child: Text('cdsa'),);
             }
             else{
               return Center(child: CircularProgressIndicator(),);
             } }));
  }
}
