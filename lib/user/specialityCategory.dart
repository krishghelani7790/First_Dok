import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patientapp/doctor/doctorListSpeciality.dart';

class SpecialityCategory extends StatefulWidget {
  final String phone;
  const SpecialityCategory({ Key? key , required this.phone}) : super(key: key);

  @override
  _SpecialityCategoryState createState() => _SpecialityCategoryState();
}

class _SpecialityCategoryState extends State<SpecialityCategory> {
  Map<String, String> allArea = {};

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
          "Specialities",
          style: GoogleFonts.museoModerno(fontSize: 18.0, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: medicalAreas(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
           if(snapshot.data==null)
           {
             return Center(child: CircularProgressIndicator(),);
           }
           else
           {
             return GridView.builder(
               padding: const EdgeInsets.all(8.0),
               itemCount: snapshot.data['message'].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                  crossAxisCount: 2,  
                  crossAxisSpacing: 4.0,  
                  mainAxisSpacing: 4.0  
              ),  
               itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print("Opening doctors list...");
                    print('all area ${snapshot.data['message'][index]['name']} ${snapshot.data['message'][index]['_id']}');
                    // Navigator.push(context, MaterialPageRoute(
                    //             builder: (context) => DoctorListAccSpeciality(medicalArea: snapshot.data['message'][index]['name'],allArea: snapshot.data['message'][index]['_id'])));
                  },
                  child: card("${snapshot.data['message'][index]['name']}", "img_3.png"),
                  // child: card("${snapshot.data['message'][index]['name']}", "img_3.png" ,"${snapshot.data['message'][index]['doctor_frequency']}"),
                );
              },
             );
           }
        }
      ),
    );
  }
  card(String title,String img){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        // height: MediaQuery.of(context).size.height*0.4,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.grey[200]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.only(top: 15,bottom: 15),
            child: Image.asset("assets/$img",height: 45,),
          ),
          SizedBox(height: 20,),
          Text(title.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
          Padding(padding: EdgeInsets.only(top: 15)),
          // Text(nooD+" Doctors"),
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