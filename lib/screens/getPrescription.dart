import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patientapp/screens/cancelPage.dart';
import 'package:url_launcher/url_launcher.dart';

Map<String, String> globalSpeciality = {};

class GetDoctorPrescription extends StatefulWidget {
  final String? patinetID;
  GetDoctorPrescription({Key? key, required this.patinetID}) : super(key: key);

  @override
  State<GetDoctorPrescription> createState() => _GetDoctorPrescriptionState();
}

class _GetDoctorPrescriptionState extends State<GetDoctorPrescription> {
  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  void initState() {
    // TODO: implement initState
    print('object ${widget.patinetID}');
    super.initState();
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
          "Consultation Records",
          style: GoogleFonts.museoModerno(fontSize: 18.0, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: getPrescription1,
        child: FutureBuilder(
          future: getPrescription1(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Container(
                child: Text("Unable to fetch data!"),
              ));
            } else {
              if (snapshot.data['data'].length == 0) {
                return Center(
                    child: Container(
                  child: Text("You don't have any consultation records!"),
                ));
              } else {
                return RefreshIndicator(
                  onRefresh: getPrescription1,
                  child: ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (context, index) {
                        if (snapshot.data['data'].isNotEmpty &&
                            snapshot.data['data'][index]['doctor_id'] != null) {
                          // var doctor_id =
                          //     snapshot.data['data'][index]['doctor_id']['_id'];
                          var consultant_id =
                              snapshot.data['data'][index]['_id'];
                          print(
                              "Consultation id in booking page is: ${consultant_id}");
                          // print("Doctor Id is: ${doctor_id}");
                          List area = [];
                          for (var i = 0;
                              i <
                                  snapshot
                                      .data['data'][index]['doctor_id']
                                          ['medical_areas']
                                      .length;
                              i++) {
                            area.add(globalSpeciality[snapshot.data['data']
                                [index]['doctor_id']['medical_areas'][i]]);
                          }
                          bool booked = false;

                          var exp = snapshot.data['data'][index]['doctor_id']
                              ['experience_years'];
                          bool _yoe = false;
                          if (exp != null) {
                            _yoe = true;
                          }
                          // area.clear();
                          // List area = snapshot.data['data'][index]['medical_areas'];
                          print("Speciality area of doctor is: ${area}");
                          return Column(
                            children: [
                              Material(
                                // elevation: 2,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.green,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0)),
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
                                                                FontWeight
                                                                    .bold))),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "${snapshot.data['data'][index]['doctor_id']['profile_url']}"),
                                              radius: 55,
                                              backgroundColor:
                                                  Colors.transparent,
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
                                                Text("Speciality: ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14)),

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
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  softWrap: true,
                                                ),

                                                // Text("Consultation Fee: (fee)",
                                                //     style: TextStyle(
                                                //         color: Colors.grey, fontSize: 14)),
                                                Text(
                                                  (() {
                                                    if (snapshot.data['data']
                                                                    [index]
                                                                ['doctor_id']
                                                            ['fee'] ==
                                                        null) {
                                                      return "Consultation Fee: 0 Rs";
                                                    }

                                                    return "Consultation Fee: ${snapshot.data['data'][index]['doctor_id']['fee']} Rs";
                                                  })(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  softWrap: true,
                                                ),
                                                // SizedBox(height: 10,),

                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                    height: 45,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.52,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              Color(0xff3E64FF),
                                                          shape:
                                                              new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    15.0),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          "Download Prescription",
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                        onPressed: () async {
                                                          print('link ');
                                                          print(
                                                              'object ${snapshot.data['data'][index]['document_url']} ${snapshot.data['data'][index]['desciption']}');
                                                          await launch(snapshot
                                                                      .data[
                                                                  'data'][index]
                                                              ['document_url']);
                                                        })),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                            'Description : ${snapshot.data['data'][index]['desciption']}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            )),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.black,
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      }),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getPrescription1() async {
    print("Inside Info");
    var client = http.Client();
    // String url = "https://doctor2-kylo.herokuapp.com/doctor/info/all";
    // print("Patient ID is: $patient_id");
    var prescription = await client
        .get(Uri.parse('https://doctor2-kylo.herokuapp.com/prescription/all'));
    // http.Response data = await http.get(Uri.parse(url));
    var a = json.decode(prescription.body);
    print(prescription.runtimeType);
    print(prescription);
    print('meet url ${prescription.body}');
    return json.decode(prescription.body);
  }
}
