import 'dart:math';
import 'package:patientapp/doctor/bookAppointment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class doctorInfo extends StatefulWidget {
  final String? name;
  // final String patientName;
  String? experience;
  double? rating;
  String? imgURL;
  String? drid;
  String? phoe;
  String? userID;
  String? fee;
  String? drEmail;
  String? bio;
  String? drPhone;
  String? hospitalName;
  List? isInstnt=[];
  // List? speciality;
  // String? medicalAreas;
  List? medicalAreas = [];
  var medic;
  Map<String, dynamic>? wHrs;
  doctorInfo([
    this.name,
    this.experience,
    this.rating,
    this.imgURL,
    this.medic,
    this.wHrs,
    this.drid,
    this.phoe,
    this.userID,
    this.fee,
    this.drEmail,
    this.bio,
    this.drPhone,
    this.hospitalName,
    this.isInstnt,
    // required this.patientName,
  ]);

  @override
  _doctorInfoState createState() => _doctorInfoState();
}

class _doctorInfoState extends State<doctorInfo> {

  Future<void> giveRating(double ratingValue) async {
    print("dr id 123: ${widget.drid}");
    print("Rating value is: ${ratingValue}");
    String url = 'https://doctor2-kylo.herokuapp.com/doctor/rating';
    var body = {
      'doctor_id': widget.drid,
      'rating': ratingValue.toString(),
    };
    print("Rating body is: ${body}");
    final response1 = await http.post(
      Uri.parse(url),
      body: body,
      // headers: {"Content-Type": "application/json"}
    );

    print("response body after rating123: ${response1.body}");
    var res = json.decode(response1.body);
    if (response1.statusCode == 200) {
      print("Rating Updated Successfully");
      Fluttertoast.showToast(
          // backgroundColor: Colors.white,
          // textColor: Colors.black,
          msg: "Rating Submitted Successfully", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.CENTER, // location
          timeInSecForIosWeb: 1 // duration
          );
      Navigator.of(context).pop();
      return;
    } else {
      return null;
    }
  }

  bool isCall = false;
  Future<bool> getConsultation() async {
    var client = http.Client();
    bool call = false;
    // String url = "https://doctor2-kylo.herokuapp.com/doctor/info/all";
    print("Patient ID is: ${widget.userID}");
    var consultInfo = await client.get(Uri.parse(
        'https://doctor2-kylo.herokuapp.com/consult/by_patient/${widget.userID}'));
    print("Response of consultation1234: ${consultInfo.body}");
    if (consultInfo.statusCode == 200) {
      print("Inside consultation..!!");
      var consult = json.decode(consultInfo.body);
      if(consult['data'].length>0)
      {
      print("Consult body in doctor info is: ${consult}");
      for (var i = 0; i < consult['data'].length!; i++) {
       
        
        if ( consult['data'][i]['doctor_id']!=null && consult['data'][i]['doctor_id']['_id'] == widget.drid) {
          if (consult['data'][i]['cancellation']['is_cancelled'] == false) {
            isCall = true;
            
           
           
            
            return call;
          }
        }
      }
      }

      print("Body of consult123: ${consult}");
    }
    return call;
  }

