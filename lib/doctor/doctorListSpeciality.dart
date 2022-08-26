import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class DoctorListAccSpeciality extends StatefulWidget {
  // Map<String, String>? medicalArea;
  String? name1;
  String? name2, name3, name4;

  DoctorListAccSpeciality({this.name1, this.name2, this.name3, this.name4});

  @override
  State<DoctorListAccSpeciality> createState() =>
      _DoctorListAccSpecialityState();
}

class _DoctorListAccSpecialityState extends State<DoctorListAccSpeciality> {
  Map<String, String>? medicalArea;

  @override
  void initState() {
    // TODO: implement initState

    print('vsv ${widget.name1} ${widget.name2}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "Doctor List",
            style:
                GoogleFonts.museoModerno(fontSize: 18.0, color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
            child: widget.name1 == ''
                ? Center(
                    child: Text('No Doctor Available'),
                  )
                : Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          '${widget.name1}',
                          style: GoogleFonts.museoModerno(
                              fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          '${widget.name2}',
                          style: GoogleFonts.museoModerno(
                              fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          '${widget.name3}',
                          style: GoogleFonts.museoModerno(
                              fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          '${widget.name4}',
                          style: GoogleFonts.museoModerno(
                              fontSize: 16.0, color: Colors.black),
                        ),
                      )
                    ],
                  )));

    // FutureBuilder(
    //     future: doctorInfor(),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       if (snapshot.hasData) {
    //         return ListView.builder(
    //             itemCount: snapshot.data['data'].length,
    //             itemBuilder: (context, index) {
    //               if (snapshot.data['data'][index]['medical_areas'] !=
    //                       null &&
    //                   snapshot.data['data'][index]['medical_areas']
    //                       .isNotEmpty) {
    //                 print(
    //                     'object ${snapshot.data['data'][index]['medical_areas'][0]}');
    //                 // if(snapshot.data['data'][index]['medical_areas'][0].isNotEmpty) {
    //                 if (widget.allArea ==
    //                     snapshot.data['data'][index]['medical_areas']
    //                         [0]) {
    //                   return ListTile(
    //                     title: Text(
    //                       '${snapshot.data['data'][index]['name']}',
    //                       style: GoogleFonts.museoModerno(
    //                           fontSize: 16.0, color: Colors.black),
    //                     ),
    //                   );

    //                   //    else {
    //                   //   return Container();
    //                   // }
    //                 } else {
    //                   return Container();
    //                 }
    //               } else {
    //                 return Container();
    //               }
    //             });
    //       } else if (snapshot.data == null) {
    //         return Center(
    //             child: Container(child: CircularProgressIndicator()));
    //       } else {
    //         return Center(
    //             child: Container(child: Text('No Data Available')));
    //       }
    //     })));
  }

  Future doctorInfor() async {
    var client = http.Client();
    var b = 'Data Not Availble';

    var doctor_Info = await client
        .get(Uri.parse('https://doctor2-kylo.herokuapp.com/doctor/info/all'));

    var a = json.decode(doctor_Info.body);
    print('func $a');
    if (doctor_Info.statusCode == 200) {
      return json.decode(doctor_Info.body);
    } else {
      return b;
    }
  }
}
