import 'package:http/http.dart' as http;

class Api_Manage
{
   void getPatients() async{
      var client=http.Client();
      var patient_info=await client.get(Uri.parse('https://doctor2-kylo.herokuapp.com/patient/info'));
      var patient_post= client.post(Uri.parse('https://doctor2-kylo.herokuapp.com/patient/info'));
      var doctor_info=await client.get(Uri.parse('https://doctor2-kylo.herokuapp.com/doctor/info/'));
      var rating=await client.get(Uri.parse('https://doctor2-kylo.herokuapp.com/doctor/rating'));
      var payment=await client.get(Uri.parse('https://doctor2-kylo.herokuapp.com/consult/payment'));
      var medical_area=await client.get(Uri.parse('https://doctor2-kylo.herokuapp.com/medical_area'));
      var verify=await client.get(Uri.parse('https://doctor2-kylo.herokuapp.com/doctor/verification'));
      var consultation=await client.get(Uri.parse('https://doctor2-kylo.herokuapp.com/doctor/consult'));

    }
}