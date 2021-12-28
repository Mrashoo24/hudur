import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'models.dart';

class AllApi {
  Future<UserModel> getUser(String email) async {
    var getUserUrl =
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugGetUser";

    var response = await http.get(Uri.parse("$getUserUrl?email=$email"));
    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      if (list != null) {
        var model = UserModel().fromJson(list);
        return model;
      } else {
        return UserModel();
      }
    } else {
      return UserModel();
    }
  }

  Future<void> postCheckIn({
    @required String checkInTime,
    @required String checkOutTime,
    @required String phoneNumber,
    @required String date,
    @required String companyId,
  }) async {
    var postCheckInUrl = Uri.parse(
        'https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugPostCheckIn');

    var response = await http.post(postCheckInUrl, body: {
      'checkin': checkInTime,
      'checkout': checkOutTime,
      'refid': phoneNumber,
      'date': date,
      'companyid': companyId,
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
      return json.decode(response.body);
    } else {
      return;
    }
  }

  Future<void> postCheckInRequest({
    @required String phoneNumber,
    @required String date,
    @required String lat,
    @required String lon,
    @required String name,
    @required String companyId,
  }) async {
    var postCheckInRequestUrl = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugPostCheckInRequest");

    var response = await http.post(postCheckInRequestUrl, body: {
      'refid': phoneNumber,
      'date': date,
      'status': 'pending',
      'lat': lat,
      'lon': lon,
      'name': name,
      'companyid': companyId,
    });
    if (response.statusCode == 200) {
      return;
    } else {
      Fluttertoast.showToast(msg: response.body);
      return;
    }
  }

  Future<void> postOuterGeoList({
    @required String phoneNumber,
    @required String date,
    @required String lat,
    @required String lon,
    @required String companyId,
  }) async {
    var postCheckInRequestUrl = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugPostOuterGeoList");

    var response = await http.post(postCheckInRequestUrl, body: {
      'refid': phoneNumber,
      'date': date,
      'lat': lat,
      'lon': lon,
      'companyid': companyId,
    });
    if (response.statusCode == 200) {
      return;
    } else {
      Fluttertoast.showToast(msg: response.body);
      return;
    }
  }

  Future<List<CoursesModel>> getCourses(String companyId) async {
    var getCoursesUrl = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugGetCourses?companyId=$companyId");

    var response = await http.get(getCoursesUrl);

    if (response.statusCode == 200) {
      List courseList = json.decode(response.body);
      Iterable<CoursesModel> courses = courseList.map((e) {
        return CoursesModel().fromJson(e);
      });
      return courses.toList();
    } else {
      return null;
    }
  }

  Future<List<LeaveRequestsModel>> getLeaveRequests(String companyId) async {
    var getLeaveRequestsUrl = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugGetLeaveRequests?companyId=$companyId");

    var response = await http.get(getLeaveRequestsUrl);

    if (response.statusCode == 200) {
      List leaveRequestsList = json.decode(response.body);
      Iterable<LeaveRequestsModel> leaveRequests = leaveRequestsList.map((e) {
        return LeaveRequestsModel().fromJson(e);
      });
      return leaveRequests.toList();
    } else {
      return null;
    }
  }

  Future<void> postLeaveRequest(String phoneNumber, String date, String title,
      List details, String companyId) async {
    var postLeaveRequestUrl = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugPostLeaveRequest?refid=$phoneNumber&date=$date");

    var response = await http.post(
      postLeaveRequestUrl,
      body: {
        'title': title,
        'details': details.toString(),
        'verify': 0,
        'companyid': companyId,
      },
    );
    if (response.statusCode == 200) {
      return;
    } else {
      return;
    }
  }

  Future<UserModel> getemployeeBenchList({@required String name}) async {
    var url = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugGetEmployeeBenchList?name=$name");
    var response = await http.get(url);

    var employeeDetailsJSON = json.decode(response.body);
    if (employeeDetailsJSON != "no details found") {
      var employeeDetails = UserModel().fromJson(employeeDetailsJSON);
      return employeeDetails;
    } else {
      return null;
    }
  }

  Future<dynamic> postBenchList({
    @required UserModel userModel,
    @required UserModel replacementUserModel,
    @required String jobDescription,
    @required String replacementType,
    String fromDate,
    String toDate,
  }) async {
    var url = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugPostBenchlist");
    var response = await http.post(url, body: {
      'user_empid': userModel.empId,
      'user_name': userModel.name,
      'user_phone': userModel.phoneNumber,
      'replacement_empid': replacementUserModel.empId,
      'replacement_name': replacementUserModel.name,
      'replacement_phone': replacementUserModel.phoneNumber,
      'replacement_address': replacementUserModel.address,
      'replacement_allotedOffice': replacementUserModel.allotedOffice,
      'replacement_designation': replacementUserModel.designation,
      'replacement_email': replacementUserModel.email,
      'replacement_manager': replacementUserModel.manager,
      'replacement_refId': replacementUserModel.refId,
      'job_description': jobDescription,
      'replacement_type': replacementType,
      'from': fromDate,
      'to': toDate,
      'verify': '0',
      'benchid': DateTime.now().microsecond.toString(),
      'companyid': replacementUserModel.companyId,
      'timestamp': DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()),
    });
    if (response.statusCode != 200) {
      return 'Request failed';
    } else {
      return 'Success';
    }
  }

  Future<List<RelatedSitesModel>> getRelatedSites() async {
    var url = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugGetRelatedSites");
    var response = await http.get(url);
    var body = json.decode(response.body);
    if (body != '[]') {
      List relatedSitesList = body;
      Iterable<RelatedSitesModel> relatedSites = relatedSitesList.map((e) {
        return RelatedSitesModel().fromJson(e);
      });
      return relatedSites.toList();
    } else {
      return null;
    }
  }

  Future<List<AttendanceReportModel>> getCheckInHistory({
    @required String empId,
    @required String companyId,
    @required String status,
  }) async {
    var url = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugGetCheckInHistory?empId=$empId&companyId=$companyId&status=$status");
    var response = await http.get(url);
    var body = json.decode(response.body);
    if (response.statusCode == 200 && body != '[]') {
      List checkInHistoryList = body;

      Iterable<AttendanceReportModel> checkInHistory =
          checkInHistoryList.map((e) {
        return AttendanceReportModel().fromJson(e);
      });
      return checkInHistory.toList();
    }
    return null;
  }

  Future<void> postEnquiry({
    @required String subject,
    @required String description,
    @required String employeeId,
    @required String companyId,
    @required String email,
    @required String password,
  }) async {
    var url = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugPostEnquiry");
    var response = await http.post(
      url,
      body: {
        'empid': employeeId,
        'companyid': companyId,
        'subject': subject,
        'description': description,
        'email': email,
        'password': password,
        'timestamp': DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()),
      },
    );
    if (response.statusCode != 200) {
      return;
    }
  }

  Future<List<BenchListModel>> getBenchListRequests({
    @required String verify,
    @required String companyId,
    @required String empId,
  }) async {
    var url = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugGetBenchListRequests?verify=$verify&companyId=$companyId&empId=$empId");
    var response = await http.get(url);
    var body = json.decode(response.body);
    if (response.statusCode == 200 && body != '[]') {
      List requestList = body;
      Iterable<BenchListModel> request = requestList.map((e) {
        return BenchListModel().fromJson(e);
      });
      return request.toList();
    } else {
      return null;
    }
  }

  Future<dynamic> postAdminLeave({
    @required String days,
    @required String refId,
    @required String employeeName,
    @required String companyId,
    @required String verify,
  }) async {
    var url = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugPostAdminLeave");
    var response = await http.post(url, body: {
      'days': days,
      'refid': refId,
      'employee_name': employeeName,
      'companyid': companyId,
      'verify': verify,
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200 && body == 'success') {
      return 'success';
    } else {
      return 'failed';
    }
  }

  Future<List<AdminLeavesModel>> getAdminLeaves({
    @required String verify,
    @required String companyId,
    @required String refId,
  }) async {
    var url = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugGetAdminLeaves?verify=$verify&companyId=$companyId&refId=$refId");
    var response = await http.get(url);
    var body = json.decode(response.body);
    if (body != '[]' && response.statusCode == 200) {
      List responseList = body;
      Iterable<AdminLeavesModel> adminLeaves = responseList.map((e) {
        return AdminLeavesModel().fromJson(e);
      });
      return adminLeaves.toList();
    } else {
      return null;
    }
  }

  Future<void> postAttendanceReport({
    @required String empId,
    @required String companyId,
    @required String status,
    @required String checkOutDifference,
    @required String checkInDelayInHours,
    @required String checkInDelayInMinutes,
    @required String checkInTime,
    @required String checkOutTime,
    @required String employeeName,
  }) async {
    var url = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugPostAttendanceReport");
    var response = await http.post(
      url,
      body: {
        'empid': empId,
        'companyid': companyId,
        'status': status,
        'check_out_difference': checkOutDifference,
        'check_in_delay_in_hours': checkInDelayInHours,
        'check_in_delay_in_minutes': checkInDelayInMinutes,
        'timestamp': DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()),
        'checkin': checkInTime,
        'checkout': checkOutTime,
        'empname': employeeName,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      },
    );
    var body = json.decode(response.body);
    if (body == "null" || response.statusCode != 200) {
      return;
    }
  }

  Future<List<UserModel>> getAllUsers({@required String companyId}) async {
    var url =
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugGetUsers?companyid=$companyId";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List requestList = json.decode(response.body);
      Iterable<UserModel> requests = requestList.map((e) {
        return UserModel().fromJson(e);
      });
      return requests.toList();
    } else {
      return null;
    }
  }

  Future<List<AnnounceModel>> getAnnounce({@required String companyId}) async {
    var getAnnounceUrl = Uri.parse(
        "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-ffegf/service/getuser/incoming_webhook/debugGetAnnouncements?companyid=$companyId");

    var response = await http.get(getAnnounceUrl);

    if (response.statusCode == 200) {
      List announceList = json.decode(response.body);

      Iterable<AnnounceModel> announce = announceList.map((e) {
        return AnnounceModel().fromJson(e);
      });
      return announce.toList();
    } else {
      return null;
    }
  }
}
