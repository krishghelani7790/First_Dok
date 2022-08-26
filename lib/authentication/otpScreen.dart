import 'package:patientapp/Colors/color.dart';
import 'package:patientapp/user/userDash.dart';
import 'package:patientapp/user/userInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';

bool data1 = false;

class OTPScreenPage extends StatefulWidget {
  const OTPScreenPage({Key? key, required this.phoneNo}) : super(key: key);
  final String phoneNo;
  // final String smsCode;
  @override
  _OTPScreenPageState createState() => _OTPScreenPageState();
}

class _OTPScreenPageState extends State<OTPScreenPage> {
  late var userName = "";
  late var userEmail = "";
  late var userGender = "";
  late var userDOB = "";
  late var userCity = "";
  late var userPincode = "";
  late var userPhone = "";
  late var userHeight = "";
  late var userWeight = "";
  late var userBloodGroup = "";
  late String id1 = "";
  late var userAge = "";
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? smsCode;
  String? verificationId;
  var resend;

  Timer? _timer;
  int start = 59;

  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _pinPutController = TextEditingController();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: col3,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: col5,
    ),
  );
  String _comingSms = 'Unknown';

    Future<void> initSmsListener() async {

    String comingSms;
    try {
      comingSms = (await AltSmsAutofill().listenForSms)!;
    // ignore: nullable_type_in_catch_clause
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    setState(() {
      _comingSms = comingSms;
      print("====>Message: ${_comingSms}");
      print("${_comingSms[32]}");
      _pinPutController.text = _comingSms[0] + _comingSms[1] + _comingSms[2] + _comingSms[3]
          + _comingSms[4] + _comingSms[5]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
    });
  }

   getUserID() async {
    print("Phone is ${widget.phoneNo}");
    print("Inside Info");
    var client = http.Client();
    var user_Info = await client.get(Uri.parse(
        'https://doctor2-kylo.herokuapp.com/patient/info/${widget.phoneNo.substring(3)}'));
    print("User Info is: ${user_Info.body}");
    if (user_Info.statusCode == 200) {
      final String responseBody = user_Info.body;
      // print('Decoded user info is: ${json.decode(responseBody)}');
      var _user = json.decode(responseBody);
      print("User Info is123456: ${_user}");
      if (_user['data'] != null) {
        data1 = true;
        userName = _user['data']['name'];
        userEmail = _user['data']['email'];
        userGender = _user['data']['gender'];
        userDOB = _user['data']['dob'];
        userCity = _user['data']['city'];
        userPincode = _user['data']['pincode'].toString();
        userPhone = _user['data']['phone_number'].toString();
        userHeight = _user['data']['height'].toString();
        userWeight = _user['data']['weight'].toString();
        userBloodGroup = _user['data']['blood_group'];
        id1 = _user['data']['_id'];
      } else if (_user['data'] == null) {
        data1 = false;
      }
      // String data = _user['data'];
      // Data=data;
      print("data is ${data1}");
      // return data1;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getUserID();
    startTimer();
    _verifyPhone(context);
    initSmsListener();
    _pinPutController = TextEditingController();
    
    
  }

   @override
  void dispose() {
    // _pinPutController.dispose();
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }


   void startTimer() {
    const Sec = Duration(seconds: 1);
    _timer = Timer.periodic(
        Sec,
        (Timer timer) => setState(() {
              if (start == 0) {
                _timer?.cancel();
              } else {
                start = start - 1;
              }
            }));
  }


  @override
  Widget build(BuildContext context) {
    const double kDesignWidth = 375;
    const double kDesignHeight = 812;
    double _widthScale = MediaQuery.of(context).size.width / kDesignWidth;
    double _heightScale = MediaQuery.of(context).size.height / kDesignHeight;
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: white.withOpacity(0.4),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Image.asset("assets/img_1.png"),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: _widthScale * 76.0),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("First",
                  style: TextStyle(
                    color: col2,
                    fontFamily: "Poppins",
                    fontSize: _widthScale * 20,
                  )),
              SizedBox(
                width: _widthScale * 2,
              ),
              Text(
                "Dok",
                style: GoogleFonts.poppins(
                  color: col1,
                  // fontFamily: "Poppins",
                  fontSize: _widthScale * 20,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _heightScale * 36,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _widthScale * 84.0),
              child: Image.asset(
                "assets/img_1.png",
                height: 200,
                width: 208,
              ),
            ),
            SizedBox(
              height: _heightScale * 29.57,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Please enter the Code sent on your phone number",
                style:
                    GoogleFonts.poppins(color: col3, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: _heightScale * 37,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: PinCodeTextField(
                controller: _pinPutController,
                autoDismissKeyboard: true,
                cursorColor: col5,
                keyboardType: TextInputType.number,
                // keyboardType:
                //     const TextInputType.numberWithOptions(decimal: false),
                appContext: context,
                length: 6,
                obscureText: false,
                //obscuringCharacter: '*',
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: col5,
                  inactiveColor: col5,
                  selectedColor: col5,
                ),
                animationDuration: const Duration(milliseconds: 300),
                onCompleted: (v) async {
                  print(_pinPutController);
                },
                onChanged: (value) {
                  print(value);
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              height: _heightScale * 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Resend OTP",
                  style: GoogleFonts.poppins(
                    color: col5,
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  width: _widthScale * 20,
                ),
                Text(
                  "00:${start}",
                  style: GoogleFonts.poppins(
                    color: col2,
                    fontSize: 13,
                  ),
                )
              ],
            ),
            SizedBox(
              height: _heightScale * 37,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: _widthScale * 30),
              width: _widthScale * 315,
              height: _heightScale * 54,
              child: ElevatedButton(
                  onPressed: () {
                    _SignupWithMobile();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => UserHome()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: col2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_widthScale * 10.0),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: _widthScale * 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            SizedBox(
              height: _heightScale * 25,
            ),
          ],
        ),
      ),
    );
  }

  _SignupWithMobile() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    smsCode = _pinPutController.text.trim();

    var _credential = PhoneAuthProvider.credential(
        verificationId: verificationId!, smsCode: smsCode!);
    auth.signInWithCredential(_credential).then((UserCredential result) async {
      final User? user1 = FirebaseAuth.instance.currentUser;
      final uid = user1?.uid;
      print("User id is from 1: ${uid}");
      if (data1 == true) {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserDashboard(
                      name: userName,
                      phone: userPhone,
                      // age: userAge,
                      gender: userGender,
                      ID: id1,
                      dob: userDOB,
                    )));
      } else if (data1 == false) {
        await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserInfor(phone: widget.phoneNo)));
      }
      // await Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) =>UserInfor(phone: widget.phoneNo)));
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _verifyPhone(BuildContext context) async {
    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeAutoRetrievalTimeout autoRetrive = (String verId) {
      this.verificationId = verId;
    };
    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeSent SMSCodeSent = (String verId, [int? forceCodeResend]) {
      this.verificationId = verId;
      this.resend = forceCodeResend;
      Fluttertoast.showToast(
          msg:
              "Code has been sent to the registered mobile number!!!", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.CENTER, // location
          timeInSecForIosWeb: 1 // duration
          );
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential authCredential) {
      Fluttertoast.showToast(msg: "Mobile varifivation is successful..");
      final User? user1 = FirebaseAuth.instance.currentUser;
      final uid = user1?.uid;
      print("User id is: ${uid}");
      // print("User profile url is: ${user1?.}")
      print("Phone verification is success");
    };
    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      Fluttertoast.showToast(msg: "Mobile verification Failed..");
      print("${exception.message}");
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNo,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: SMSCodeSent,
        timeout: const Duration(seconds: 10),
        forceResendingToken: resend,
        codeAutoRetrievalTimeout: autoRetrive);
  }

//   void resendVerificationCode(String phoneNumber,
//                                     PhoneAuthProvider.ForceResendingToken token) {
//     PhoneAuthProvider.getInstance().verifyPhoneNumber(
//             phoneNumber,        // Phone number to verify
//             60,                 // Timeout duration
//             TimeUnit.SECONDS,   // Unit of timeout
//             this,               // Activity (for callback binding)
//             mCallbacks,         // OnVerificationStateChangedCallbacks
//             token);             // ForceResendingToken from callbacks
// }
}
