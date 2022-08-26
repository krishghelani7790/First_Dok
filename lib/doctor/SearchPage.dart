// import 'dart:math';

// import 'package:dio/dio.dart';
// import 'package:patientapp/doctor/doctorInfo.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// List tempList2 = [];
// List filternames2 = [];

// class SearchPage1 extends StatefulWidget {
//   Map<String, String> allArea;
//   // final String patientName;
//   final String Userphone;
//   final String Userid;
//   SearchPage1(
//       {Key? key,
//       required this.allArea,
//       required this.Userphone,
//       required this.Userid})
//       : super(key: key);

//   @override
//   _SearchPage1State createState() => _SearchPage1State();
// }

// class _SearchPage1State extends State<SearchPage1> {
//   double roundDouble(double value, int places) {
//     num mod = pow(10.0, places);
//     return ((value * mod).round().toDouble() / mod);
//   }

//   // List area = [];
//   Map<String, int> names = {};

//   final key = new GlobalKey<ScaffoldState>();
// //Step 3
//   _SearchPage1State() {
//     _filter.addListener(() {
//       if (_filter.text.isEmpty) {
//         setState(() {
//           _searchText = "";
//           filteredNames = name;
//         });
//       } else {
//         setState(() {
//           _searchText = _filter.text;
//         });
//       }
//     });
//   }

//   Map<String, Map>? doctorData = new Map();
//   Map<int, String> mapOfId = {};
// //Step 1
//   final TextEditingController _filter = new TextEditingController();
//   final dio = new Dio(); // for http requests
//   String _searchText = "";
//   List name = []; // names we get from API
//   List filteredNames = []; // names filtered by search text
//   List allNames = [];
//   List listofIds = [];
//   Icon _searchIcon = new Icon(Icons.search, color: Colors.black);
//   Widget _appBarTitle = new Text(
//     'Search Doctor',
//     style: GoogleFonts.museoModerno(fontSize: 18.0, color: Colors.black),
//   );

//   //step 2.1
//   Future _getNames() async {
//     String day = DateFormat('EEEE').format(DateTime.now()).substring(0, 3);
//     DateTime date = DateTime.now();
//     String str = date.toString().substring(11, 16);
//     final response = await dio.get(
//         'https://doctor2-kylo.herokuapp.com/doctor/info/all?day=${day}&time=${str}');
//     print(response.data);
//     List tempList = [];
//     // print("Len of data is ${response.data['data']}");
//     for (int i = 0; i < response.data['data']!.length; i++) {
//       // print("Doctor Name: ${response.data['data'][i]['name']}");

//       tempList.add(response.data['data'][i]['name']);
//       allNames.add(response.data['data'][i]['name']);
//       String doctorName = response.data['data'][i]['name'];
//       String doctorExperience =
//           response.data['data'][i]['experience_years'].toString();
//       double doctorRating =
//           response.data['data'][i]['approval_rating']['avg'].toDouble();
//       String imgUrl = response.data['data'][i]['profile_url'];
//       String drid = response.data['data'][i]['_id'];
//       String fee = response.data['data'][i]['fee'].toString();
//       String doctorEmail = response.data['data'][i]['email'];
//       String doctorPhone = response.data['data'][i]['phone_number'].toString();
//       String doctorBio = response.data['data'][i]['bio'];
//       List isInstant = response.data['c_a_list'][i];
//       print("availability is: ${isInstant}");
//       List speciality = [];
//       Map<String, dynamic> wHrs = {};

//       if (response.data['data'][i]['working_hours'] != null) {
//         wHrs = Map<String, dynamic>.from(
//             response.data['data'][i]['working_hours']);
//       }
//       if (response.data['data'][i]['medical_areas'] != null) {
//         for (var j = 0;
//             j < response.data['data'][i]['medical_areas'].length;
//             j++) {
//           speciality.add(
//               widget.allArea[response.data['data'][i]['medical_areas'][j]]);
//         }
//       }

