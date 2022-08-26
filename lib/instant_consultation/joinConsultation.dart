import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class JoinConsultation extends StatefulWidget {
  String problemDesc, meetURL;
  JoinConsultation({Key? key, required this.problemDesc, required this.meetURL}) : super(key: key);

  @override
  State<JoinConsultation> createState() => _JoinConsultationState();
}

class _JoinConsultationState extends State<JoinConsultation> {
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
          "Consultation Detail",
          style: GoogleFonts.museoModerno(fontSize: 18.0, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Submitted Issue',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15,),
            Container(
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                  style: BorderStyle.solid,
                ),
              ),
              child: Text(
                "${widget.problemDesc}", style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            SizedBox(height: 30,),
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
                    "Join Meet",
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () async {
                    if (!await launch(widget.meetURL)) throw 'Could not launch ${widget.meetURL}';
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
