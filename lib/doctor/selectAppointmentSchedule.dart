
// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
// ignore_for_file: file_names, unused_field, prefer_final_fields
import 'package:intl/intl.dart';
import 'package:patientapp/Colors/color.dart';
import 'package:patientapp/doctor/confirmAppointment.dart';
import 'package:patientapp/models/freeAppointmentSlots.dart';

import '../components/slotIndex.dart';

class SelectAppointmentSchedule extends StatefulWidget {
  SelectAppointmentSchedule(
      {Key? key,
    required this.drid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.drName,
    required this.ID,
    required this.fee,
    required this.drEmail,
    required this.description,
    required this.isInstant,
    required this.instantList,
    required this.order_id})
      : super(key: key);

  final String drid;
  final String name;
  final String email;
  final String phoneNumber;
  final String drName;
  final String ID;
  final String fee;
  final String drEmail;
  final String description;
  final String isInstant;
  List? instantList=[];
  final String order_id;

  @override
  _SelectAppointmentScheduleState createState() => _SelectAppointmentScheduleState();
}

class _SelectAppointmentScheduleState extends State<SelectAppointmentSchedule> {
  DateTime selectedDate = DateTime.now();
  String? selectedDateString;

  DateTime yesterday = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);

  String urllink = "https://doctor2-kylo.herokuapp.com/doctor/info/by_id";
  FreeAppointmentSlots? doctorSlots;
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
    getdrprofile();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getdrprofile() async {
    print('123er ${widget.drid}');
    http.Response response =
        await http.get(Uri.parse("${urllink}/${widget.drid}"));
    print("URL $urllink");
    print("Response ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> parsed = await jsonDecode(response.body);
      doctorSlots = await FreeAppointmentSlots.fromJson(parsed);
      print("wed length ");
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

      if (selectDate <= (curDate + 5)) {
        DateTime dateplus = DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day + 1);
        setState(() {
          selectedDate = dateplus;
        });
      }
      // print("$selectedDateString");
    }

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
                      fontSize: 18.0,

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
                        if (DateFormat('EEEE').format(selectedDate) ==
                            "Monday") {
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return slotbox(monlist[index]);
                                  })
                              : Center(
                                  child: Text("Not available on this day", // DateFormat('EEEE').format(date)
                    style: GoogleFonts.museoModerno(
                      fontSize: 18.0,

                      color: Color(0xff6B779A),
                      // fontWeight: FontWeight.bold,
                    ),));
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return slotbox(tuelist[index]);
                                  })
                              : Center(
                                  child: Text("Not available on this day", // DateFormat('EEEE').format(date)
                    style: GoogleFonts.museoModerno(
                      fontSize: 18.0,

                      color: Color(0xff6B779A),
                      // fontWeight: FontWeight.bold,
                    )));
                        } else if (DateFormat('EEEE').format(selectedDate) ==
                            "Wednesday") {
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return slotbox(wedlist[index]);
                                  })
                              : Center(
                                  child: Text("Not available on this day", // DateFormat('EEEE').format(date)
                    style: GoogleFonts.museoModerno(
                      fontSize: 18.0,

                      color: Color(0xff6B779A),
                      // fontWeight: FontWeight.bold,
                    )));
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return slotbox(thulist[index]);
                                  })
                              : Center(
                                  child: Text("Not available on this day", // DateFormat('EEEE').format(date)
                    style: GoogleFonts.museoModerno(
                      fontSize: 18.0,

                      color: Color(0xff6B779A),
                      // fontWeight: FontWeight.bold,
                    )));
                        } else if (DateFormat('EEEE').format(selectedDate) ==
                            "Friday") {
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return slotbox(frilist[index]);
                                  })
                              : Center(
                                  child: Text("Not available on this day", // DateFormat('EEEE').format(date)
                    style: GoogleFonts.museoModerno(
                      fontSize: 18.0,

                      color: Color(0xff6B779A),
                      // fontWeight: FontWeight.bold,
                    )));
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return slotbox(satlist[index]);
                                  })
                              : Center(
                                  child: Text("Not available on this day", // DateFormat('EEEE').format(date)
                    style: GoogleFonts.museoModerno(
                      fontSize: 18.0,

                      color: Color(0xff6B779A),
                      // fontWeight: FontWeight.bold,
                    )));
                        }
                        else if (DateFormat('EEEE').format(selectedDate) ==
                            "Sunday") {
                          return sunlist.isNotEmpty
                              ? GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 90,
                                          childAspectRatio: 3 / 2,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 15),
                                  itemCount: sunlist.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return slotbox(sunlist[index]);
                                  })
                              : Center(
                                  child: Text("Not available on this day", // DateFormat('EEEE').format(date)
                    style: GoogleFonts.museoModerno(
                      fontSize: 18.0,

                      color: Color(0xff6B779A),
                      // fontWeight: FontWeight.bold,
                    )));
                        } else {
                          return Center(
                              child: Text("Not available", // DateFormat('EEEE').format(date)
                    style: GoogleFonts.museoModerno(
                      fontSize: 18.0,

                      color: Color(0xff6B779A),
                      // fontWeight: FontWeight.bold,
                    )));
                        }
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text("Unable to fetch slots", // DateFormat('EEEE').format(date)
                    style: GoogleFonts.museoModerno(
                      fontSize: 18.0,

                      color: Color(0xff6B779A),
                      // fontWeight: FontWeight.bold,
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
        ));
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
        String day=DateFormat('EEEE').format(selectedDate);

        print("Slot Index $slot_index  ${entry.key} ${entry.value}");
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmAppointment(
                      name: widget.name,
                        email: widget.email,
                        phoneNumber: widget.phoneNumber,
                        drName: widget.drName,
                        bookingTime: entry.key,
                        ID: widget.ID,
                        drId: widget.drid,
                        fee: widget.fee,
                        slot: entry.key,
                        slectedDate: selectedDate,
                        day: day,
                        slotIndex: slot_index.toString(),
                        drEmail: widget.drEmail,
                        description: widget.description,
                        isInstant: widget.isInstant,
                        isInstantList: widget.instantList,
                        order_id: widget.order_id,
                    )));
      },
      child: Card(
        elevation: 5,
        color: white,
        child: Center(
          child: Text(
            "$txt",
            textAlign: TextAlign.center, // DateFormat('EEEE').format(date)
                    style: GoogleFonts.museoModerno(
                      fontSize: 14.0,

                      color: Color(0xff6B779A),
                      // fontWeight: FontWeight.bold,
                    ),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      ),
    );
  }
}