//       doctorData?[drid] = new Map();
//       doctorData?[drid]!.putIfAbsent("name", () => doctorName);
//       doctorData?[drid]!
//           .putIfAbsent("experience_years", () => doctorExperience);
//       doctorData?[drid]!.putIfAbsent("rating", () => doctorRating);
//       doctorData?[drid]!.putIfAbsent("image", () => imgUrl);
//       doctorData?[drid]!.putIfAbsent("drid", () => drid);
//       doctorData?[drid]!.putIfAbsent("UserPhone", () => widget.Userphone);
//       doctorData?[drid]!.putIfAbsent("UserId", () => widget.Userid);
//       doctorData?[drid]!.putIfAbsent("fee", () => fee);
//       doctorData?[drid]!.putIfAbsent("bio", () => doctorBio);
//       doctorData?[drid]!.putIfAbsent("email", () => doctorEmail);
//       doctorData?[drid]!.putIfAbsent("doctor_phone", () => doctorPhone);
//       doctorData?[drid]!.putIfAbsent("speciality", () => speciality);
//       doctorData?[drid]!.putIfAbsent("working_hours", () => wHrs);
//       doctorData?[drid]!.putIfAbsent("isInstant", () => isInstant);
//       if (doctorName == "Tarak") {
//         print("Tarak Name is: ${doctorName}");
//         print("Tarak id is: ${drid}");
//       }
//       // print("data map of doctor $i is $doctorData");

//       // mapOfId.addEntries(newEntries)
//       mapOfId.putIfAbsent(i, () => drid);
//     }
//     setState(() {
//       name = tempList;
//       filteredNames = name;
//     });
//   }

// //Step 2.2
//   void _searchPressed() {
//     setState(() {
//       if (this._searchIcon.icon == Icons.search) {
//         this._searchIcon = new Icon(
//           Icons.close,
//           color: Colors.black,
//         );
//         this._appBarTitle = new TextField(
//           controller: _filter,
//           decoration: new InputDecoration(
//             prefixIcon: new Icon(Icons.search),
//             hintText: 'Search...',
//             hintStyle:
//                 GoogleFonts.museoModerno(fontSize: 12.0, color: Colors.black),
//           ),
//         );
//       } else {
//         this._searchIcon = new Icon(Icons.search, color: Colors.black);
//         this._appBarTitle = new Text(
//           'Search Doctor',
//           style: GoogleFonts.museoModerno(fontSize: 18.0, color: Colors.black),
//         );
//         filteredNames = name;
//         _filter.clear();
//       }
//     });
//   }

//   //Step 4

//   Widget _buildList() {
//     if ((_searchText.isEmpty)) {
//       List tempList = [];
//       List tempId = [];
//       for (int i = 0; i < allNames.length; i++) {
//         if (allNames[i].toLowerCase().contains(_searchText.toLowerCase())) {
//           // print("added name is123: ${filteredNames[i]}");
//           tempList.add(allNames[i]);
//           // tempList2.add(filteredNames[i]);
//           // print("Filter name is: ${filteredNames[i]}");
//           tempId.add(i);
//           print("index added is: ${i}");
//         }
//       }
//       // setState(() {
//       //   filteredNames = tempList;
//       // });
//       filteredNames = tempList;
//       listofIds = tempId;
//       // filternames2=tempList2;
//       print("Temp2 list is123 new is: ${tempList2}");
//       print("Ids list is: ${listofIds}");
//       print("Filter names is: ${filteredNames}");
//     } else if (filteredNames.length == 0) {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     return ListView.builder(
//       itemCount: name == null ? 0 : filteredNames.length,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//             title: Text(filteredNames[index]),
//             onTap: () => {
//                   // print("index is234: ${filternames2[index]}"),
//                   print(" name of index: ${filteredNames[index]}"),
//                   print("index of name : ${mapOfId[index]}"),

