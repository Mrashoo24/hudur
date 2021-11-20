import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'models.dart';

class AllApi {
  Future<UserModel> getUser(String email) async {
    var getUserUrl =
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/getuser";

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
                uuid: '')
            .fromJson(list);
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
            uuid: '');
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
          uuid: '');
    }
  }

  Future<void> postCheckIn(
      { String checkInTime,
       String checkOutTime,
       String phoneNumber,
       String date}) async {
    var postCheckInUrl = Uri.parse(
        'https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/postCheckin');

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

  Future<void> getCheckIn(
      {String phoneNumber,
        String date}) async {
    var postCheckInUrl = Uri.parse(
        'https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/getcheckin?date=$date&refid=$phoneNumber');

    var response = await http.get(postCheckInUrl);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      Fluttertoast.showToast(msg: response.body);
    }
  }

}
