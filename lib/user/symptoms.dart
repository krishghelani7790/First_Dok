import 'package:patientapp/Colors/color.dart';
import 'package:patientapp/doctor/doctorList.dart';
import 'package:patientapp/models/symptomsModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class userSymptoms extends StatefulWidget {
  final String name;
  final String phone;
  final String? Id;
  userSymptoms(
      {Key? key, required this.name, required this.phone, required this.Id})
      : super(key: key);

  @override
  _userSymptomsState createState() => _userSymptomsState();
}

class _userSymptomsState extends State<userSymptoms> {
  final List<Symptoms> spList = [];
  Map<String, String> allArea = {};

  int syCount = 0;
  List selected = [];
  Map<String, String> medicalArea = {};
  // var symptoms=new Map();
  Map<String, String> specialityList = {};

  @override
  void initState() {
    specialityList.clear();
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
            color: Colors.black,
            // color: col2,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: black,
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text("Select Speciality", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
                child: Text(
              "$syCount Selected",
              style: TextStyle(color: Colors.grey),
            )),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: medicalAreas,
        child: FutureBuilder(
          future: medicalAreas(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                onRefresh: medicalAreas,
                child: ListView.builder(
                  padding: const EdgeInsets.all(12.0),
                  itemCount: snapshot.data['message'].length,
                  itemBuilder: (context, index) {
                    // print("Medical Area is: ${medicalArea}");
                    allArea.putIfAbsent(snapshot.data['message'][index]['_id'],
                        () => snapshot.data['message'][index]['name']);
                    // allArea.putIfAbsent("${spList[index].id}",()=>spList[index].name.toString());
                    spList.add(Symptoms(snapshot.data['message'][index]['name'],
                        snapshot.data['message'][index]['_id'], false));
                    return Column(
                      children: [
                        Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width - 40,
                          //  decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: spList[index].isSelected == true
                                    ? Colors.blue.shade100
                                    : Colors.white,
                                shape: new RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.blue),
                                  borderRadius: new BorderRadius.circular(15.0),
                                ),
                              ),
                              child: Text(
                                "${(snapshot.data['message'][index]['name']).toString().toUpperCase()}",
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 15),
                                // style: GoogleFonts.museoModerno(fontSize: 15.0,color: Colors.blue),
                              ),
                              onPressed: () async {
                                setState(() {
                                  if (spList[index].isSelected == false) {
                                    spList[index].isSelected = true;
                                    syCount++;
                                    // symptoms.addEntries("${symList[index].name}");
                                    // symptoms["${symList[index].name}"]=index;
                                    specialityList.putIfAbsent(
                                        "${spList[index].id}",
                                        () => spList[index].name!);
                                    medicalArea.putIfAbsent(
                                        "${snapshot.data['message'][index]['_id']}",
                                        () => snapshot.data['message'][index]
                                            ['name']);

                                    style:
                                    ElevatedButton.styleFrom(
                                      primary: spList[index].isSelected == true
                                          ? Colors.blue[100]
                                          : Colors
                                              .white, // This is what you need!
                                    );
                                  } else if (spList[index].isSelected == true) {
                                    spList[index].isSelected = false;
                                    syCount--;
                                    specialityList
                                        .remove("${spList[index].id}");
                                    medicalArea.remove(
                                        "${snapshot.data['message'][index]['_id']}");

                                    style:
                                    ElevatedButton.styleFrom(
                                      primary: spList[index].isSelected == true
                                          ? Colors.white
                                          : Colors.blue[
                                              100], // This is what you need!
                                    );
                                  }

                                  // syCount++;
                                });
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('list ${specialityList.isEmpty ? 'true' : 'false'}');
          if (specialityList.isEmpty) {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Center(child: Text('Alert', style: const TextStyle(
                                    color: Colors.blue, fontSize: 18))),
                      content: Text('Please Select Atleast One Speciality', style: const TextStyle(
                                    color: Colors.blue, fontSize: 15),
                    )));
          }else if(specialityList.length>1){
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Center(child: Text('Alert', style: const TextStyle(
                                    color: Colors.blue, fontSize: 18))),
                      content: Text('You Can Select One Speciality At a Time', style: const TextStyle(
                                    color: Colors.blue, fontSize: 15),
                    )));
          } 
          else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => doctorList(
                          medicalArea: specialityList,
                          allArea: allArea,
                          phone: widget.phone,
                          id: widget.Id,
                        )));
          }
        },
        isExtended: true,
        icon: const Icon(Icons.search),
        label: Text("Search By Speciality",
            style: GoogleFonts.museoModerno(fontSize: 15, color: Colors.white)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Future<Map<String, dynamic>> medicalAreas() async {
  print("Inside Info");
  var client = http.Client();

  var doctor_Info = await client
      .get(Uri.parse('https://doctor2-kylo.herokuapp.com/medical_area/all'));

  return json.decode(doctor_Info.body);
}
