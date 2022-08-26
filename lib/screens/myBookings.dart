import 'dart:math';

import 'package:patientapp/screens/cancelPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../doctor/selectSchedule.dart';


Map<String, String> globalSpeciality = {};

late String? patient_id;
class MyBookings extends StatefulWidget {
  final String? Id;
  MyBookings({Key? key, required this.Id}) : super(key: key);

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  
  void getMedicalArea() async {
    var client = http.Client();
    var area_Info = await client
        .get(Uri.parse('https://doctor2-kylo.herokuapp.com/medical_area/all'));
    if (area_Info.statusCode == 200) {
      var medical_area = json.decode(area_Info.body);
      print("Medical Area is: ${medical_area}");
      for (var i = 0; i < medical_area['message'].length; i++) {
        globalSpeciality.putIfAbsent(medical_area['message'][i]['_id'],
            () => medical_area['message'][i]['name']);
      }
      print("Final Speciality List is: ${globalSpeciality}");
    }
  }

  @override
  void initState() {
    
    getMedicalArea();
    print("ID of Patient in booking is: ${widget.Id}");
    patient_id = widget.Id;
    super.initState();
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
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
          "My Bookings",
          style: GoogleFonts.museoModerno(fontSize: 18.0, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: userBookings,
        child: FutureBuilder(
          future: userBookings(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if(snapshot.hasError)
              {
                return Center(
                    child: Container(
                  child: Text("Unable to fetch data!!"),
                ));
              }
              else {
                  if(snapshot.data['data'].length==0)
                {
                   return Center(
                    child: Container(
                  child: Text("You don't have any bookings!"),
                ));
                }
                else
                {

              return RefreshIndicator(
                onRefresh: userBookings,
                child: ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    itemBuilder: (context, index) {
                      // var doctor_id =
                      //     snapshot.data['data'][index]['doctor_id']['_id'];
                      var consultant_id = snapshot.data['data'][index]['_id'];
                      print("Consultation id in booking page is: ${consultant_id}");
                      // print("Doctor Id is: ${doctor_id}");
                      // List area = [];
                      // for (var i = 0;
                      //     i <
                      //         snapshot
                      //             .data['data'][index]['doctor_id']['medical_areas']
                      //             .length;
                      //     i++) {
                      //   area.add(globalSpeciality[snapshot.data['data'][index]
                      //       ['doctor_id']['medical_areas'][i]]);
                      // }
                      bool booked = false;
                      if (snapshot.data['data'][index]['cancellation']
                              ['is_cancelled'] ==
                          false) {
                        booked = true;
                      }
                      
                      // area.clear();
                      // List area = snapshot.data['data'][index]['medical_areas'];
                      // print("Speciality area of doctor is: ${area}");
                      if(snapshot.data['data'][index]['doctor_id'] != null){
                        // var exp = snapshot.data['data'][index]['doctor_id']
                        //   ['experience_years'];
                      bool _yoe = false;
                      if (exp != null) {
                        _yoe = true;
                      }
                        return Column(
                        children: [
                          Material(
                            // elevation: 2,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${snapshot.data['data'][index]['doctor_id']['name']}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Container(
                                            height: 25,
                                            child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.green,
                                                    padding: EdgeInsets.all(0)),
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                  size: 17,
                                                ),
                                                label: Text(
                                                    "${roundDouble(snapshot.data['data'][index]['doctor_id']['approval_rating']['avg'].toDouble(), 2)}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "${snapshot.data['data'][index]['doctor_id']['profile_url']}"),
                                          radius: 55,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Text("Speciality: ",
                                            //     style: TextStyle(
                                            //         color: Colors.grey,
                                            //         fontSize: 14)),
                    
                                            // Text("Experience: 0 years",
                                            //     style: TextStyle(
                                            //         color: Colors.grey, fontSize: 14)),
                                            Text(
                                              (() {
                                                if (_yoe) {
                                                  return "Experience: ${snapshot.data['data'][index]['doctor_id']['experience_years']} years";
                                                }
                    
                                                return "Experience: 0 years";
                                              })(),
                                              style: TextStyle(
                                                  color: Colors.grey, fontSize: 14),
                                              softWrap: true,
                                            ),
                    
                                            // Text("Consultation Fee: (fee)",
                                            //     style: TextStyle(
                                            //         color: Colors.grey, fontSize: 14)),
                                            Text(
                                              (() {
                                                if (snapshot.data['data'][index]
                                                        ['doctor_id']['fee'] ==
                                                    null) {
                                                  return "Consultation Fee: 0 Rs";
                                                }
                    
                                                return "Consultation Fee: ${snapshot.data['data'][index]['doctor_id']['fee']} Rs";
                                              })(),
                                              style: TextStyle(
                                                  color: Colors.grey, fontSize: 14),
                                              softWrap: true,
                                            ),
                                            // SizedBox(height: 10,),
                                            Text(
                                                "Date: ${snapshot.data['data'][index]['slot_info']['date'].toString().substring(0, 10)}",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14)),
                                            Text(
                                                "Day: ${snapshot.data['data'][index]['slot_info']['day']}",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14)),
                                            Text(
                                                "Time: ${snapshot.data['data'][index]['slot_info']['date'].toString().substring(11, 19)}",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14)),
                                            Text(
                                              (() {
                                                if (booked) {
                                                  return "Booked";
                                                }
                    
                                                return "Cancelled";
                                              })(),
                                              style: TextStyle(
                                                  color: booked
                                                      ? Colors.green
                                                      : Colors.pink.shade200,
                                                  fontSize: 14),
                                              softWrap: true,
                                            ),
                    
                                            SizedBox(
                                              height: 10,
                                            ),
                    
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // color: Colors.pink.shade200,
                                                  height: 30,
                                                  width:
                                                      (MediaQuery.of(context).size.width - 10) / 3,
                                                  child: ElevatedButton(
                                                      style:
                                                          ElevatedButton.styleFrom(
                                                        primary:
                                                            Colors.pink.shade200,
                                                        shape:
                                                            new RoundedRectangleBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .circular(10.0),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "Cancel",
                                                        style:
                                                            TextStyle(fontSize: 15),
                                                      ),
                                                      onPressed: () async {
                                                        if(booked)
                                                        {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Cancel(
                                                                          conculId:
                                                                              consultant_id,
                                                                        )));
                                                        }
                                                      }),
                                                ),
                                                SizedBox(
                                                  width: 25,
                                                ),
                                               
                                                ],
                                            ),
                                            SizedBox(height: 25,),
                                            Container(
                        height: 50,
                        width: (MediaQuery.of(context).size.width - 10) / 2.5,
                        child: ElevatedButton.icon(
                            icon: Icon(Icons.date_range),
                            style: ElevatedButton.styleFrom(
                              primary: booked.toString() == "true"
                                  ? Colors.red.shade300
                                  : Colors.grey,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                            ),
                            label: Text(
                              "Reshedule",
                              style: TextStyle(fontSize: 15),
                            ),
                            onPressed: () async {
                              // if (booked == "true") {
                                print("Resheduling....!!!!");
                                // openDialog();
                                print("Dr id is1234: ${snapshot.data['data'][index]['doctor_id']['_id']}");
                                print("eventID id is1234: ${snapshot.data['data'][index]['event_id']}");
                                print(
                                    "Concultation id is1234: ${consultant_id}");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => SelectSchedule(
                                          drid: snapshot.data['data'][index]['doctor_id']['_id'],
                                          consultation_id:
                                              consultant_id,
                                          even_id: snapshot.data['data'][index]['event_id'])),
                                );
                              
                              // }
                            }),
                      ),
                                            // Container(
                                            //       height: 30,
                                            //       width:
                                            //           (MediaQuery.of(context).size.width - 10) / 3,
                                            //       child: ElevatedButton(
                                            //           style:
                                            //               ElevatedButton.styleFrom(
                                            //             primary: Color(0xff3E64FF),
                                            //             shape:
                                            //                 new RoundedRectangleBorder(
                                            //               borderRadius:
                                            //                   new BorderRadius
                                            //                       .circular(10.0),
                                            //             ),
                                            //           ),
                                            //           child: Text(
                                            //             "Join Meet",
                                            //             style:
                                            //                 TextStyle(fontSize: 15),
                                            //           ),
                                            //           onPressed: () async {
                                            //             print('link ${snapshot.data['data'][index]['meet_url']}');
                                            //             if (!await launch(snapshot.data['data'][index]['meet_url'])) throw 'Could not launch ${snapshot.data['data'][index]['meet_url']}';
                                            //           }),

                                            //     ),
                                                // Container(
                                                //   height: 30,
                                                //   width:
                                                //       (MediaQuery.of(context).size.width - 10) / 3,
                                                //   child: ElevatedButton(
                                                //       style:
                                                //           ElevatedButton.styleFrom(
                                                //         primary: Color(0xff3E64FF),
                                                //         shape:
                                                //             new RoundedRectangleBorder(
                                                //           borderRadius:
                                                //               new BorderRadius
                                                //                   .circular(10.0),
                                                //         ),
                                                //       ),
                                                //       child: Text(
                                                //         "Download ",
                                                //         style:
                                                //             TextStyle(fontSize: 15),
                                                //       ),
                                                //       onPressed: () async {
                                                //         print('link ');
                                                //         getPrescription();
                                                //       }),

                                                // ),


                                              
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                      height: 12,
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                      }
                      else {
                       return Container();
                      }
                      
                    }),
              );}
            }
          },
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> userBookings() async {
  print("Inside Info");
  var client = http.Client();
  // String url = "https://doctor2-kylo.herokuapp.com/doctor/info/all";
  print("Patient ID is: $patient_id");
  var doctor_Info = await client.get(Uri.parse(
      'https://doctor2-kylo.herokuapp.com/consult/by_patient/$patient_id'));
  // http.Response data = await http.get(Uri.parse(url));
  var a = json.decode(doctor_Info.body);
  // print("Meet Url: ${a['data'][0]['meet_url']}");
  print('meet url ${doctor_Info.body}');
  return json.decode(doctor_Info.body);
}

Future<Map<String, dynamic>> getPrescription() async {
  print("Inside Info");
  var client = http.Client();
  // String url = "https://doctor2-kylo.herokuapp.com/doctor/info/all";
  print("Patient ID is: $patient_id");
  var prescription = await client.get(Uri.parse(
      'https://doctor2-kylo.herokuapp.com/prescription/all'));
  // http.Response data = await http.get(Uri.parse(url));
  var a = json.decode(prescription.body);
  print(prescription.runtimeType);
  print(prescription);
  print('meet url ${prescription.body}');
  return json.decode(prescription.body);
}