//                   // _searchText.isNotEmpty?print()
//                   if (_searchText.isEmpty)
//                     {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => doctorInfo(
//                                     name: doctorData?[mapOfId[index]]!['name'],
//                                     experience: doctorData?[mapOfId[index]]![
//                                         'experience_years'],
//                                     rating:
//                                         doctorData?[mapOfId[index]]!['rating'],
//                                     imgURL:
//                                         doctorData?[mapOfId[index]]!['image'],
//                                     medicalAreas: doctorData?[mapOfId[index]]![
//                                         'speciality'],
//                                     wHrs: doctorData?[mapOfId[index]]![
//                                         'working_hours'],
//                                     drid: mapOfId[index]!,
//                                     phoe: doctorData?[mapOfId[index]]![
//                                         'UserPhone'],
//                                     userID:
//                                         doctorData?[mapOfId[index]]!['UserId'],
//                                     fee: doctorData?[mapOfId[index]]!['fee'],
//                                     drEmail:
//                                         doctorData?[mapOfId[index]]!['email'],
//                                     bio: doctorData?[mapOfId[index]]!['bio'],
//                                     drPhone: doctorData?[mapOfId[index]]![
//                                         'doctor_phone'],
//                                     isInstnt: doctorData?[mapOfId[index]]![
//                                         'isInstant'],
//                                   ))),
//                     }
//                   else
//                     {
//                       print('Clicked index is: ${index}'),
//                       print("List of id of index is: ${listofIds[index]}"),
//                       print("Search is not empty!!"),
//                       print("Index is: ${listofIds[index]}"),
//                       print(
//                           "Tarak infor: ${doctorData?[mapOfId[listofIds[index]]]}"),
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => doctorInfo(
//                                     name: doctorData?[
//                                         mapOfId[listofIds[index]]]!['name'],
//                                     experience:
//                                         doctorData?[mapOfId[listofIds[index]]]![
//                                             'experience_years'],
//                                     rating: doctorData?[
//                                         mapOfId[listofIds[index]]]!['rating'],
//                                     imgURL: doctorData?[
//                                         mapOfId[listofIds[index]]]!['image'],
//                                     medicalAreas:
//                                         doctorData?[mapOfId[listofIds[index]]]![
//                                             'speciality'],
//                                     wHrs:
//                                         doctorData?[mapOfId[listofIds[index]]]![
//                                             'working_hours'],
//                                     drid: doctorData?[
//                                         mapOfId[listofIds[index]]]!['drid'],
//                                     phoe:
//                                         doctorData?[mapOfId[listofIds[index]]]![
//                                             'UserPhone'],
//                                     userID: doctorData?[
//                                         mapOfId[listofIds[index]]]!['UserId'],
//                                     fee: doctorData?[
//                                         mapOfId[listofIds[index]]]!['fee'],
//                                     drEmail: doctorData?[
//                                         mapOfId[listofIds[index]]]!['email'],
//                                     bio: doctorData?[
//                                         mapOfId[listofIds[index]]]!['bio'],
//                                     drPhone:
//                                         doctorData?[mapOfId[listofIds[index]]]![
//                                             'doctor_phone'],
//                                     isInstnt:
//                                         doctorData?[mapOfId[listofIds[index]]]![
//                                             'isInstant'],
//                                   ))),
//                     }
//                 });
//       },
//     );
//   }

//   //STep6
//   PreferredSizeWidget _buildBar(BuildContext context) {
//     return new AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       centerTitle: true,
//       title: _appBarTitle,
//       leading: new IconButton(
//         icon: _searchIcon,
//         onPressed: _searchPressed,
//       ),
//     );
//   }

//   @override
//   void initState() {
//     _getNames();
//     super.initState();
//     print("All areas are in search page 123: ${widget.allArea}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildBar(context),
//       body: Container(
//         child: RefreshIndicator(onRefresh: _getNames, child: _buildList()),
//       ),
//       resizeToAvoidBottomInset: false,
//     );
//   }
// }
