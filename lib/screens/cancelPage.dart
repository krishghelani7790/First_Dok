import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

class Cancel extends StatefulWidget {
  final String conculId;
  Cancel({Key? key, required this.conculId}) : super(key: key);

  @override
  _CancelState createState() => _CancelState();
}

class _CancelState extends State<Cancel> {
  List<String>reasons=["Chane in Plane","Personal Problem","Time Mismatch","Looking for other Doctor","Got better Deal"];
  
  Future<String?> CancelEvent(String reason) async {
    print("Consultation id in final event is : ${widget.conculId}");
       String url ='https://doctor2-kylo.herokuapp.com/consult/cancel';
       var body={
         'consultation_id':widget.conculId,
         'reason':reason,
       };

       print("Cancel body is: ${body}");
       final response1 = await http.put(
      Uri.parse(url),
      body: body,
      // headers: {"Content-Type": "application/json"}
    );

    print("response body after cancel123: ${response1.body}");
    var res=json.decode(response1.body);
    if(response1.statusCode==200)
    {
      print("Event Successfully cancelled");
      Navigator.of(context).pop();
      return "Nilesh";
    }
    else
    {
      return null;
    }

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
          "Cancellation",
          style: GoogleFonts.museoModerno(fontSize: 18.0, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          color: Colors.white,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                    style: TextStyle(
                        fontFamily: "Museo",
                        color: Color(0xff6B779A),
                        // fontWeight: FontWeight.bold,
                        fontSize: 14)),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    CancelEvent(reasons[0]);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: IgnorePointer(
                      child: TextFormField(
                        // autofocus: true,
                        readOnly: true,

                        // focusNode: focusNode,
                        // keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "Change in Plan",
                          
                          hintStyle: TextStyle(
                             
                              fontFamily: "Museo",
                              color: Colors.grey.shade900,
                              // fontWeight: FontWeight.w700,
                              fontSize: 16),
                          isDense: true,
                          // suffixIcon: const Icon(Icons.arrow_right_rounded),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0099FF)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                   CancelEvent(reasons[1]);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: IgnorePointer(
                      child: TextFormField(
                        // autofocus: true,
                        readOnly: true,

                        // focusNode: focusNode,
                        // keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "Personal Problem",
                          
                          hintStyle: TextStyle(
                             
                              fontFamily: "Museo",
                              color: Colors.grey.shade900,
                              // fontWeight: FontWeight.w700,
                              fontSize: 16),
                          isDense: true,
                          // suffixIcon: const Icon(Icons.arrow_right_rounded),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0099FF)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                   CancelEvent(reasons[2]);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: IgnorePointer(
                      child: TextFormField(
                        // autofocus: true,
                        readOnly: true,

                        // focusNode: focusNode,
                        // keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "Time Mismatch",
                          
                          hintStyle: TextStyle(
                             
                              fontFamily: "Museo",
                              color: Colors.grey.shade900,
                              // fontWeight: FontWeight.w700,
                              fontSize: 16),
                          isDense: true,
                          // suffixIcon: const Icon(Icons.arrow_right_rounded),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0099FF)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                   CancelEvent(reasons[3]);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: IgnorePointer(
                      child: TextFormField(
                        // autofocus: true,
                        readOnly: true,

                        // focusNode: focusNode,
                        // keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "Looking for other Doctor",
                          
                          hintStyle: TextStyle(
                             
                              fontFamily: "Museo",
                              color: Colors.grey.shade900,
                              // fontWeight: FontWeight.w700,
                              fontSize: 16),
                          isDense: true,
                          // suffixIcon: const Icon(Icons.arrow_right_rounded),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0099FF)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                   CancelEvent(reasons[4]);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: IgnorePointer(
                      child: TextFormField(
                        // autofocus: true,
                        readOnly: true,

                        // focusNode: focusNode,
                        // keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "Got better Deal",
                          
                          hintStyle: TextStyle(
                             
                              fontFamily: "Museo",
                              color: Colors.grey.shade900,
                              // fontWeight: FontWeight.w700,
                              fontSize: 16),
                          isDense: true,
                          // suffixIcon: const Icon(Icons.arrow_right_rounded),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0099FF)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