  void initState() {
    
     getConsultation();
    //  print('object ${widget.medicalAreas}');
     super.initState();
    // print("Temp is :${temp}");
    
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      isCall;
    });
    print("${widget.name}");
    print("${widget.experience}");
    print("${widget.imgURL}");
    // print("${widget.medicalAreas}");
    print("${widget.rating}");
    bool biio = false;
    bool _yoe = false;
    if (widget.experience != null) {
      _yoe = true;
    }
    if (widget.bio != null) {
      biio = true;
    }

    bool avlMon = true;
    bool avlTue = true;
    bool avlWen = true;
    bool avlThu = true;
    bool avlFri = true;
    bool avlSat = true;
    bool avlSun = true;
    bool allDay = true;

    if (widget.wHrs!.containsKey("Mon")) {
      avlMon = false;
      if (widget.wHrs!["Mon"]["start_time"].isEmpty == true) {
        avlMon = true;
      }
    }
    if (widget.wHrs!.containsKey("Tue")) {
      avlTue = false;
      if (widget.wHrs!["Tue"]["start_time"].isEmpty == true) {
        avlTue = true;
      }
    }
    if (widget.wHrs!.containsKey("Wed")) {
      avlWen = false;
      if (widget.wHrs!["Wed"]["start_time"].isEmpty == true) {
        avlWen = true;
      }
    }
    if (widget.wHrs!.containsKey("Thu")) {
      avlThu = false;
      if (widget.wHrs!["Thu"]["start_time"].isEmpty == true) {
        avlThu = true;
      }
    }
    if (widget.wHrs!.containsKey("Fri")) {
      avlFri = true;
      if (widget.wHrs!["Fri"]["start_time"].isEmpty == true) {
        avlFri = true;
      }
    }
    // if (widget.wHrs!.containsKey("Sat")) {
    //   avlSat = false;
    //   if (widget.wHrs!["Sat"]["start_time"].isEmpty == true) {
    //     avlSat = true;
    //   }
    // }
    if (widget.wHrs!.containsKey("Sat")) {
      avlSat = false;
      if (widget.wHrs!["Sat"]["start_time"].isEmpty == true) {
        avlSat = true;
      }
    }
    if (widget.wHrs!.containsKey("Sun")) {
      avlSun = false;
      if (widget.wHrs!["Sun"]["start_time"].isEmpty == true) {
        avlSun = true;
      }
    }

    double ratingValue = widget.rating! / 20;
    double roundDouble(double value, int places) {
      num mod = pow(10.0, places);
      return ((value * mod).round().toDouble() / mod);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      
      ),
      body: RefreshIndicator(
        onRefresh: getConsultation,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: widget.imgURL==null? NetworkImage("https://i.ibb.co/XVrzkbc/avatardefault-92824.png"): NetworkImage("${widget.imgURL}"),
                radius: 55,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${widget.name}",
                style: TextStyle(
                    fontFamily: "Museo",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text("Speciality: ${widget.medic}",
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[50]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Material(
                          elevation: 2,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 15),
                                  child: Image.asset(
                                    "assets/img_11.png",
                                    width: 50,
                                  ),
                                ),
                                //SizedBox(height: 5,),
                                Text(
                                  "1000+",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Patients",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Colors.black,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Material(
                          elevation: 2,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 15),
                                  child: Image.asset(
                                    "assets/img_12.png",
                                    width: 50,
                                  ),
                                ),
      
                                Text(
                                  (() {
                                    if (widget.experience != null.toString()) {
                                      print(
                                          "Exp of Doc is: ${widget.experience}");
                                      return "${widget.experience} Yrs";
                                    } else
                                      return "0 Yrs";
                                  })(),
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                // Text("${widget.experience} Yrs",
      
                                // style: TextStyle(fontFamily: "Museo",color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
      
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Experience",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Colors.black,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Material(
                          elevation: 2,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 15),
                                  child: Image.asset(
                                    "assets/img_13.png",
                                    width: 50,
                                  ),
                                ),
                                Text(
                                  "${roundDouble(widget.rating!, 2)}",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Ratings",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Colors.black,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 15, top: 30, bottom: 10),
                child: Container(
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About Doctor",
                          style: TextStyle(
                              fontFamily: "Museo",
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          (() {
                            if (biio) {
                              return "${widget.bio}";
                            }
      
                            return "Empty";
                          })(),
                          style: TextStyle(
                              fontFamily: "Museo",
                              color: Color(0xff6B779A),
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        // Text(
                        //     "${widget.bio}",
                        //     style: TextStyle(
                        //         fontFamily: "Museo",
                        //         color: Color(0xff6B779A),
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 12)),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Hospital Detail",
                          style: TextStyle(
                              fontFamily: "Museo",
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(height: 10,),
                        Text('${widget.hospitalName}',
                          style: TextStyle(
                              fontFamily: "Museo",
                              color: Color(0xff6B779A),
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Working Time",
                          style: TextStyle(
                              fontFamily: "Museo",
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Monday",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Color(0xff6B779A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                  softWrap: true,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Tuesday",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Color(0xff6B779A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                  softWrap: true,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Wednesday",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Color(0xff6B779A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                  softWrap: true,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Thursday",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Color(0xff6B779A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                  softWrap: true,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Friday",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Color(0xff6B779A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                  softWrap: true,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Saturday",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Color(0xff6B779A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                  softWrap: true,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Sunday",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Color(0xff6B779A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                  softWrap: true,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            VerticalDivider(),
                            Column(
                              children: <Widget>[
                                Text(
                                  "-",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Color(0xff6B779A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "-",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Color(0xff6B779A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "-",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Color(0xff6B779A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                // SizedBox(height: ,),
                                Text(
                                  "-",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Color(0xff6B779A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "-",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Color(0xff6B779A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "-",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Color(0xff6B779A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "-",
                                  style: TextStyle(
                                      fontFamily: "Museo",
                                      color: Color(0xff6B779A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                            VerticalDivider(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text((() {
                                  if (avlMon) {
                                    return "Not Available";
                                  }
      
                                  return "${widget.wHrs!["Mon"]["start_time"]} : ${widget.wHrs!["Mon"]["end_time"]} ";
                                })(),
                                    style: TextStyle(
                                        fontFamily: "Museo",
                                        color: Color(0xff6B779A),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text((() {
                                  if (avlTue) {
                                    return "Not Available";
                                  }
      
                                  return "${widget.wHrs!["Tue"]["start_time"]} : ${widget.wHrs!["Tue"]["end_time"]} ";
                                })(),
                                    style: TextStyle(
                                        fontFamily: "Museo",
                                        color: Color(0xff6B779A),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text((() {
                                  if (avlWen) {
                                    return "Not Available";
                                  }
      
                                  return "${widget.wHrs!["Wed"]["start_time"]} : ${widget.wHrs!["Wed"]["end_time"]} ";
                                })(),
                                    style: TextStyle(
                                        fontFamily: "Museo",
                                        color: Color(0xff6B779A),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text((() {
                                  if (avlThu) {
                                    return "Not Available";
                                  }
      
                                  return "${widget.wHrs!["Thu"]["start_time"]} : ${widget.wHrs!["Thu"]["end_time"]} ";
                                })(),
                                    style: TextStyle(
                                        fontFamily: "Museo",
                                        color: Color(0xff6B779A),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text((() {
                                  if (avlFri) {
                                    return "Not Available";
                                  }
      
                                  return "${widget.wHrs!["Fri"]["start_time"]} : ${widget.wHrs!["Fri"]["end_time"]} ";
                                })(),
                                    style: TextStyle(
                                        fontFamily: "Museo",
                                        color: Color(0xff6B779A),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text((() {
                                  if (avlSat) {
                                    return "Not Available";
                                  }
      
                                  return "${widget.wHrs!["Sat"]["start_time"]} : ${widget.wHrs!["Sat"]["end_time"]} ";
                                })(),
                                    style: TextStyle(
                                        fontFamily: "Museo",
                                        color: Color(0xff6B779A),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text((() {
                                  if (avlSun) {
                                    return "Not Available";
                                  }
      
                                  return "${widget.wHrs!["Sun"]["start_time"]} : ${widget.wHrs!["Sun"]["end_time"]} ";
                                })(),
                                    style: TextStyle(
                                        fontFamily: "Museo",
                                        color: Color(0xff6B779A),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            )
                          ],
                        ),
                        
      
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Communication",
                          style: TextStyle(
                              fontFamily: "Museo",
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    onPrimary: isCall == true
                                        ? Colors.blue
                                        : Colors.grey,
                                    primary: Colors.transparent,
                                    elevation: 0),
                                onPressed: () {
                                  // if (isCall) {
                                    print("DrNumber is: ${widget.drPhone}");
                                    launch("tel://${widget.drPhone!.toString()}");
                                  // }
                                },
                                icon: Icon(Icons.call,
                                    color:
                                        isCall ? Colors.blue : Color(0xff6B779A)),
                                label: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Audio Call",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: "Museo",
                                          color: Color(0xff6B779A),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      "Book appointment\nto use this feature",
                                      style: TextStyle(
                                          fontFamily: "Museo",
                                          color: Color(0xff6B779A),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  ],
                                )),
                          
                          ],
                        ),
                        SizedBox(height: 15,),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    onPrimary: isCall == true
                                        ? Colors.blue
                                        : Colors.grey,
                                    primary: Colors.transparent,
                                    elevation: 0),
                                onPressed: () {
                                  // if (isCall) {
                                  //   print("DrNumber is: ${widget.drPhone}");
                                  //   launch("tel://${widget.drPhone!.toString()}");
                                  // }
                                },
                                icon: Icon(Icons.video_call,
                                    color:
                                        isCall ? Colors.blue : Color(0xff6B779A)),
                                label: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Video Call",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: "Museo",
                                          color: Color(0xff6B779A),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      "Book appointment\nto use this feature",
                                      style: TextStyle(
                                          fontFamily: "Museo",
                                          color: Color(0xff6B779A),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  ],
                                )),
                          
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    onPrimary: isCall == true
                                        ? Colors.blue
                                        : Colors.grey,
                                    primary: Colors.transparent,
                                    elevation: 0),
                                onPressed: () {
                                  
                                },
                                icon: Icon(Icons.chat,
                                    color:
                                        isCall ? Colors.blue : Color(0xff6B779A)),
                                label: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Chat",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: "Museo",
                                          color: Color(0xff6B779A),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    
                                  ],
                                )),
                          
                          ],
                        ),
      
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Give Rating",
                          style: TextStyle(
                              fontFamily: "Museo",
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 30,
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: isCall? Colors.green:Colors.grey,
                                  padding: EdgeInsets.all(0)),
                              onPressed: () {
                                if (isCall) {
                                  double prev = ratingValue;
                                  // ratingValue = rating;
                                  // print(rating);
                                  print("Updated Rating is: ${ratingValue}");
                                  setState(() {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Rate Doctor",
                                            style: TextStyle(
                                                fontFamily: "Museo",
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          content: Text(
                                              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                                              style: TextStyle(
                                                  fontFamily: "Museo",
                                                  color: Color(0xff6B779A),
                                                  // fontWeight: FontWeight.bold,
                                                  fontSize: 14)),
                                          actions: [
                                            RatingBar.builder(
                                              initialRating: ratingValue,
                                              minRating: 1,
                                              // itemSize: 30,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                double prev = ratingValue;
                                                setState(() {
                                                  ratingValue = rating;
                                                });
      
                                                print(rating);
                                              },
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                TextButton(
                                                  child: Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("OK"),
                                                  onPressed: () {
                                                    ratingValue *= 20;
                                                    giveRating(ratingValue);
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                    setState(() {
                                      ratingValue;
                                    });
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.star,
                                color: isCall? Colors.white:Colors.white,
                                size: 17,
                              ),
                              label: Text("${roundDouble(widget.rating!, 2)}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))),
                        ),
                        
      
                        SizedBox(
                          height: 40,
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
                                "Book Appointment",
                                style: TextStyle(fontSize: 15),
                              ),
                              onPressed: () {
                                print("Dr id12345: ${widget.drid}");
                                print("Fee is: ${widget.fee} ${widget.isInstnt}");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => bookAppointment(
                                              drid: widget.drid!,
                                              name: widget.name!,
                                              phone: widget.phoe,
                                              userID: widget.userID,
                                              fee: widget.fee!,
                                              drEmail: widget.drEmail!,
                                              isInstant: "no",
                                              instantList: widget.isInstnt,
                                            )));
                              }),
                        ),
                        SizedBox(height:20,),
                      //   Container(
                      //     height: 45,
                      //     width: MediaQuery.of(context).size.width - 40,
                      //     child: ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //           primary: (widget.isInstnt![0]!=-1 && widget.isInstnt![1]!=-1)? Color(0xff3E64FF):Colors.grey,
                      //           shape: new RoundedRectangleBorder(
                      //             borderRadius: new BorderRadius.circular(15.0),
                      //           ),
                      //         ),
                      //         child: Text(
                      //           "Instant Appointment",
                      //           style: TextStyle(fontSize: 15),
                      //         ),
                      //         onPressed: () {
                      //           print('inforr ${widget.drid} ${widget.name} ${widget.phoe} ${widget.drEmail}');
                      //           if(widget.isInstnt![0]!=-1 && widget.isInstnt![1]!=-1)
                      //           {
                      //           print("Dr id12345: ${widget.drid}");
                      //           print("Fee is: ${widget.fee}");
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => bookAppointment(
                      //                         drid: widget.drid!,
                      //                         name: widget.name!,
                      //                         phone: widget.phoe,
                      //                         userID: widget.userID,
                      //                         fee: widget.fee!,
                      //                         drEmail: widget.drEmail!,
                      //                         isInstant: "yes",
                      //                         instantList: widget.isInstnt,
                      //                       )));
                      //           }
                      //         }),
                      //   ),
                      // ],
                       ] ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
