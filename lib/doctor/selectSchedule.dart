import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
// ignore_for_file: file_names, unused_field, prefer_final_fields
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Colors/color.dart';
import '../components/slotIndex.dart';
import '../models/freeAppointmentSlots.dart';

class SelectSchedule extends StatefulWidget {
  const SelectSchedule({
    Key? key,
    required this.drid,
    required this.consultation_id,
    required this.even_id,
  }) : super(key: key);

  final String drid;
  final String consultation_id;
  final String even_id;
  @override
  _SelectScheduleState createState() => _SelectScheduleState();
}

class _SelectScheduleState extends State<SelectSchedule> {
  DateTime selectedDate = DateTime.now();
  // String Day=selectedDate.day as String;

  String? selectedDateString;
  DateTime yesterday = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);

  String urllink = "https://doctor2-kylo.herokuapp.com/doctor/info/by_id";
  FreeAppointmentSlots? doctorSlots;
  // var _razorpay = Razorpay();
  List<String> monlist = [];
  List<String> tuelist = [];
  List<String> wedlist = [];
  List<String> thulist = [];
  List<String> frilist = [];
  List<String> satlist = [];
  List<String> sunlist = [];

  List<String> allist = [];

  @override
  void initState() {
    DateTime selectedDate = DateTime.now();
    // String Day=selectedDate.day as String;
  }

  Future getdrprofile() async {
    print("Dr ID  is1234: ${widget.drid}");
    http.Response response =
        await http.get(Uri.parse("${urllink}/${widget.drid}"));
    print("URL $urllink");
    print("Response ${response.body}");
    // print("Status code is: ${response.statusCode}");
    if (response.statusCode == 200) {
      // print("Data of Doc: ");
      Map<String, dynamic> parsed = await jsonDecode(response.body);
      print("Parsed slots is: ${parsed}");
      doctorSlots = await FreeAppointmentSlots.fromJson(parsed);
      // print("Nilesh");
     
      slotMon();
      slotTue();
      slotWed();
      slotThu();
      slotFri();
      slotSat();
      slotSun();
    } else {
      print(
          "error in fetching DRPROFILE selectschedule ${response.statusCode}");
    }

    return allist;
  }

  slotMon() async {
    if (monlist.isEmpty) {
      for (var i = 0; i < 56; i++) {
        if (doctorSlots!.data!.slots!.mon1![i].is_available && !doctorSlots!.data!.slots!.mon1![i].is_booked ) {
          monlist.add(doctorSlots!.data!.slots!.mon1![i].start_time);
          allist.add(doctorSlots!.data!.slots!.mon1![i].start_time);
        }
      }
      print("list Mon ${monlist.length}");
    }
    return monlist;
  }

  slotTue() async {
    if (tuelist.isEmpty) {
      for (var i = 0; i < 56; i++) {
        if (doctorSlots!.data!.slots!.tue1![i].is_available && !doctorSlots!.data!.slots!.tue1![i].is_booked) {
          tuelist.add(doctorSlots!.data!.slots!.tue1![i].start_time);
          allist.add(doctorSlots!.data!.slots!.tue1![i].start_time);
        }
      }
      print("list The $tuelist");
    }
    return tuelist;
  }

  slotWed() async {
    if (wedlist.isEmpty) {
      for (var i = 0; i < 56; i++) {
        if (doctorSlots!.data!.slots!.wed1![i].is_available && !doctorSlots!.data!.slots!.wed1![i].is_booked) {
          wedlist.add(doctorSlots!.data!.slots!.wed1![i].start_time);
          allist.add(doctorSlots!.data!.slots!.wed1![i].start_time);
        }
      }
      print("list Wed $wedlist");
    }
    return wedlist;
  }

  slotThu() async {
    if (thulist.isEmpty) {
      for (var i = 0; i < 56; i++) {
        if (doctorSlots!.data!.slots!.thu1![i].is_available && !doctorSlots!.data!.slots!.thu1![i].is_booked) {
          thulist.add(doctorSlots!.data!.slots!.thu1![i].start_time);
          allist.add(doctorSlots!.data!.slots!.thu1![i].start_time);
        }
      }
      print("list Thu $thulist");
    }
    return thulist;
  }

  slotFri() async {
    if (frilist.isEmpty) {
      for (var i = 0; i < 56; i++) {
        if (doctorSlots!.data!.slots!.fri1![i].is_available && !doctorSlots!.data!.slots!.fri1![i].is_booked) {
          frilist.add(doctorSlots!.data!.slots!.fri1![i].start_time);
          allist.add(doctorSlots!.data!.slots!.fri1![i].start_time);
        }
      }
      print("list Fri ${frilist.length}");
    }
    return frilist;
  }

  slotSat() async {
    if (satlist.isEmpty) {
      for (var i = 0; i < 56; i++) {
        if (doctorSlots!.data!.slots!.sat1![i].is_available && !doctorSlots!.data!.slots!.sat1![i].is_booked) {
          satlist.add(doctorSlots!.data!.slots!.sat1![i].start_time);
          allist.add(doctorSlots!.data!.slots!.sat1![i].start_time);
        }
      }
      print("list Sat $satlist");
    }
    return satlist;
  }

  slotSun() async {
    if (sunlist.isEmpty) {
      for (var i = 0; i < 56; i++) {
        if (doctorSlots!.data!.slots!.sun1![i].is_available && !doctorSlots!.data!.slots!.sun1![i].is_booked) {
          sunlist.add(doctorSlots!.data!.slots!.sun1![i].start_time);
          allist.add(doctorSlots!.data!.slots!.sun1![i].start_time);
        }
      }
      print("list Sat $sunlist");
    }
    return sunlist;
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.01;
    double _height = MediaQuery.of(context).size.height * 0.01;
    // DateTime selectedDate1=DateTime.now();
    DateYesterday() async {
      var selectDate =
          await int.parse('${DateFormat('d').format(selectedDate)}');
      assert(selectDate is int);

      var curDate =
          await int.parse('${DateFormat('d').format(DateTime.now())}');
      assert(curDate is int);

      if (selectDate > curDate) {
        DateTime dateminus = DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day - 1);
        setState(() {
          selectedDate = dateminus;
        });
      }
      //  print("$selectedDateString");
    }

    DateTomorrow() async {
      var selectDate =
          await int.parse('${DateFormat('d').format(selectedDate)}');
      assert(selectDate is int);

      var curDate =
          await int.parse('${DateFormat('d').format(DateTime.now())}');
      assert(curDate is int);

      if (selectDate <= (curDate + 6)) {
        DateTime dateplus = DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day + 1);
        setState(() {
          selectedDate = dateplus;
        });
      }
      // print("$selectedDateString");
    }

    print("Doctor id is from schedule: ${widget.drid}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Select Schedule",
          style: GoogleFonts.museoModerno(fontSize: 16.0, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 4,
              color: white,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                    ),
                    onPressed: () => DateYesterday(),
                    color: col2,
                  ),
                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Text(
                    "${DateFormat('EEEE, d MMM, yyyy').format(selectedDate)}", // DateFormat('EEEE').format(date)
                    style: GoogleFonts.museoModerno(
                      fontSize: 20.0,

                      color: Color(0xff6B779A),
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                    onPressed: () => DateTomorrow(),
                    color: col2,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: FutureBuilder(
                  future: getdrprofile(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (DateFormat('EEEE').format(selectedDate) == "Monday") {
                        return monlist.isNotEmpty
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 90,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 15),
                                itemCount: monlist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return slotbox(monlist[index]);
                                })
                            : Center(
                                child: Text(
                                "Not available on this day",
                                style: GoogleFonts.museoModerno(
                                    fontSize: 18.0, color: Color(0xff6B779A)),
                              ));
                      } else if (DateFormat('EEEE').format(selectedDate) ==
                          "Tuesday") {
                        return tuelist.isNotEmpty
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 90,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 15),
                                itemCount: tuelist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return slotbox(tuelist[index]);
                                })
                            : Center(
                                child: Text(
                                "Not available on this day",
                                style: GoogleFonts.museoModerno(
                                    fontSize: 18.0, color: Color(0xff6B779A)),
                              ));
                      } else if (DateFormat('EEEE').format(selectedDate) ==
                          "Wednesday") {
                        print("Wed list is: $wedlist");
                        return wedlist.isNotEmpty
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 90,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 15),
                                itemCount: wedlist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return slotbox(wedlist[index]);
                                })
                            : Center(
                                child: Text(
                                "Not available on this day",
                                style: GoogleFonts.museoModerno(
                                    fontSize: 18.0, color: Color(0xff6B779A)),
                              ));
                      } else if (DateFormat('EEEE').format(selectedDate) ==
                          "Thursday") {
                        return thulist.isNotEmpty
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 90,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 15),
                                itemCount: thulist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return slotbox(thulist[index]);
                                })
                            : Center(
                                child: Text(
                                "Not available on this day",
                                style: GoogleFonts.museoModerno(
                                    fontSize: 18.0, color: Color(0xff6B779A)),
                              ));
                      } else if (DateFormat('EEEE').format(selectedDate) ==
                          "Friday") {
                        print("Friday List: ${frilist}");
                        return frilist.isNotEmpty
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 90,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 15),
                                itemCount: frilist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return slotbox(frilist[index]);
                                })
                            : Center(
                                child: Text(
                                "Not available on this day",
                                style: GoogleFonts.museoModerno(
                                    fontSize: 18.0, color: Color(0xff6B779A)),
                              ));
                      } else if (DateFormat('EEEE').format(selectedDate) ==
                          "Saturday") {
                        return satlist.isNotEmpty
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 90,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 15),
                                itemCount: satlist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return slotbox(satlist[index]);
                                })
                            : Center(
                                child: Text(
                                "Not available on this day",
                                style: GoogleFonts.museoModerno(
                                    fontSize: 18.0, color: Color(0xff6B779A)),
                              ));
                      } else {
                        return Center(
                            child: Text("Not available",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: col5,
                                )));
                      }
                    } else if (snapshot.hasError) {
                      print("Snapshot Error: ${snapshot.error}");
                      return Center(
                          child: Text("Unable to fetch slots",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: col5,
                              )));
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                        backgroundColor: col1,
                        color: col2,
                      ));
                    }
                  }),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => ConfirmAppointment(
      //                   name: widget.name,
      //                   email: widget.email,
      //                   phoneNumber: widget.phoneNumber,
      //                   drName: widget.drName,
      //                 )));
      //   },
      //   isExtended: true,
      //   icon: const Icon(Icons.payment),
      //   label: Text("Proceed To Payment",
      //       style: GoogleFonts.museoModerno(fontSize: 15, color: Colors.white)),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget slotbox(String txt) {
    double _width = MediaQuery.of(context).size.width * 0.01;
    double _height = MediaQuery.of(context).size.height * 0.01;

    return GestureDetector(
      onTap: () async {
        Payment payment = Payment();
        var slot_index = await payment.map["$txt"];
        MapEntry entry = payment.map.entries.firstWhere(
          (element) => element.value == slot_index,
        );

        print("Slot Index $slot_index  ${entry.key} ${entry.value}");

        print("Selected Date 12345: ${selectedDate}");
        print("Selected Day is: ${DateFormat('EEEE').format(selectedDate)}");
        String date = DateFormat('yyyy-MM-d').format(selectedDate).toString();
        String day = DateFormat('EEEE').format(selectedDate).substring(0, 3);
        var body3 = jsonEncode({
          "consultation_id": widget.consultation_id,
          "slot_info": {
            "index": slot_index,
            "day": day,
            "date": "${date}T${entry.key}:00",
          },
          "event_id": widget.even_id,
        });
        print("Body1111: ${body3}");
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    "Reshedule Appointment",
                    style: TextStyle(
                        fontFamily: "Museo",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  content: Text(
                    "Your appointment will reschedule on ${date} (${day}) , at ${entry.key}",
                    style: TextStyle(
                        fontFamily: "Museo",
                        color: Color(0xff6B779A),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: Text("CANCEL"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text("SUBMIT"),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            print("Resheduling Appointment...!!!");
                            String url =
                                'https://doctor2-kylo.herokuapp.com/consult/reschedule';
                            print("Send Request");
                            final response45 = await http.Client().patch(
                              Uri.parse(url),
                              body: body3,
                              headers: {"Content-Type": "application/json"},
                            );
                            
                            print(
                                "new Consult response is: ${response45.body}");
                            if (response45.statusCode == 201 ||
                                response45.statusCode == 200) {
                              print("OK 2 ${response45.body}");
                              
                              var parsed = jsonDecode(response45.body);
                              Fluttertoast.showToast(
                                  msg:"Appointment is successfully reschedulled..!!!", // message
                                  toastLength: Toast.LENGTH_SHORT, // length
                                  gravity: ToastGravity.CENTER, // location
                                  timeInSecForIosWeb: 1 // duration
                                  );
                                  
                            } else {
                              print(
                                  "Error ${response45.statusCode} ${response45.body}");
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ));
        // Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => null));
      },
      child: Card(
        elevation: 5,
        color: white,
        child: Center(
            child: Text(
          "$txt",
          textAlign: TextAlign.center,
          style: GoogleFonts.museoModerno(
              fontSize: 18.0, color: Color(0xff6B779A)),
        )),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      ),
    );
  }
}
