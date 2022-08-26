import 'package:patientapp/components/radioButtons.dart';
import 'package:patientapp/doctor/confirmAppointment.dart';
import 'package:patientapp/doctor/selectAppointmentSchedule.dart';
import 'package:patientapp/doctor/selectSchedule.dart';
import 'package:patientapp/user/userInfo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class bookAppointment extends StatefulWidget {
  final String drid;
  final String name;
  final String? phone;
  final String? userID;
  final String fee;
  final String drEmail;
  final String? isInstant;
  List? instantList = [];
  bookAppointment({
    Key? key,
    required this.drid,
    required this.name,
    required this.phone,
    required this.userID,
    required this.fee,
    required this.drEmail,
    required this.isInstant,
    required this.instantList,
  }) : super(key: key);

  @override
  _bookAppointmentState createState() => _bookAppointmentState();
}

class _bookAppointmentState extends State<bookAppointment> {
  bool _validateMobile = false;
  var _gender = "";
  bool _validateGender = false;
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  final _mobile = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _msg = TextEditingController();
  DateTime _dateTime = DateTime.now();

  bool _validateName = false;
  bool _validateEmail = false;
  bool _validateAge = false;
  bool _validateWieght = false;
  bool _validateHeight = false;
  bool _validateBloodGroup = false;
  bool _validateDOB = false;
  bool _validatePinCode = false;
  bool _validateCity = false;

  String email = '';
  int phone = 1234567890;

  Future<String?> getUserID() async {
    print("Phone is ${widget.phone}");
    print("Inside Info");
    var client = http.Client();
    var user_Info = await client.get(Uri.parse(
        'https://doctor2-kylo.herokuapp.com/patient/info/${widget.phone}'));
    if (user_Info.statusCode == 200) {
      final String responseBody = user_Info.body;
      // print('Decoded user info is: ${json.decode(responseBody)}');
      var _user = json.decode(responseBody);
      String ID2 = _user['data']['_id'];
      setState(() {
        email = _user['data']['email'];
        phone = _user['data']['phone_number'];
        print('email $email');
      });
      print("ID final1234: $ID2");
      print("User Info is123456: ${_user}");
      return ID2;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    genders.add(new Gender("Male", false));
    genders.add(new Gender("Female", false));
    genders.add(new Gender("Others", false));
    // dateinput.text = "";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Book Appointment",
          style: GoogleFonts.museoModerno(fontSize: 16.0, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Patient Details",
                style: TextStyle(
                    fontFamily: "Museo",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Full Name",
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _name,
                keyboardType: TextInputType.text,
                // validator: (value){if (_search.text.length<10) {return "Please Enter Phone No";}
                //else return null;},
                style: TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                  errorText: _validateName
                      ? "Name must have length greater than 1"
                      : null,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  hintText: "Name of Patient",
                  hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF0099FF)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Age", style: TextStyle(color: Colors.grey, fontSize: 14)),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _age,
                keyboardType: TextInputType.number,
                // validator: (value){if (_search.text.length<10) {return "Please Enter Phone No";}
                //else return null;},
                style: TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                  errorText: _validateAge
                      ? "Age must be greater than 0 and number"
                      : null,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  hintText: "Age",
                  hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF0099FF)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text("Gender",
                  style: TextStyle(
                      fontFamily: "Museo Sans Cyrl 300 Regular",
                      color: Color(0xff6B779A),
                      fontSize: 13)),
              Container(
                // color: Colors.black,
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: genders.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        splashColor: Colors.pinkAccent,
                        onTap: () {
                          setState(() {
                            genders
                                .forEach((gender) => gender.isSelected = false);
                            genders[index].isSelected = true;
                            if (index == 0) {
                              _gender = "Male";
                            } else if (index == 1) {
                              _gender = "Female";
                            } else if (index == 2) {
                              _gender = "Other";
                            }
                            print("Gender is: ${_gender}");
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CustomRadio(genders[index]),
                        ),
                      );
                    }),
              ),
              Text(
                (() {
                  if (_validateGender) {
                    return "Please select gender";
                  }

                  return "";
                })(),
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 5,
              ),
            
              Text("Write Your Problem",
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _msg,
                maxLines: 5,
                keyboardType: TextInputType.text,
                // validator: (value){if (_search.text.length<10) {return "Please Enter Phone No";}
                //else return null;},
                style: TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  hintText: "Write your Problem",
                  hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF0099FF)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      "Proceed To Schedule",
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () async {
                      final String? userID1 = await getUserID();
                      print("User id is123456: ${userID1}");
                      print("New fee :${widget.fee}");
                      print("Message: ${_msg.text}");
                      setState(() {
                        if (_name.text.length <= 1 || _name.text.isEmpty) {
                          _validateName = true;
                        } else {
                          _validateName = false;
                        }
                        if (_age.text.isEmpty || int.parse(_age.text) < 1) {
                          _validateAge = true;
                        } else {
                          _validateAge = false;
                        }
                        _gender.isNotEmpty
                            ? _validateGender = false
                            : _validateGender = true;
                        // _mobile.text.length == 10
                        //     ? _validateMobile = false
                        //     : _validateMobile = true;
                        // if (!_email.text.contains('@') ||
                        //     !_email.text.contains('.')) {
                        //   _validateEmail = true;
                        // } else {
                        //   _validateEmail = false;
                        // }
                      });
                      if (_validateName ||
                          _validateAge ||
                          _validateGender 
                          // _validateMobile ||
                          // _validateEmail
                          ) {
                        return null;
                      } else {
                        String? order_id;
                        http.Response response = await http.get(Uri.parse(
                            "http://doctor2-kylo.herokuapp.com/consult/payment?amount=${widget.fee}"));
                        if (response.statusCode == 200) {
                          print("Response Body is: ${response.body}");
                          var orderCreated = json.decode(response.body);
                          order_id = orderCreated['data']['id'];
                          print("Order is is: $order_id");
                        }
                        Map<String, dynamic> vaiables = {};
                        vaiables.putIfAbsent("order_id", () => order_id!);
                        vaiables.putIfAbsent(
                            "isInstantList", () => widget.instantList);
                        vaiables.putIfAbsent(
                            "isInstant", () => widget.isInstant);

                        DateTime selectedDate = DateTime.now();
                        String day = DateFormat('EEEE').format(selectedDate);
                        String time = selectedDate.toString().substring(11, 16);
                        print('email $email');
                        if (widget.isInstant == "no") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SelectAppointmentSchedule(
                                        drid: widget.drid,
                                        name: _name.text,
                                        email: email,
                                        phoneNumber: phone.toString(),
                                        drName: widget.name,
                                        ID: userID1.toString(),
                                        fee: widget.fee,
                                        drEmail: widget.drEmail,
                                        description: _msg.text,
                                        isInstant: "no",
                                        instantList: widget.instantList,
                                        order_id: order_id!,
                                        // vaiables: vaiables,
                                      )));
                        } 
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
