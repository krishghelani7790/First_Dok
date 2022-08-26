
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patientapp/instant_consultation/instant_booking_payment.dart';
import 'package:http/http.dart' as http;

import '../components/radioButton1.dart';

class Gender {
  String name;
  bool isSelected;

  Gender(this.name, this.isSelected);
}

List<Gender> genders = <Gender>[];

class InstantBookingForm extends StatefulWidget {
  final String name;
  final String phone, email;
  final String patientId;
  InstantBookingForm(
      {Key? key, required this.name, required this.phone, required this.email, required this.patientId})
      : super(key: key);

  @override
  State<InstantBookingForm> createState() => _InstantBookingFormState();
}

class _InstantBookingFormState extends State<InstantBookingForm> {
  TextEditingController _msg = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _name = TextEditingController();
  var fee = 99;
  var _gender = "";

  @override
  void initState() {
    // TODO: implement initState
    genders.add(new Gender("Male", false));
    genders.add(new Gender("Female", false));
    genders.add(new Gender("Others", false));
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
          "Instant Consultation",
          style: GoogleFonts.museoModerno(fontSize: 18.0, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Full Name",
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _name,
                keyboardType: TextInputType.text,
                // validator: (value){if (_search.text.length<10) {return "Please Enter Phone No";}
                //else return null;},
                style: TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                  // errorText: _validateName
                  //     ? "Name must have length greater than 1"
                  //     : null,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  hintText: "Name of Patient",
                  hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF0099FF)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Age", style: TextStyle(color: Colors.grey, fontSize: 14)),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _age,
                keyboardType: TextInputType.number,
                // validator: (value){if (_search.text.length<10) {return "Please Enter Phone No";}
                //else return null;},
                style: TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                  // errorText: _validateAge
                  //     ? "Age must be greater than 0 and number"
                  //     : null,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  hintText: "Age",
                  hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF0099FF)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // Text("Gender",
              //     style: TextStyle(
              //         fontFamily: "Museo Sans Cyrl 300 Regular",
              //         color: Color(0xff6B779A),
              //         fontSize: 13)),
              // Container(
              //   // color: Colors.black,
              //   height: 50,
              //   child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       shrinkWrap: true,
              //       itemCount: genders.length,
              //       itemBuilder: (context, index) {
              //         return InkWell(
              //           splashColor: Colors.pinkAccent,
              //           onTap: () {
              //             setState(() {
              //               genders
              //                   .forEach((gender) => gender.isSelected = false);
              //               genders[index].isSelected = true;
              //               if (index == 0) {
              //                 _gender = "Male";
              //               } else if (index == 1) {
              //                 _gender = "Female";
              //               } else if (index == 2) {
              //                 _gender = "Other";
              //               }
              //               print("Gender is: ${_gender}");
              //             });
              //           },
              //           child: Padding(
              //             padding: const EdgeInsets.all(4.0),
              //             child: CustomRadio(genders[index]),
              //           ),
              //         );
              //       }),
              // ),
              // Text(
              //   (() {
              //     if (_validateGender) {
              //       return "Please select gender";
              //     }

              //     return "";
              //   })(),
              //   style: TextStyle(color: Colors.red),
              // ),
              
              
              SizedBox(
                height: 5,
              ),
              Text(
                'Write Your Problem',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _msg,
                maxLines: 5,
                keyboardType: TextInputType.text,
                // validator: (value){if (_search.text.length<10) {return "Please Enter Phone No";}
                //else return null;},
                style: TextStyle(color: Colors.black, fontSize: 18),
                onChanged: (Value) {

                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  hintText: "Write here",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF0099FF)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('Your Quick Consultation Fee to Pay ',
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Fees',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    Text('₹ 99',
                        style: TextStyle(fontSize: 16, color: Colors.black))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
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
                      "Proceed",
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () async {
                      String? order_id = 'mk';
                      http.Response response = await http.get(Uri.parse(
                          "http://doctor2-kylo.herokuapp.com/consult/payment?amount=${fee}"));
                      if (response.statusCode == 200) {
                        print("Response Body is: ${response.body}");
                        var orderCreated = json.decode(response.body);
                        order_id = orderCreated['data']['id'];
                        print("Order is is: $order_id");
                      }
                      print(
                          'object ${widget.name} ${widget.phone} ${widget.email} ${widget.patientId} ${_msg.text}');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InstantBookingPayment(
                                  name: widget.name,
                                  phone: widget.phone,
                                  email: widget.email,
                                  age: _age.text,
                                  description: _msg.text,
                                  patientId: widget.patientId,
                                  orderId: order_id)));
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
