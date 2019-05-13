
import 'dart:convert';
import 'package:http/http.dart' as http;

class Person{
  int WorkerID;
  String LastName;
  String FirstName;
  int NfcCode;
  int IsCurrentlyWorking;

  Person({
    this.WorkerID,
    this.LastName,
    this.FirstName,
    this.NfcCode,
    this.IsCurrentlyWorking,
});

  factory Person.fromJson(Map<String, dynamic> json){
    return Person(
        WorkerID: json["WorkerID"],
        FirstName: json["FirstName"],
        LastName: json["LastName"],
        NfcCode: json["NfcCode"],
        IsCurrentlyWorking: json["IsCurrentlyWorking"]
    );
  }
}

class Service{
  Person scannedPerson = new Person(
      WorkerID: 0,
      FirstName: "_user_not_found",
      LastName: "",
      NfcCode: 0,
      IsCurrentlyWorking: 0
  );
  //perhaps move to another json file
  static String debugHttpAddressBeginning = "http://10.0.2.2:3000/";
  static String serviceHttpAddressBeginning = "http://localhost:3000/";
  
  Future<String> findUserByNfcCode(int NfcCode) async{
    var response = await http.get(
      Uri.encodeFull(serviceHttpAddressBeginning + "FindWorkerByNfcCode/?NfcCode=$NfcCode"),
      headers: {
        "accept": "application/json"
      }
    );
    List<dynamic> data = jsonDecode(response.body);
    if(data.length==0){
      scannedPerson = new Person(
          WorkerID: 0,
          FirstName: "_user_not_found",
          LastName: "",
          NfcCode: 0,
          IsCurrentlyWorking: 0
      );
      return "Fail";
    }
    Map<String, dynamic> a = data[0];
    scannedPerson = new Person.fromJson(a);
    return "Success!";
  }

  Future<String> addUser(String FirstName, String LastName, String DateAndTime) async {
    await http.post(
        Uri.encodeFull(serviceHttpAddressBeginning + "WorkerScanned/?FirstName=\"$FirstName\"&LastName=\"$LastName\"&DateAndTime=\'$DateAndTime\'"),
        headers: {
          "accept": "application/json"
        }
    );
    return "Success!";
  }

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(serviceHttpAddressBeginning + "GetAllWorkers/"),
        headers: {
          "accept": "application/json"
        }
    );
    var data = jsonDecode(response.body);
    print(data);
    return "Success!";
  }
}

