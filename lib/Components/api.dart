import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

class AllApi {
  Future<UserModel> getUser(String phone) async {
    var getUserUrl =
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/getuser";

    var response = await http.get(Uri.parse("$getUserUrl?phone=$phone"));
    var list = json.decode(response.body);
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
  }
}
