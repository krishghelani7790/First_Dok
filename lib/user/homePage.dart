// import 'package:doc_patient/user/userInfo.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';


// final List<String> imgList = [
//   'assets/img_6.png','assets/img_7.png','assets/img_8.png','assets/img_9.png',
// ];
// class UserHome extends StatefulWidget {
//     String phone;
//    UserHome({Key? key, required this.phone}) : super(key: key);

//   @override
//   _UserHomeState createState() => _UserHomeState();
// }

// class _UserHomeState extends State<UserHome> {

//  List<Widget> fun(BuildContext context){

//   return  imgList.map((item) => Center(

//     child: Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Stack(
//         children: [
//           Text(imgList.indexOf(item).toString()),
//           Align(
//             alignment: Alignment.center,
//             child: Image.asset(item),
//           ),
//           imgList.indexOf(item)==3?
//           Align(alignment: Alignment.bottomRight,child: ElevatedButton.icon(onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>UserInfor(phone: widget.phone,)));

//           }, icon: Icon(Icons.navigate_next), label: Text("Next"))):SizedBox()
//         ],
//       ),
//     ),
//   ),

//   ).toList();
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      // appBar: AppBar(backgroundColor: Colors.white,elevation: 0,),
//       body: Container(
//         color: Colors.white,
//       child: Center(
//         child: CarouselSlider(
//     options: CarouselOptions(
//     height: MediaQuery.of(context).size.height,
//     enableInfiniteScroll: false,
//     ),
//     items: fun(context),
//     ),
//       )),

//     );
//   }
// }
