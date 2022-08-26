import 'dart:convert';

import 'package:patientapp/components/radioButtons.dart';
import 'package:patientapp/models/patientInfoModel.dart';
import 'package:patientapp/user/userDash.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Gender {
  String name;
  bool isSelected;

  Gender(this.name, this.isSelected);
}

late var userName = "";
late var userEmail = "";
late var userGender = "";
late var userDOB = "";
late var userCity = "";
late var userPincode = "";
late var userPhone = "";
late var userHeight = "";
late var userWeight = "";
late var userBloodGroup = "";

List<Gender> genders = <Gender>[];

class UserInfor extends StatefulWidget {
  String phone;
  UserInfor({Key? key, required this.phone}) : super(key: key);

  @override
  _UserInforState createState() => _UserInforState();
}

Future<String?> createUser(
    String name,
    String email,
    String gender,
    // String age,
    String phoneNumber,
    String weight,
    String height,
    String bloodGroup,
    String dob,
    String pincode,
    String city) async {
  String url = 'https://doctor2-kylo.herokuapp.com/patient/info/';
  print("Send Request");
  final response = await http.Client().post(Uri.parse(url), body: {
    "name": name,
    "email": email,
    "gender": gender,
    // "age":age,
    "dob": dob,
    "phone_number": phoneNumber,
    "city": city,
    "pincode": pincode,
    "height": height,
    "weight": weight,
    "blood_group": bloodGroup,
    // "is_verified":false,
  }
  );
  print("Response of request: ${response.body}");
  print("Status code of Response: ${response.statusCode}");

  if (response.statusCode == 200) {
    print("Response");
    final String responseBody = await response.body;
    print("::" + responseBody);
    print("Decoded String: ${json.decode(responseBody)}");
    var _user = json.decode(responseBody);
    print("NEw User : ${_user['data']}");
    print("NEw User Name : ${_user['data'][0]['name']}");
    userName = _user['data'][0]['name'];
    userEmail = _user['data'][0]['email'];
    userGender = _user['data'][0]['gender'];
    userDOB = _user['data'][0]['dob'];
    userCity = _user['data'][0]['city'];
    userPincode = _user['data'][0]['pincode'].toString();
    userPhone = _user['data'][0]['phone_number'].toString();
    userHeight = _user['data'][0]['height'].toString();
    userWeight = _user['data'][0]['weight'].toString();
    userBloodGroup = _user['data'][0]['blood_group'];
    var id=_user['data'][0]['_id'];
    print("ID is: $id");
    // userI=_user;
    // print("User phone: ${_user['data'][0]['phone_number']}");

    return id;
  } else {
    print("Failed to create user");

    return null;
  }
}

class _UserInforState extends State<UserInfor> {
  PatientModel? _user;
  TextEditingController dateinput = TextEditingController();
  //text editing controller for text field

  final _formkey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  var _gender = "";
  var _mob = "";
  final _mobile = TextEditingController();
  final _age = TextEditingController();
  final _wieght = TextEditingController();
  final _height = TextEditingController();
  final _bloodgroup = TextEditingController();
  final _city = TextEditingController();
  final _pincode = TextEditingController();
  final _dob = TextEditingController();

  bool _validateName = false;
  bool _validateEmail = false;
  bool _validateGender = false;
  bool _validateMobile = false;
  bool _validateAge = false;
  bool _validateWieght = false;
  bool _validateHeight = false;
  bool _validateBloodGroup = false;
  bool _validateDOB = false;
  bool _validatePinCode = false;
  bool _validateCity = false;

  final dateController = TextEditingController();

 

  @override
  void initState() {
    // TODO: implement initState
    genders.add(new Gender("Male", false));
    genders.add(new Gender("Female", false));
    genders.add(new Gender("Others", false));
    dateinput.text = "";
    super.initState();
  }

   @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  String bloodGroup = "A";
  final List<String> bloodGroups = <String>[
    "A",
    "B",
    "O",
    "AB",
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-",
  ];

