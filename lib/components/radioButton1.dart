import 'package:patientapp/instant_consultation/instantBookingForm.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  Gender _gender;
  CustomRadio(this._gender);

  @override
  Widget build(BuildContext context) {
    return Container(
            width: (MediaQuery.of(context).size.width - 60)/3,
            decoration: BoxDecoration(
                color: _gender.isSelected ? Color(0xff3E64FF) : Colors.grey[200],
                borderRadius: BorderRadius.circular(15)),
            alignment: Alignment.center,
            //margin: new EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(_gender.name,
                  style: TextStyle(color: _gender.isSelected ? Colors.white : Colors.black),
                )
              ],
            ),

        );
  }
}

