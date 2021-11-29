import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'models.dart';

class AllApi {
  Future<UserModel> getUser(String email) async {
    var getUserUrl =
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugGetUser";

    var response = await http.get(Uri.parse("$getUserUrl?email=$email"));
    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      if (list != null) {
        var model = UserModel(
          address: '',
          allotedOffice: '',
          designation: '',
          leaves: '',
          manager: '',
          name: '',
          notificationToken: '',
          pass: '',
          phoneNumber: '',
          uid: '',
          uuid: '',
          allowCheckin: false,
          email: '',
          location: {},
        ).fromJson(list);
        return model;
      } else {
        return UserModel(
          address: '',
          allotedOffice: '',
          designation: '',
          leaves: '',
          manager: '',
          name: '',
          notificationToken: '',
          pass: '',
          phoneNumber: '',
          uid: '',
          uuid: '',
          allowCheckin: false,
          email: '',
          location: {},
        );
      }
    } else {
      return UserModel(
        address: '',
        allotedOffice: '',
        designation: '',
        leaves: '',
        manager: '',
        name: '',
        notificationToken: '',
        pass: '',
        phoneNumber: '',
        uid: '',
        uuid: '',
        allowCheckin: false,
        email: '',
        location: {},
      );
    }
  }

  Future<void> postCheckIn(
      {String checkInTime,
      String checkOutTime,
      String phoneNumber,
      String date}) async {
    var postCheckInUrl = Uri.parse(
        'https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugPostCheckIn');

    var response = await http.post(postCheckInUrl, body: {
      'checkin': checkInTime,
      'checkout': checkOutTime,
      'refid': phoneNumber,
      'date': date,
    });
    if (response.statusCode == 200) {
      return;
    } else {
      Fluttertoast.showToast(msg: response.body);
    }
  }

  Future<dynamic> getCheckIn({String phoneNumber, String date}) async {
    var postCheckInUrl = Uri.parse(
        'https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugGetCheckIn?date=$date&refid=$phoneNumber');

    var response = await http.get(postCheckInUrl);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      Fluttertoast.showToast(msg: response.body);
    }
  }

  Future<dynamic> getVicinity(
      {String phoneNumber, double latitude, double longitude}) async {
    var getVicinityUrl = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugGetOfficeLocation?lat=$latitude&long=$longitude&refid=$phoneNumber");

    var response = await http.get(getVicinityUrl);
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      return;
    }
  }

  Future<void> postCheckInRequest({String phoneNumber, String date}) async {
    var postCheckInRequestUrl = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugPostCheckInRequest");

    var response = await http.post(postCheckInRequestUrl, body: {
      'refid': phoneNumber,
      'date': date,
      'status': 'pending',
    });
    if (response.statusCode == 200) {
      return;
    } else {
      Fluttertoast.showToast(msg: response.body);
      return;
    }
  }
}
