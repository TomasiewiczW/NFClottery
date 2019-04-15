
import 'dart:convert';
import 'package:http/http.dart' as http;

class Person{
  int PersonID;
  String LastName;
  String FirstName;
  String NfcCode;

  Person({
    this.PersonID,
    this.LastName,
    this.FirstName,
    this.NfcCode,
});

  factory Person.fromJson(Map<String, dynamic> json){
    return Person(
      PersonID: json["PersonID"],
      LastName: json["LastName"],
      FirstName: json["FirstName"],
      NfcCode: json["NfcCode"]);
  }

}

class Service{

  Person scannedPerson = new Person();

  //String debugHttpAddressBeginning = "http://10.0.2.2:3000/";
  static String debugHttpAddressBeginning = "http://10.0.2.2:3000/";
  //String serviceHttpAddressBeginning = "http://localhost:3000/";
  static String serviceHttpAddressBeginning = debugHttpAddressBeginning;
  
  Future<String> findUserByNfcCode(String NfcCode) async{
    var response = await http.get(
      Uri.encodeFull(debugHttpAddressBeginning + "FindWorkerByNFCCode/?NfcCode=$NfcCode"),
      headers: {
        "accept": "application/json"
      }
    );
    List<dynamic> data = jsonDecode(response.body);
    if(data.length==0){
      return "Fail";
    }
    Map<String, dynamic> a = data[0];
    scannedPerson = new Person.fromJson(a);
    return "Success!";
  }

  Future<String> addUser(String FirstName, String LastName, String DateAndTime) async {
    var response = await http.post(
        Uri.encodeFull("http://10.0.2.2:3000/WorkerScanned/?PersonId=1&LastName=\"$LastName\"&FirstName=\"$FirstName\"&DateAndTime=\'$DateAndTime\'"),
        headers: {
          "accept": "application/json"
        }
    );

    return "Success!";
  }

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://10.0.2.2:3000/GetAllWorkers/"),
        headers: {
          "accept": "application/json"
        }
    );
    var data = jsonDecode(response.body);
    print(data);

    return "Success!";
  }
}

