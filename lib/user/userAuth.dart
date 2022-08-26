import 'package:basic_utils/basic_utils.dart';
import 'package:patientapp/Colors/color.dart';
import 'package:patientapp/authentication/otpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  // final String? role;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  // GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  TextEditingController _controller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  // String? phoneNo;
  String phoneNo="+91";
  // String _phone="";
  // var _phone="";
  String? idToken;
  String? verificationId;
  bool _validatePhone = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    const double kDesignWidth = 375;
    const double kDesignHeight = 812;
    double _widthScale = MediaQuery.of(context).size.width / kDesignWidth;
    double _heightScale = MediaQuery.of(context).size.height / kDesignHeight;

    // GoogleSignInAccount? user = _googleSignIn.currentUser;

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back_ios_rounded,
        //     color: col2,
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   color: white,
        // ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
          child: Row(
            children: [
              Text("First",
                  style: GoogleFonts.poppins(
                      color: col2, fontSize: 24, fontWeight: FontWeight.w600)),
              const SizedBox(width: 4),
              Text(
                "Dok",
                style: GoogleFonts.poppins(
                    color: col1, fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: white,
          child: Column(
            children: [
              SizedBox(
                // height: _heightScale * 45,
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _widthScale * 68.0),
                child: Image.asset("assets/firstdok1.PNG"),
              ),
              SizedBox(
                // height: _heightScale * 29.57,
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _widthScale * 30.0),
                child: TextField(
                  onChanged: (value) {
                    this.phoneNo = value;
                    print("value is: ${value}");
                    // _phone = phoneNo!;
                    print("phone number is: ${phoneNo}");
                  },
                  controller: _controller,
                  keyboardType: TextInputType.phone,
                  autofocus: false,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: _widthScale * 15.0, color: black),
                  decoration: InputDecoration(
                    errorText: _validatePhone
                                  ? "Phone number must 10 digit number"
                                  : null,
                    errorStyle: TextStyle(fontSize: 10.5),
                    filled: true,
                    fillColor: col6,
                    hintText: "Phone Number",
                    hintStyle: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(fontSize: _widthScale * 12, color: col5)),
                    contentPadding: EdgeInsets.only(
                        left: _widthScale * 14.0,
                        bottom: _heightScale * 8.0,
                        top: _heightScale * 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: col1),
                      borderRadius: BorderRadius.circular(_widthScale * 6),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: textFieldColor),
                      borderRadius: BorderRadius.circular(_widthScale * 6),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _heightScale * 22,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: _widthScale * 30),
                width: _widthScale * 315,
                height: _heightScale * 54,
                child: ElevatedButton(
                    onPressed: ()async {
                      String ans=StringUtils.addCharAtPosition(phoneNo, "+91", 0);
                      print("phone is new : ${ans}");
                      print("phone is: ${phoneNo}");
                      setState(() {
                        if ( phoneNo.length<10 ||
                          phoneNo.isEmpty ||
                           phoneNo.length>10) {
                        _validatePhone = true;
                      } 
                      });
                      // final signature=await SmsAutoFill().getAppSignature;
                      // print("App Signature: ${signature}");
                      if(_validatePhone)
                      {
                        
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage(
                                      
                                    )));
                       
                      }
                      else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OTPScreenPage(
                                      phoneNo: ans,
                                    )));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: col2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(_widthScale * 10.0),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: _widthScale * 18,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
              SizedBox(
                height: _heightScale * 11,
              ),
              
              SizedBox(height: _heightScale * 36),
              
            ],
          ),
        ),
      ),
    );
  }
}
