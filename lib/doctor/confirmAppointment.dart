// ignore_for_file: file_names, unused_field, prefer_final_fields

import 'package:patientapp/Colors/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:patientapp/screens/myBookings.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// String? order_id;
var amount = 400;

bool isSuccess=false;

class ConfirmAppointment extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final String drName;
  final bookingTime;
  final String ID;
  final String fee;
  final String drId;
  final String slot;
  final String description;
  DateTime slectedDate;
  String day;
  String slotIndex;
  final String drEmail;
  final String isInstant;
  List? isInstantList=[];
  final String order_id;
  // Map<String,dynamic>vaiables={};
  ConfirmAppointment({
    Key? key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.drName,
    required this.bookingTime,
    required this.ID,
    required this.drId,
    required this.fee,
    required this.slot,
    required this.slectedDate,
    required this.day,
    required this.slotIndex,
    required this.drEmail,
    required this.description,
    required this.isInstant,
    required this.isInstantList,
    required this.order_id,
    // required this.vaiables,
  }) : super(key: key);

  @override
  _ConfirmAppointmentState createState() => _ConfirmAppointmentState();
}

class _ConfirmAppointmentState extends State<ConfirmAppointment> {
  bool isSwitched = false;
  bool _isOnline = false;
  bool _isOffline = false;
  Color _colorContainer = Colors.white;
  Map<String, int> selected = {};
  static const platform = const MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;

  // void getData() async {
  //   http.Response response = await http.get(Uri.parse(
  //       "http://doctor2-kylo.herokuapp.com/consult/payment?amount=${widget.fee}"));
  //   if (response.statusCode == 200) {
  //     print("Response Body is: ${response.body}");
  //     var orderCreated = json.decode(response.body);
  //     order_id = orderCreated['data']['id'];
  //     print("Order is is: $order_id");
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // getData();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_NvXh4eCQDyCstP',
      'amount': widget.fee*100,
      'name': widget.name,
      // 'order_id': "order_9A33XWu170gUtm",
      'description': 'Appointment Booking',
      'order_id': widget.order_id,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': widget.phoneNumber, 'email': widget.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
   

    var orderID = response.orderId;
    var paymentID = response.paymentId;
    var signatureID = response.signature;

    

    DateTime today = DateTime.now();
    String amount = widget.fee;
    
    String url =
        'http://doctor2-kylo.herokuapp.com/consult/payment/is-verified';
    var body1 = {
      'razorpay_payment_id': paymentID,
      'razorpay_order_id': orderID,
      'razorpay_signature': signatureID,
    };
    // var body2=json.encode(body1);
    print("Body is: ${body1}");
    final response1 = await http.post(
      Uri.parse(url),
      body: body1,
      // headers: {"Content-Type": "application/json"}
    );
   
    var paymentBody = json.decode(response1.body);
    print("pay : ${paymentBody}");
    if (response1.statusCode == 200) {
      
      print("Payment is successful....");
      if (paymentBody['data']['is_verified'] == true) {
        
        String url = 'https://doctor2-kylo.herokuapp.com/consult/new';

        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final String formatted = formatter.format(widget.slectedDate);
       
        String Day = widget.day.substring(0, 3);
        
        String date =
            DateFormat('yyyy-MM-dd').format(widget.slectedDate).toString();
        String dateDayFormat =
            formatted + "T" + widget.bookingTime + ":00";

            print('date12 ${formatted} ${date} ${widget.bookingTime}');
        
        var body3 = jsonEncode({
          "doctor_id": widget.drId,
          "patient_id": widget.ID,
          "payment_id": paymentID,
          "curr_indexes": widget.isInstant=="yes"?widget.isInstantList: [-1,-1],
          "payment_amount": widget.fee,
          "slot_info": {
            "index": widget.isInstant=="yes"? "-1": widget.slotIndex,
            "day": Day,
            "date": "${date}T${widget.bookingTime}:00",
          },
          "doctor_details": {
            "name": widget.drName,
          },
          "patient_name": widget.name,
          "patient_email": widget.email,
          "attendees": [
            {
              "email": widget.drEmail,
            },
            {
              "email": widget.email,
            }
          ],
          "patient_phone_number": widget.phoneNumber,
          "description": widget.description,
          // 'start_time': dateDayFormat,
        });
        print("Body 123: $body3");
        // var newBody = jsonEncode(body3);
        // print("Body 456: ${newBody}");

        print("Send Request");
        final response45 = await http.Client().post(
          Uri.parse(url),
          body: body3,
          headers: {"Content-Type": "application/json"},
        );
        print("new Consult response is: ${response45.body}");
        if (response45.statusCode == 201 || response45.statusCode == 200) {
          print("OK 2 ${response45.body}");
          isSuccess=true;
          var parsed = jsonDecode(response45.body);
          var id = parsed['data'][0]['patient_id'];
          print('iidd $id');
          Fluttertoast.showToast( 
        msg: "Consultation Booked Successfully...",
        toastLength: Toast.LENGTH_SHORT);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyBookings(Id: id)));
        
        } else {
          print("Error ${response45.statusCode} ${response45.body}");
          Fluttertoast.showToast( 
        msg: "Consultation Booking Failed...",
        toastLength: Toast.LENGTH_SHORT);
        }
        // return response45.statusCode;

      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.01;
    double _height = MediaQuery.of(context).size.height * 0.01;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Payment Options",
          style: GoogleFonts.museoModerno(fontSize: 16.0, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: white,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                "Choose a Payment option for Registration",
                style: TextStyle(
                    fontFamily: "Museo",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Container(
              // color: _colorContainer,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: InkWell(
                onTap: () {
                  
                },
                child: Card(
                  // elevation: 2,
                  color: _colorContainer,
                  child: ListTile(
                    title: Center(
                      child: Text(
                        "Pay ₹ ${widget.fee}  Online",
                        style: TextStyle(
                            fontFamily: "Museo",
                            color: _isOnline ? Colors.white : Colors.blue,
                            // fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Text(
                "By booking an appointment you agree to all the terms and conditions",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Museo",
                    color: hinttextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            GestureDetector(
              onTap: () {
                
                // print("DrName is: ${widget.drName}");
                // getData();
                // setState(() {
                //   openCheckout();
                // });
                openCheckout();
                // openCheckout();
              },
              child: Container(
                height: _height * 8,
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 2,
                  color: Colors.blue.shade600,
                  child: Center(
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                          fontFamily: "Museo",
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ]),
        ),
      ),
    );
  }
}
