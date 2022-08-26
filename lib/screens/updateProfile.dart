import 'dart:convert' as convert;
import 'dart:io';

import 'package:patientapp/Colors/color.dart';
import 'package:patientapp/components/radioButtons.dart';
import 'package:patientapp/models/patientInfoModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:patientapp/screens/settingScreen.dart';
import 'package:patientapp/user/userInfo.dart';
import 'package:patientapp/models/patientInfoModel.dart' as userInfo;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

late userInfo.PatientModel userinfo;

class UpdateProfile extends StatefulWidget {
  // String phone;
  String name;
  String phone;
  String email;
  String age;
  String weight;
  String height;
  String bloodGroup;
  String dob;
  String pincode;
  String city;
  String gender;
  final String? Id;
  String? profile_url;
  UpdateProfile({
    Key? key,
    required this.name,
    required this.phone,
    required this.email,
    required this.age,
    required this.weight,
    required this.height,
    required this.bloodGroup,
    required this.dob,
    required this.pincode,
    required this.city,
    required this.gender,
    required this.Id,
    required this.profile_url,
  }) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

Future updateUser(
  context,
  String name,
  String email,
  String gender,
  String age,
  String phoneNumber,
  String weight,
  String height,
  String bloodGroup,
  String dob,
  String pincode,
  String city,
  final String? patientId,
  // String profile_url,
) async {
  String url = 'https://doctor2-kylo.herokuapp.com/patient/info/';
  print("Send Request");
  var body1 = {
    "name": name,
    "email": email,
    "gender": gender,
    "age": age,
    // "dob": dob,
    "phone_number": phoneNumber,
    "city": city,
    "pincode": pincode,
    "height": height,
    "weight": weight,
    "blood_group": bloodGroup,
    "patient_id": patientId,
    // 'profile_url': profile_url,
    // "is_verified":false,
  };
  final response = await http.Client().put(Uri.parse(url), body: body1);
  print("Response of request: ${response.body}");
  print("Status code of Response: ${response.statusCode}");

  if (response.statusCode == 200) {
    final String responseBody = await response.body;
    print("::" + responseBody);
    var user = convert.json.decode(responseBody);
    print("NEw User : ${user}");
    print("NEw User Name : ${user['updated_data']['name']}");
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Setting(
              phone: (user['updated_data']['phone_number']).toString(),
              age: age.toString(),
            )));

    return userName;
  } else {
    print("Failed to create user");

    return null;
  }
}

class _UpdateProfileState extends State<UpdateProfile> {
  PatientModel? _user;
  TextEditingController dateinput = TextEditingController();
  //text editing controller for text field

  final _formkey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  var _gender = "";
  // var _mob = "";
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

  String? changedName;
  String? changedAge;
  String? changedWeight;
  String? changedHeight;
  String? changedGender;
  String? changedPhone;
  String? changedEmail;
  String? changedPincode;
  String? changedDOB;
  String? changedCity;
  String? changedBlood;
  String? changedDob;

