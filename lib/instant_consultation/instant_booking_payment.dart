import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:patientapp/Colors/color.dart';
import 'package:patientapp/instant_consultation/joinConsultation.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class InstantBookingPayment extends StatefulWidget {
  final String name;
  final String phone, email, age;
  final String? description, orderId, patientId;

  InstantBookingPayment(
      {Key? key,
      required this.name,
      required this.phone,
      required this.email,
      required this.age,
      required this.description,
      required this.patientId,
      required this.orderId})
      : super(key: key);

  @override
  State<InstantBookingPayment> createState() => _InstantBookingPaymentState();
}

class _InstantBookingPaymentState extends State<InstantBookingPayment> {
  bool _isOnline = false;
  bool _isOffline = false;
  Color _colorContainer = Colors.white;
  String fee = '99';

  static const platform = const MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;

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
      'amount': fee * 100,
      'name': widget.name,
      // 'order_id': "order_9A33XWu170gUtm",
      'description': 'Appointment Booking',
      'order_id': widget.orderId,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': widget.phone, 'email': widget.email},
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
        msg: "Payment Done Successfully...",
        toastLength: Toast.LENGTH_SHORT);

    var orderID = response.orderId;
    var paymentID = response.paymentId;
    var signatureID = response.signature;

    DateTime today = DateTime.now();
    // String amount = fee;

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
      print('object $paymentID');
      print("Payment is successful....");

      String bookInstant = 'http://doctor2-kylo.herokuapp.com/consult/instant';
      var bodyInstant = {
        'patient_id': widget.patientId,
        'payment_amount': fee,
        'rpay_payment_id': paymentID,
        'attendees': [
          {'email': widget.email}
        ],
        'problem_desc': widget.description,
      };
      var body3=json.encode(bodyInstant);
      print("Body is: ${body3}");
      final responseInstant = await http.post(
        Uri.parse(bookInstant),
        body: body3,
        headers: {"Content-Type": "application/json"}
      );

      print(
          'inside instant ${responseInstant.statusCode} ${responseInstant.body}');

      if (responseInstant.statusCode == 200) {
        var user = jsonDecode(responseInstant.body);
        String meet_url = user['data']['instant']['meet_url'];
        String problem_desc = user['data']['instant']['problem_desc'];
        Fluttertoast.showToast( 
        msg: "Instant Consultation Booked Successfully...",
        toastLength: Toast.LENGTH_SHORT);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => JoinConsultation(problemDesc: problem_desc, meetURL: meet_url)));
      }
      else{
        Fluttertoast.showToast( 
        msg: "Instant Consultation Booking Failed...",
        toastLength: Toast.LENGTH_SHORT);
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
          "Payment",
          style: GoogleFonts.museoModerno(fontSize: 18.0, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: white,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                "Make Your Payment",
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
                onTap: () {},
                child: Card(
                  // elevation: 2,
                  color: _colorContainer,
                  child: ListTile(
                    title: Center(
                      child: Text(
                        "Pay ₹ ${fee}  Online",
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