  @override
  Widget build(BuildContext context) {
    _mob = widget.phone.substring(3);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "User Details",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Full Name ",
                        style: TextStyle(
                            fontFamily: "Museo Sans Cyrl 300 Regular",
                            color: Color(0xff6B779A),
                            fontSize: 14)),
                    TextSpan(
                        text: "*",
                        style: TextStyle(
                          color: Colors.red,
                        )),
                  ]),
                ),
               
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (_name.text.length < 1) {
                      return "Please Enter Your Name";
                    } else
                      return null;
                  },
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
                        Radius.circular(15.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF0099FF)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                //     Expanded(
                //       flex: 2,
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           RichText(
                //   text: TextSpan(children: <TextSpan>[
                //     TextSpan(
                //         text: "Age(yyyy)) ",
                //         style: TextStyle(
                //             fontFamily: "Museo Sans Cyrl 300 Regular",
                //             color: Color(0xff6B779A),
                //             fontSize: 14)),
                //     TextSpan(
                //         text: "*",
                //         style: TextStyle(
                //           color: Colors.red,
                //         )),
                //   ]),
                // ),
                        
                //           SizedBox(
                //             height: 5,
                //           ),
                //           // TextFormField(
                //           //   controller: _age,
                //           //   keyboardType: TextInputType.text,
                //           //   validator: (value) {
                //           //     if (_age.text.length < 1) {
                //           //       return "Please Enter Age";
                //           //     } else
                //           //       return null;
                //           //   },
                //           //   style: TextStyle(color: Colors.black, fontSize: 18),
                //           //   decoration: InputDecoration(
                //           //     hintText: 'Age must in years',
                //           //     hintStyle:
                //           //         TextStyle(color: Colors.grey, fontSize: 10),
                //           //     errorText: _validateAge
                //           //         ? "Please Enter \n Valid Age"
                //           //         : null,
                //           //     isDense: true,
                //           //     contentPadding: EdgeInsets.symmetric(
                //           //         vertical: 12, horizontal: 20),
                //           //     enabledBorder: OutlineInputBorder(
                //           //       borderSide:
                //           //           BorderSide(color: Colors.transparent),
                //           //       borderRadius: BorderRadius.all(
                //           //         Radius.circular(15.0),
                //           //       ),
                //           //     ),
                //           //     focusedBorder: OutlineInputBorder(
                //           //       borderSide:
                //           //           BorderSide(color: Color(0xFF0099FF)),
                //           //       borderRadius: BorderRadius.all(
                //           //         Radius.circular(15.0),
                //           //       ),
                //           //     ),
                //           //     filled: true,
                //           //     fillColor: Colors.grey[200],
                //           //   ),
                //           // ),
                //         ],
                //       ),
                //     ),
                Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Height(CM)",
                              style: TextStyle(
                                  fontFamily: "Museo Sans Cyrl 300 Regular",
                                  color: Color(0xff6B779A),
                                  fontSize: 13)),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: _height,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (_age.text.length < 1) {
                                return "Please Enter Height";
                              } else
                                return null;
                            },
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            decoration: InputDecoration(
                              hintText: 'hieght must in cm',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                              errorText: _validateHeight
                                  ? "Please Enter \n Valid Height"
                                  : null,
                              isDense: true,
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
                              fillColor: Colors.grey[200],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Weight(KG)",
                              style: TextStyle(
                                  fontFamily: "Museo Sans Cyrl 300 Regular",
                                  color: Color(0xff6B779A),
                                  fontSize: 13)),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: _wieght,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (_name.text.length < 1) {
                                return "Please Enter Your Weight";
                              } else
                                return null;
                            },
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            decoration: InputDecoration(
                              hintText: 'weight must in kg',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                              errorText: _validateWieght
                                  ? "Please Enter \n Valid Weight"
                                  : null,
                              isDense: true,
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
                              fillColor: Colors.grey[200],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
               
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    // Expanded(
                    //   flex: 2,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text("Height(CM)",
                    //           style: TextStyle(
                    //               fontFamily: "Museo Sans Cyrl 300 Regular",
                    //               color: Color(0xff6B779A),
                    //               fontSize: 13)),
                    //       SizedBox(
                    //         height: 5,
                    //       ),
                    //       TextFormField(
                    //         controller: _height,
                    //         keyboardType: TextInputType.text,
                    //         validator: (value) {
                    //           if (_age.text.length < 1) {
                    //             return "Please Enter Height";
                    //           } else
                    //             return null;
                    //         },
                    //         style: TextStyle(color: Colors.black, fontSize: 18),
                    //         decoration: InputDecoration(
                    //           hintText: 'hieght must in cm',
                    //           hintStyle:
                    //               TextStyle(color: Colors.grey, fontSize: 10),
                    //           errorText: _validateHeight
                    //               ? "Please Enter \n Valid Height"
                    //               : null,
                    //           isDense: true,
                    //           contentPadding: EdgeInsets.symmetric(
                    //               vertical: 12, horizontal: 20),
                    //           enabledBorder: OutlineInputBorder(
                    //             borderSide:
                    //                 BorderSide(color: Colors.transparent),
                    //             borderRadius: BorderRadius.all(
                    //               Radius.circular(15.0),
                    //             ),
                    //           ),
                    //           focusedBorder: OutlineInputBorder(
                    //             borderSide:
                    //                 BorderSide(color: Color(0xFF0099FF)),
                    //             borderRadius: BorderRadius.all(
                    //               Radius.circular(15.0),
                    //             ),
                    //           ),
                    //           filled: true,
                    //           fillColor: Colors.grey[200],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Date of Birth ",
                        style: TextStyle(
                            fontFamily: "Museo Sans Cyrl 300 Regular",
                            color: Color(0xff6B779A),
                            fontSize: 14)),
                    TextSpan(
                        text: "*",
                        style: TextStyle(
                          color: Colors.red,
                        )),
                  ]),
                ),
                          
                          SizedBox(
                            height: 5,
                          ),
                          

                          TextFormField(
                            readOnly: true,
                            controller: dateinput,
                            keyboardType: TextInputType.text,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      1970), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  dateinput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            validator: (value) {
                              if (dateinput.text.length < 1) {
                                return "Please Enter Date of Birth";
                              } else
                                return null;
                            },
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            decoration: InputDecoration(
                              errorText: _validateDOB
                                  ? "Please Enter \n Valid Date"
                                  : null,
                              isDense: true,
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
                              fillColor: Colors.grey[200],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Blood Group",
                              style: TextStyle(
                                  fontFamily: "Museo Sans Cyrl 300 Regular",
                                  color: Color(0xff6B779A),
                                  fontSize: 13)),
                          SizedBox(
                            height: 5,
                          ),

                          DropdownButtonFormField2(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
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
                              fillColor: Colors.grey[200],
                              //Add isDense true and zero Padding.
                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              isDense: true,
                              // contentPadding: EdgeInsets.zero,

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              //Add more decoration as you want here
                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'blood group',
                              style: TextStyle(fontSize: 14),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 30,
                            buttonHeight: 45,
                            buttonPadding:
                                const EdgeInsets.only(left: 20, right: 0),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            items: bloodGroups
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select gender.';
                              }
                            },
                            onChanged: (value) {
                              //Do something when changing the item if you want.
                              setState(() {
                                bloodGroup = value.toString();
                                print("Blood Group is: ${bloodGroup}");
                              });
                            },
                            onSaved: (value) {
                              bloodGroup = value.toString();
                              print("Blood Group is: ${bloodGroup}");
                            },
                          ),
                         
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("City",
                    style: TextStyle(
                        fontFamily: "Museo Sans Cyrl 300 Regular",
                        color: Color(0xff6B779A),
                        fontSize: 13)),
                          
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                  controller: _city,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (_name.text.length < 1) {
                      return "Please Enter Your City";
                    } else
                      return null;
                  },
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  decoration: InputDecoration(
                    errorText: _validateCity ? "Please Enter Valid City" : null,
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF0099FF)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                        ],
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pincode",
                              style: TextStyle(
                                  fontFamily: "Museo Sans Cyrl 300 Regular",
                                  color: Color(0xff6B779A),
                                  fontSize: 13)),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: _pincode,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (_name.text.length < 1) {
                                return "Please Enter Your Pincode";
                              } else
                                return null;
                            },
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            decoration: InputDecoration(
                              errorText: _validatePinCode
                                  ? "Please Enter\nValid Pincode"
                                  : null,
                              isDense: true,
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
                              fillColor: Colors.grey[200],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Expanded(child: Container(),flex: 1,),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                // Text("City",
                //     style: TextStyle(
                //         fontFamily: "Museo Sans Cyrl 300 Regular",
                //         color: Color(0xff6B779A),
                //         fontSize: 13)),
                // SizedBox(
                //   height: 5,
                // ),
                // TextFormField(
                //   controller: _city,
                //   keyboardType: TextInputType.text,
                //   validator: (value) {
                //     if (_name.text.length < 1) {
                //       return "Please Enter Your City";
                //     } else
                //       return null;
                //   },
                //   style: TextStyle(color: Colors.black, fontSize: 18),
                //   decoration: InputDecoration(
                //     errorText: _validateCity ? "Please Enter Valid City" : null,
                //     isDense: true,
                //     contentPadding:
                //         EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.transparent),
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(15.0),
                //       ),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Color(0xFF0099FF)),
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(15.0),
                //       ),
                //     ),
                //     filled: true,
                //     fillColor: Colors.grey[200],
                //   ),
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                Text("Gender",
                    style: TextStyle(
                        fontFamily: "Museo Sans Cyrl 300 Regular",
                        color: Color(0xff6B779A),
                        fontSize: 13)),
                Container(
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
                              genders.forEach(
                                  (gender) => gender.isSelected = false);
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
                // Text("Phone Number",
                //     style: TextStyle(
                //         fontFamily: "Museo Sans Cyrl 300 Regular",
                //         color: Color(0xff6B779A),
                //         fontSize: 13)),
                RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Phone Number ",
                        style: TextStyle(
                            fontFamily: "Museo Sans Cyrl 300 Regular",
                            color: Color(0xff6B779A),
                            fontSize: 14)),
                    TextSpan(
                        text: "*",
                        style: TextStyle(
                          color: Colors.red,
                        )),
                  ]),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  readOnly: true,
                  controller:  _mobile..text = widget.phone.substring(3),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_mobile.text.length != 10) {
                      return "Please Enter Phone No";
                    } else
                      return null;
                  },
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  decoration: InputDecoration(
                    // hintText: "${widget.phone.substring(3)}",

                    errorText:
                        _validateMobile ? "Please Enter Valid Mobile no" : null,
                    isDense: true,
                    prefixIcon: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                      child: Text(
                        "+91",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF0099FF)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Text("Email ID",
                //     style: TextStyle(
                //         fontFamily: "Museo Sans Cyrl 300 Regular",
                //         color: Color(0xff6B779A),
                //         fontSize: 13)),
                RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Email ID ",
                        style: TextStyle(
                            fontFamily: "Museo Sans Cyrl 300 Regular",
                            color: Color(0xff6B779A),
                            fontSize: 14)),
                    TextSpan(
                        text: "*",
                        style: TextStyle(
                          color: Colors.red,
                        )),
                  ]),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (_email.text.contains('@') ||
                        !_email.text.contains('.')) {
                      return "Please Enter Your Email ID";
                    } else
                      return null;
                  },
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  decoration: InputDecoration(
                    errorText:
                        _validateEmail ? "Please Enter Valid Email ID" : null,
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF0099FF)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                _user != null
                    ? Text(
                        _user!.name,
                        style: TextStyle(color: Colors.black),
                      )
                    : Container(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width - 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff3E64FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                      ),
                      child: const Text(
                        "Proceed To Consult",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () async {
                        // setState(() {
                        //    _user=user;
                        //    print("User phone number is: ${_user?.phoneNumber}");
                        // });
                        setState(() {
                          if (_name.text.length <= 1 || _name.text.isEmpty) {
                            _validateName = true;
                          } else {
                            _validateName = false;
                          }
                          // if (_age.text.isEmpty || int.parse(_age.text) < 1) {
                          //   _validateAge = true;
                          // } else {
                          //   _validateAge = false;
                          // }

                          // if (_wieght.text.isEmpty ||
                          //     int.parse(_wieght.text) < 1) {
                          //   _validateWieght = true;
                          // } else {
                          //   _validateWieght = false;
                          // }
                          // if (_height.text.isEmpty ||
                          //     int.parse(_height.text) < 1) {
                          //   _validateHeight = true;
                          // } else {
                          //   _validateHeight = false;
                          // }
                          // if (bloodGroup.isEmpty == true) {
                          //   _validateBloodGroup = true;
                          // } else {
                          //   _validateBloodGroup = false;
                          // }
                          // if (_pincode.text.isEmpty ||
                          //     _pincode.text.length < 4 ||
                          //     _pincode.text.length > 6) {
                          //   _validatePinCode = true;
                          // } else {
                          //   _validatePinCode = false;
                          // }
                          if (dateinput.text.isEmpty) {
                            _validateDOB = true;
                          } else {
                            _validateDOB = false;
                          }

                          // if (_city.text.isEmpty || _city.text.length <= 1) {
                          //   _validateCity = true;
                          // } else {
                          //   _validateCity = false;
                          // }

                          // !_gender.isEmpty
                          //     ? _validateGender = false
                          //     : _validateGender = true;
                          _mobile.text.length == 10
                              ? _validateMobile = false
                              : _validateMobile = true;
                          if (!_email.text.contains('@') ||
                              !_email.text.contains('.')) {
                            _validateEmail = true;
                          } else {
                            _validateEmail = false;
                          }
                        });

                        if (
                          _validateName ||
                            // _validateAge ||
                          //   _validateWieght ||
                          //   _validateGender ||
                            _validateMobile ||
                            _validateEmail ||
                            // _validateHeight ||
                            // _validateBloodGroup ||
                            _validateDOB
                            // _validatePinCode ||
                            // _validateCity
                            ) {
                          return null;
                        } else {
                          final String? id1= await createUser(
                              _name.text,
                              _email.text,
                              _gender,
                              // _age.text,
                              _mobile.text,
                              _wieght.text,
                              _height.text,
                              // _bloodgroup.text,
                              bloodGroup,
                              // _dob.text,
                              dateinput.text,
                              _pincode.text,
                              _city.text) ;
                              if(id1!=null)
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserDashboard(
                                              name: _name.text,
                                              phone: _mobile.text,
                                              // age: _age.text,
                                              gender: _gender,
                                              ID: id1,
                                              dob: dateinput.text,
                                            )));
                              }
                          
                        }

                      
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