  final dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // getdata();
    // TODO: implement initState
    genders.add(new Gender("Male", false));
    genders.add(new Gender("Female", false));
    genders.add(new Gender("Others", false));
    print('info ${widget.age} ${widget.weight} ${widget.bloodGroup}');
    changedName = widget.name;
    changedAge = widget.age;
    changedWeight = widget.weight;
    changedHeight = widget.height;
    changedBlood = widget.bloodGroup;
    changedDOB = widget.dob;
    changedPincode = widget.pincode;
    changedCity = widget.city;
    changedGender = widget.gender;
    changedPhone = widget.phone;
    changedEmail = widget.email;
    changedDOB = widget.dob;
    _uploadedFileURL = widget.profile_url;
    // getdata();
    dateinput.text = "";
    // var ind=0;
    print("Patient ID in Update profile1234 is: ${widget.Id}");
    genders[0].isSelected = false;
    genders[1].isSelected = false;
    genders[2].isSelected = false;
    if (_gender == "Male") {
      genders[0].isSelected = true;
    } else if (_gender == "Female") {
      genders[1].isSelected = true;
    } else if (_gender == "Other") {
      genders[2].isSelected = true;
    }
    super.initState();
    // getdata();
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
    "AB-"
  ];

  late File _image;
  bool img = false;
  final picker = ImagePicker();
  String? _uploadedFileURL;
  Future getImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    //getImage(source: ImageSource.gallery);
    setState(() async {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        img = true;
        var snapshot = await _firebaseStorage
            .ref()
            .child('Doctor2/${Path.basename(pickedFile.path)}')
            .putFile(_image);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          _uploadedFileURL = downloadUrl;
          print("Url of image: $_uploadedFileURL");
        });
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // _mob=widget.phone.substring(3);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            // color: col2,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: black,
        ),
        title: Text(
          "Update Profile",
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
                img == false
                    ? Center(
                        child: InkWell(
                            onTap: getImage,
                            child: CircleAvatar(
                                radius: 50,
                                // ignore: unnecessary_null_comparison
                                backgroundImage: _uploadedFileURL == null
                                    ? NetworkImage(
                                        "https://i.ibb.co/XVrzkbc/avatardefault-92824.png")
                                    : NetworkImage("${_uploadedFileURL}"))))
                    : Center(
                        child: InkWell(
                            onTap: getImage,
                            child: CircleAvatar(
                              radius: 50,
                              child: Image.file(
                                File(_image.path),
                                fit: BoxFit.cover,
                              ),
                              backgroundColor: Colors.white,
                            ))),
                SizedBox(
                  height: 5,
                ),
                Center(
                    child: Text("Upload Image",
                        style: TextStyle(
                            fontFamily: "Museo Sans Cyrl 300 Regular",
                            color: Color(0xff6B779A),
                            fontSize: 13))),
                SizedBox(
                  height: 15,
                ),
                Text("Full Name",
                    style: TextStyle(
                        fontFamily: "Museo Sans Cyrl 300 Regular",
                        color: Color(0xff6B779A),
                        fontSize: 13)),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  onChanged: (value) {
                    this.changedName = value;
                  },
                  initialValue: changedName,
                  // controller: _name..text=widget.name,
                  // initialValue: userName,
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
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Age(yyyy)",
                              style: TextStyle(
                                  fontFamily: "Museo Sans Cyrl 300 Regular",
                                  color: Color(0xff6B779A),
                                  fontSize: 13)),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            readOnly: true,
                            onChanged: (value) {
                              this.changedAge = value;
                            },
                            initialValue: changedAge,
                            // controller: _age..text=widget.age,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (_age.text.length < 1) {
                                return "Please Enter Age";
                              } else
                                return null;
                            },
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            decoration: InputDecoration(
                              hintText: 'Age must in years',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                              errorText: _validateAge
                                  ? "Please Enter \n Valid Age"
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
                            onChanged: (value) {
                              this.changedWeight = value;
                            },
                            initialValue: changedWeight,
                            // controller: _wieght..text=widget.weight,
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
                            onChanged: (value) {
                              this.changedHeight = value;
                            },
                            initialValue: changedHeight,
                            // controller: _height..text=widget.height,
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
                            hint: Text(
                              '${changedBlood}',
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
                          Text("Date of Birth",
                              style: TextStyle(
                                  fontFamily: "Museo Sans Cyrl 300 Regular",
                                  color: Color(0xff6B779A),
                                  fontSize: 13)),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            readOnly: true,
                            // controller: dateinput..text=widget.dob,
                            onChanged: (value) {
                              this.changedDOB = value;
                            },
                            initialValue: changedDOB,
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
                                print(formattedDate);

                                setState(() {
                                  changedDOB =
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
                          Text("Pincode",
                              style: TextStyle(
                                  fontFamily: "Museo Sans Cyrl 300 Regular",
                                  color: Color(0xff6B779A),
                                  fontSize: 13)),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              this.changedPhone = value;
                            },
                            initialValue: changedPincode,
                            // controller: _pincode..text=widget.pincode,
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
                Text("City",
                    style: TextStyle(
                        fontFamily: "Museo Sans Cyrl 300 Regular",
                        color: Color(0xff6B779A),
                        fontSize: 13)),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  // controller: _city..text=widget.city,
                  onChanged: (value) {
                    this.changedCity = value;
                  },
                  initialValue: changedCity,
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
                SizedBox(
                  height: 5,
                ),
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
                Text("Phone Number",
                    style: TextStyle(
                        fontFamily: "Museo Sans Cyrl 300 Regular",
                        color: Color(0xff6B779A),
                        fontSize: 13)),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  readOnly: true,
                  controller: _mobile..text = widget.phone,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_mobile.text.length != 10) {
                      return "Please Enter Phone No";
                    } else
                      return null;
                  },
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  decoration: InputDecoration(
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
                Text("Email ID",
                    style: TextStyle(
                        fontFamily: "Museo Sans Cyrl 300 Regular",
                        color: Color(0xff6B779A),
                        fontSize: 13)),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  onChanged: (value) {
                    this.changedEmail = value;
                  },
                  initialValue: changedEmail,
                  // controller: _email..text=widget.email,
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
                  height: MediaQuery.of(context).size.height / 9,
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
                        "Update Profile",
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () async {
                        // setState(() {
                        //    _user=user;
                        //    print("User phone number is: ${_user?.phoneNumber}");
                        // });
                        setState(() {
                          if (changedName!.length <= 1 ||
                              changedName!.isEmpty) {
                            _validateName = true;
                          } else {
                            _validateName = false;
                          }
                          if (changedAge!.isEmpty ||
                              int.parse(changedAge!) < 1) {
                            _validateAge = true;
                          } else {
                            _validateAge = false;
                          }

                          if (changedWeight!.isEmpty ||
                              int.parse(changedWeight!) < 1) {
                            _validateWieght = true;
                          } else {
                            _validateWieght = false;
                          }
                          if (changedHeight!.isEmpty ||
                              int.parse(changedHeight!) < 1) {
                            _validateHeight = true;
                          } else {
                            _validateHeight = false;
                          }
                          if (bloodGroup.isEmpty == true) {
                            _validateBloodGroup = true;
                          } else {
                            _validateBloodGroup = false;
                          }
                          if (changedPincode!.isEmpty ||
                              changedPincode!.length < 4 ||
                              changedPincode!.length > 6) {
                            _validatePinCode = true;
                          } else {
                            _validatePinCode = false;
                          }
                          if (changedDOB!.isEmpty) {
                            _validateDOB = true;
                          } else {
                            _validateDOB = false;
                          }

                          if (changedCity!.isEmpty ||
                              changedCity!.length <= 1) {
                            _validateCity = true;
                          } else {
                            _validateCity = false;
                          }

                          !_gender.isEmpty
                              ? _validateGender = false
                              : _validateGender = true;
                          _mobile.text.length == 10
                              ? _validateMobile = false
                              : _validateMobile = true;
                          if (!changedEmail!.contains('@') ||
                              !changedEmail!.contains('.')) {
                            _validateEmail = true;
                          } else {
                            _validateEmail = false;
                          }
                        });

                        if (_validateName ||
                            _validateAge ||
                            _validateWieght ||
                            _validateGender ||
                            _validateMobile ||
                            _validateEmail ||
                            _validateHeight ||
                            _validateBloodGroup ||
                            _validateDOB ||
                            _validatePinCode ||
                            _validateCity) {
                          return null;
                        } else {
                          _uploadedFileURL == null
                              ? NetworkImage(
                                  "https://i.ibb.co/XVrzkbc/avatardefault-92824.png")
                              : _uploadedFileURL;
                          print(
                              "Patient Id in Upd is: ${widget.Id} ${_uploadedFileURL}");
                          updateUser(
                            context,
                            changedName!,
                            changedEmail!,
                            _gender,
                            changedAge!,
                            _mobile.text,
                            changedWeight!,
                            changedHeight!,

                            bloodGroup,

                            changedDOB!,
                            changedPincode!,
                            changedCity!,
                            widget.Id!,
                            // _uploadedFileURL!,
                          );
                        }

                        // Get.to(UserDashboard());
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
